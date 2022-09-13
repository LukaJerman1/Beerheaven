const router = require('express').Router();
const db = require('../db');
const Tutorials = db.entity.Tutorials;
const getDateNow = require('../../common/helper').getDateNow;

//USE: https://forbeslindesay.github.io/express-route-tester/

//helpers
const getTutorials = async (brewery_id) => {
  //preberemo podatke za pivovarno
  let b = await db.entity.Brewery
    ?.forge()
    ?.where({id: brewery_id})
    ?.fetch({ require: false, withRelated: [{
      'tutorials' : function(qb) { qb.orderBy('ord', 'ASC'); }
    }]});
  b = b.serialize({ hidden: ['_pivot_brewery_id', '_pivot_tutorial_id']});

  //priredimo statuse za vadnice
  for (i=0; b.tutorials && i<b.tutorials.length; i++) {
    b.tutorials[i].id_pre             = i == 0 ? null : b.tutorials[i-1].id;
    b.tutorials[i].id_nxt             = i == b.tutorials.length - 1 ? null : b.tutorials[i+1].id;
    b.tutorials[i].status             = {};
    b.tutorials[i].status.started     = b.tutorials[i]._pivot_dat_started ? true : false;
    b.tutorials[i].status.finished    = b.tutorials[i]._pivot_dat_completed ? true : false;
    b.tutorials[i].status.running     = b.tutorials[i].status.started && !b.tutorials[i].status.finished;
    b.tutorials[i].status.ready       = (i == 0 || b.tutorials[i-1].status.finished) &&  !b.tutorials[i].status.started;
    b.tutorials[i].status.lastfinished= b.tutorials[i].status.finished && (i == b.tutorials.length - 1 || !b.tutorials[i+1]._pivot_dat_started);
    b.tutorials[i].status.enabled     = b.tutorials[i].status.finished || i == 0 || b.tutorials[i-1].status.finished;
    b.tutorials[i].status.active      = !b.tutorials[i].status.finished && (i == 0 || b.tutorials[i-1].status.finished);
  }
  return b;
};

const getTutorial = async (brewery_id, tutorial_id) => {
  let tutorials = getTutorials(brewery_id);
  tutorials.map((t) => {
    id (t.id == tutorial_id)
      return t;
  });
  return null;
};

// api/tutorials  
//path: /tutorial/start?bid=[brewery_id]&tid=[tutorial_id]
router.put('/tutorial/:tid(\\d+)/brewery/:bid(\\d+)/:action(\\w+)', async (req, res, next) => {
  let tid = req.params.tid;
  let bid = req.params.bid;
  let act = req.params.action;
  try {
    if (act == "start") {  
      await db.knex('brewery_tutorials')
        ?.update({ dat_started: getDateNow()})
        ?.where({ brewery_id: bid, tutorial_id: tid})
        ?.whereNull('dat_started');
      res.send(200);
    } else if (act == "stop") {
      let result = await db.knex('brewery_tutorials')
        ?.update({ dat_completed: getDateNow()})
        ?.where({ brewery_id: bid, tutorial_id: tid})
        ?.whereNull('dat_completed')
        ?.whereNotNull('dat_started');
      //če je zadnja vadnica, zaključimo pivovarno
      //najprej pridobimo zadnjo vadnico.
      result = await db.entity.Tutorials
        ?.forge()
        ?.where({id: tid})
        ?.orderBy('ord', 'ASC')
        ?.fetch({ require: false, withRelated: [{
          'breweries' : function(qb) { qb.where('id', tid); }
        }]});
      result = result.toJSON();
      res.send(200);
    }
  } catch (error) {
    res.status(500).send(JSON.stringify(error))
  }
});

//all tutorials, connected to specific brewery
//path: /tutorials?bid=[brewery_id]
router.get('/tutorials/brewery/:bid(\\d+)', async function(req, res, next) {
  try {
    let b = await getTutorials(req.params.bid);
    res.json(b.tutorials);
  } catch (error) {
    res.status(500).send(error.message);
  }
});

router.get('/tutorial/:tid(\\d+)/brewery/:bid(\\d+)/elements', async function(req, res, next) {
  try {
    let results = await db.knex.select('e.*').
      from('elements as e').
      join('brewery_tutorial_elements as bte', 'bte.element_id', 'e.id').
      where('bte.brewery_id', req.params.bid).
      where('bte.tutorial_id', req.params.tid);
    for (i=0; results && i<results.length; i++)
      results[i].blob_val = results[i].blob_val ? results[i].blob_val.toString('base64') : null; 
    res.json(results);
  } catch(error){
    res.status(500).send(JSON.stringify(error))
  }
});

//tutorial, connected to specific brewery
//path: /tutorial?bid=[brewery_id]&tid=][tutorial_id]
router.get('/tutorial/:tid(\\d+)/brewery/:bid(\\d+)$', async function(req, res, next) {
  //pokličemo vse tutoriale in potem izberemo pravega, ker se sicer ne more nastaviti status, ki ga potrebujemo
  try {
      let b = await getTutorials(req.params.bid);
      let t = null;
      for (i=0; !t && b && b.tutorials && i < b.tutorials.length; i++) {
        //pazi, samo dvojni enačaj, ker sta različna tipa!
        if (b.tutorials[i].id == req.params.tid)
          t = b.tutorials[i];
      }
      if (!t) {
        res.status(404).send("Vadnice ni mogoče najti.");
      }
      else {
        res.json(t);
      }
  } catch(error){
      res.status(500).send(JSON.stringify(error));
  }
});  

router.post('/tutorial/upload', async (req, res, next) => {
  if (!req.body.bid || !req.body.tid || !req.body.data) {
    res.status(500).send("Ni dovolj podatkov: bid, tid, data");
  }
  
  let element = null;
  
  //najprej z blobom
  try {
    let blob_val = await Buffer.from(req.body.data, 'base64');
    element = await db.entity.Elements.forge().save({
      type: req.body.type,
      name: req.body.name,
      mime: req.body.mime,
      blob_val: blob_val,
      context: req.body.context
    });
  } catch (error) {
    console.log("Z blobom: " + error.message);
    //vseeno vstavimo brez bloba, da imamo za demo
  }

  //brez bloba, če je potrebno
  if (element === null) {
    try {
      element = await db.entity.Elements.forge().save({
        type: req.body.type,
        name: req.body.name,
        mime: req.body.mime,
        blob_val: null,
        context: req.body.context
      });
    } catch (error) {
      console.log("Brez blob-a: " + error.message);
      //vseeno vstavimo brez bloba, da imamo za demo
    }
  }

  //če smo element vstavili, ga povežemo z vadnico.
  if (element !== null) {
    try {
      let result = await db.knex('brewery_tutorial_elements')
        ?.insert({ 
          brewery_id: req.body.bid,
          tutorial_id: req.body.tid,
          element_id: element.id
        });
      res.json(element.toJSON());
    } catch (error) {
      res.status(500).send("Napaka pri spovezavi elementa z vadnico: " + error.message);
    }
  } 
  else {
    res.status(500).send('Ne spravim tega kurca v bazo!!');
  }
});

module.exports = router;