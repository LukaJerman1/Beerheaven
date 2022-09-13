const router = require('express').Router();
const ws = require('../services/beerheaven');
const { requireRegisteredUser, getUser } = require('../helpers/auth');

const { ViewModel, newDefaultViewModel, newDefaultErrorViewModel } = require("../models/view");
const { MenuModel, TopMenu } = require('../models/menu');
const db = require('../../backend/db');
const { get } = require('../../backend/api');
const getDateNow = require('../../common/helper').getDateNow;

//helpers

const allTutorialsDone = (tutorials) => {
  tutorials.map((t) => {
    if (!t.status.completed)
      return false;
  });
  return true;
};

//preusmeri na pivovarno uporabnika, sicer na vse pivovarne
router.get('/brewery', requireRegisteredUser({login:true, redirect: '/brewery'}), async function(req, res, next) {
  let user = getUser(req);
  if (!user) {
    res.redirect('/breweries');
    return;
  } 
  //če ima določeno pivovarno, ga usmerimo na njo
  if (user.id_brewery) {
    res.redirect('/brewery/' + user.id_brewery);
    return;
  }
  //sicer se preusmerimo na stran za dodajanje pivovarne za uporabnika
  res.redirect('/brewery/add');
});

//važen vrstni red!!

//zaženemo ali končamo
router.get('/tutorial/:tid(\\d+)/brewery/:bid(\\d+)/:act(\\w+)', async (req, res, next) => {
  
  let bid = req.params.bid;
  let tid = req.params.tid;
  let act = req.params.act;
  
  try {
    await ws.put('/tutorial/' + tid + '/brewery/' + bid + '/' + act);
  } catch (error) {
    let model = newDefaultErrorViewModel(req, [
      {type: "error", title: "Napaka pri ukazu za vadnico: " + act.toUpperCase(), message: error.message}
    ]);
    res.render('pages/error', model.build());
    return;
  }
  res.redirect('/tutorial/' + tid + '/brewery/' + bid);
});

router.get('/brewery/:id/open', requireRegisteredUser({login: true, redirect: '/brewery'}), async (req, res, next) => {
  try {
    let user = getUser(req);
    let result = ws.put('/brewery/' + req.params.id, { dat_closed: null, dat_opened: getDateNow()});
    res.redirect('/brewery/' + req.params.id);
  } catch (error) {
    let model = newDefaultErrorViewModel(req, [
      {type: "error", title: "Pivovarne ni mogoče odpreti", message: error.message}
    ]);
    res.render('pages/error', model.build());
  }
});

router.get('/brewery/:id/close', requireRegisteredUser({login: true, redirect: '/brewery'}), async (req, res, next) => {
  try {
    let user = getUser(req);
    let result = ws.put('/brewery/' + req.params.id, { dat_closed: getDateNow(), dat_opened: null});
    res.redirect('/brewery/' + req.params.id);
  } catch (error) {
    let model = newDefaultErrorViewModel(req, [
      {type: "error", title: "Pivovarne ni mogoče zapreti", message: error.message}
    ]);
    res.render('pages/error', model.build());
  }
});

router.get('/brewery/add', requireRegisteredUser({login: true, redirect: '/brewery'}), async (req, res, next) => {
  
  let model = newDefaultViewModel("Ustvarite novo pivovarno", req, {
    add: true
  });
  
  model.page.intro = 'Za nova, nepozabna doživetja';
  model.menu.top.brewery.selected = true;
  res.render('pages/brewery', model.build());
});

//vadnica za pivovarno
router.get('/tutorial/:tutorial_id(\\d+)/brewery/:brewery_id(\\d+)', async function(req, res, next) {
  
  let tutorial = null;
  let user = getUser(req);

  try {
    let result = await ws.get('/tutorial/' + req.params.tutorial_id + "/brewery/" + req.params.brewery_id);
    tutorial = result.data;
  } catch (error) {
    res.render("pages/error", newDefaultErrorViewModel(req, [
      {type: "error", title: "Pridobivanje podatkov o vadnici", message: error.message}
    ]).build());
  }

  //še podatke o pivovarni
  try {
    let result = await ws.get('/brewery/' + req.params.brewery_id);
    tutorial.brewery = result.data;
  } catch (error) {
    res.render("pages/error", newDefaultErrorViewModel(req, [
      {type: "error", title: "Napaka pri pridobvianju podatkov o pivovarni za vadnico", message: error.message}
    ]).build());
  }

  //pa podatke o elementih
  try {
    let result = await ws.get('/tutorial/' + tutorial.id + '/brewery/' + tutorial.brewery.id + '/elements');
    tutorial.elements = result.data;
    //priredimo html src
    for (i=0;i<tutorial.elements.length;i++) {
      tutorial.elements[i].src = "data:" + tutorial.elements[i].mime + ";base64," + tutorial.elements[i].blob_val;
    }
  } catch (error) {
    res.render("pages/error", newDefaultErrorViewModel(req, [
      {type: "error", title: "Napaka pri pridobvianju podatkov o elementih za vadnico", message: error.message}
    ]).build());
  }

  //status pivovarne
  tutorial.brewery.status = 
  {
    ismy:  user && user.id == tutorial.brewery.user_id ? true : false,
    isdone: tutorial.brewery.dat_opened || tutorial.brewery.dat_closed ? true : false
  }
  
  //ažuriramo statuse vadnic
  tutorial.status.enabled = tutorial.status.enabled && (tutorial.brewery.status.ismy || tutorial.status.finished);
  tutorial.status.mayStart = tutorial.brewery.status.ismy && tutorial.status.ready;
  tutorial.status.mayFinish = tutorial.brewery.status.ismy && tutorial.status.running && tutorial.elements.length > 0;
  tutorial.status.mayContinue = tutorial.brewery.status.ismy && tutorial.status.lastfinished && tutorial.id_nxt;
  tutorial.status.mayUpload = tutorial.brewery.status.ismy && tutorial.status.running;

  let model = newDefaultViewModel("Vadnica", req, { tutorial });
  if (user)
    model.menu.top.brewery.selected = true;
  else 
    model.menu.top.breweries.selected = true;
  model.page.intro = "Z opravljeno vadnico ste korak bliže svoji pivovarni";
  
  let data = model.build();
  res.render("pages/tutorial", data);
});


