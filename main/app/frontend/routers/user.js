const router = require('express').Router();
const ws = require('../services/beerheaven');
const bcrypt = require('bcrypt');
const passport = require('passport');

const { ViewModel, newDefaultViewModel } = require("../models/view");
const { MenuModel, TopMenu } = require('../models/menu');


//prikaže stran za prijavo
router.get('/login', function(req, res, next) {
  //resetiramo uporabnika
  req.session.user = null;
  let model = newDefaultViewModel(
    "BeerHeaven - Prijava",
    req
  );
  model.menu.top.login.selected = true;
  model.params.query.redirect = req.query.redirect;
  res.render('pages/login', model.build());
});

//Prijavi uporabnika
//TODO: logiko lahko damo v auth.js
router.post('/login', async (req, res, next) => {
  //resetiramo uporabnika
  req.session.user = null;
  //pripravimo podatke za prikaz
  let model = newDefaultViewModel(
    "BeerHeaven - Prijava",
    req
  );
  model.menu.top.login.selected = true; 
  let user = null;
  try
  {
    //poiščemo uporabnika z API klicem
    result = await ws.get('/user?email=' + req.body.email);
    if (!result.data.length) {
      model.addError({type: "error", title: "Napaka pri prijavi", message: "Uporabnik s tem e-naslovom ne obstaja."});
    } else {
      user = result.data[0];
      //preverimo geslo, če ni pravilno dodamo napako
      if (!await bcrypt.compare(req.body.password, user.password)) {
        user = null;
        model.addError({type: "error", title: "Napaka pri prijavi", message: "Geslo je napačno."});
      }
    }
  } catch (error) {
    //dodamo napako  
    model.addError({type: "error", title: "Napaka pri prijavi", message: error.message})
  }
  //če smo našli uporabnika, ga shranimo v sejo in se vrnemo na domačo stran
  if (user) {
    req.session.user = user;
    if (req.query.redirect)
      res.redirect(decodeURI(req.query.redirect));
    else 
      res.redirect('/');
  } else {
    //ponovno naložimo login
    res.render('pages/login', model.build());
  }
});

//odjavi uporabnika
router.get('/logout', function(req, res, next) {
  //resetiramo uporabnika
  req.session.user = null;
  res.redirect('/');
});

//prikaže stran za registracijo
router.get('/register', function(req, res, next) {
  let model = newDefaultViewModel(
    "BeerHeaven - Registracija",
    req
  );
  model.menu.top.login.selected = true; 
  res.render('pages/register', model.build());
});

//registrira uporabnika
router.post('/register', async function(req, res, next) {
  let model = newDefaultViewModel(
    "BeerHeaven - Registracija",
    req
  );
  model.menu.top.login.selected = true; 
  if (!req.body.password) {
    model.addError({type: "error", title: "Napaka", message: "Vnesti morate geslo."});
    res.render('pages/register', model.build());
    return;
  }
  
  //ali že obstaja?
  result = await ws.get('/user?email=' + req.body.email);
  if (result.data.length) {
    model.addError({type: "error", title: "Napaka pri registraciji.", message: "Uporabnik s tem e-naslovom že obstaja."});
    res.render('pages/register', model.build());
    return;
  };
  
  let password = await bcrypt.hash(req.body.password, 10);
  ws.post('/user', {
    email: req.body.email,
    password,
    first_name: req.body.first_name,
    last_name: req.body.last_name
  }).then((response) => {
    //če smo uspeli, naredimo redirect
    res.redirect('/login');
  }).catch((error) => {
    //sicer izpišemo isto stran z dodanimi sporočili o napaki
    model.addError({type: "error", title: "Napaka", message: "Napaka pri oddaji zahteve za registracijo."}); 
    console.log(error.message); 
    res.render('pages/user/register', model.build());
  });
  
});

module.exports = router;