//prikaz pivovarne
router.get('/brewery/:id(\\d+)', async function(req, res, next) {

  //pridobimo podatke o pivovarni
  let brewery = null;

  try {
    let response = await ws.get("/brewery/" + req.params.id);
    brewery = response.data;  
  } catch (error) {
    res.status('404').send('Napaka pri pridobivanju pivovarne: ' + error);
  }

  //če takšne pivovarne ni
  if (!brewery) {
    let model = newDefaultErrorViewModel(req, [{type:"error", title:"Napaka pri pridobivanju podatkov o pivovarni", message: "Pivovarna (" + req.params.id + ") ne obstaja."}]);
    res.render("pages/error", model.build());
  }
  
  let user = getUser(req);

  //malo dopolnimo statuse
  brewery.status = {
    ismy: user && (user.id == brewery.user_id) ? true : false,
    isdone: true
  };

  //dodamo vadnice
  try {
    let response = await ws.get('/tutorials/brewery/' + brewery.id);
    brewery.tutorials = response.data;
    //še dodatni statusi
    brewery.status.isdone = true;
    for (i=0; brewery.tutorials && i<brewery.tutorials.length; i++) {
      //ali lahko odpremo vadnico (če je enabled  in je naša ali pa finished)
      brewery.status.isdone = brewery.status.isdone && brewery.tutorials[i].status.finished;
      brewery.tutorials[i].status.enabled = brewery.tutorials[i].status.enabled && (brewery.status.ismy || brewery.tutorials[i].status.finished);
      brewery.tutorials[i].status.active = brewery.tutorials[i].status.active && brewery.status.ismy;
    }
  } catch (error) {
    res.status('404').send('Napaka pri pridobivanju vadnic za pivovarno.')
  }

  //dodamo ostale uporabnikove pivovarne
  if (user) {
    try {
      let response = await ws.get('/breweries?user=' + user.id);
      brewery.my = response.data;
      //odstranimo trenutno
      for (i=0; brewery.my && i < brewery.my.length; i++) { 
        if (brewery.my[i].id == brewery.id) {
          brewery.my.splice(i, 1);
          break;
        }
      }
    } catch (error) {
      res.status('500').send('Napaka pri pridobivanju vadnic za uporabnika');
    }
  }

  //pripravimo model
  model = newDefaultViewModel(brewery.name, req, { brewery: brewery });
  if (model.menu.top.brewery) 
    model.menu.top.brewery.selected = brewery.status.ismy;
  model.menu.top.breweries.selected = !brewery.status.ismy;
  model.page.intro = "Dobrodošli v pivovarni";
  
  let data = model.build();
  res.render("pages/brewery", data);
});

//seznam vseh odprtih pivovarn z osnovimi podatki, ocenami, .. 
router.get('/breweries', async function(req, res, next) {
  let model = newDefaultViewModel("Seznam odprtih pivovarn", req, { breweries: null });
  let own = 'user' in req.query ? true : false;
  try {
    let response = null;
    if (own && !getUser(req)) {
      res.redirect('/login?redirect=' + encodeURI('/breweries?user'));
      return;
    } 
    if (own) {
      let user = getUser(req);
      response = await ws.get('/breweries?user=' + user.id);
    } else  {
      response = await ws.get('/breweries?opened');
    }
    model.data.breweries = response.data;
  } catch (error) {
    if (error.status !== 404) {
      res.render("pages/error", newDefaultErrorViewModel(req, [
        {type: "error", title: "Pridobivanje podatkov o pivovarnah", message: error.message}
      ]).build());
    }
  }
  if (own) {
    model.menu.top.brewery.selected = true;
    model.page.title = 'Seznam mojih pivovarn'
  } else {
    model.menu.top.breweries.selected = true;
  }
  let data = model.build();
  res.render("pages/breweries", data);
});

router.post('/brewery', requireRegisteredUser({login: true, redirect: '/brewery/add'}), function(req, res, next) {
  ws.post('/brewery', { 
    name: req.body.name, 
    user_id: getUser(req).id
  }).then((response) => {
    //shranimo novo lastništvo pivovarne uporabniku (mora se tudi v bazi)
    if (req.session.user.id == response.data.user_id) {
      req.session.user.id_brewery = response.data.id;
    }
    res.redirect('/brewery/' + response.data.id);
  }).catch((error) => {
    //not found
    res.status('404').send('Napaka ' + error);
  });
});

router.post('/tutorial/upload', async (req, res, next) => {
  let bid = req.body.bid;
  let tid = req.body.tid;
  let file = req.files.file;
  if (!bid || !tid || !file) {
    res.status(500).send('Potrebujem vadnico in pivovarno ter datoteko.');
    return;
  }
  //pretvorimo v base64encoded, če file obstaja
  let data = Buffer.from(file.data).toString('base64');
  try{
    let response = await ws.post('/tutorial/upload', 
    {
      bid,
      tid,
      name: req.body.name,
      filename: file.name,
      mime: file.mimetype,
      type: "",
      context: "",
      data: data
    });
    console.log("New element id: " + response.id);
  } catch (error) {
    res.status(500).send('Napaka: ' + error.message);
  }
  res.redirect('/tutorial/' + tid + '/brewery/' + bid);
});

module.exports = router;