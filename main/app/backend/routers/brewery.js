const router = require("express").Router();
const { response } = require("express");
const db = require("../db");
const Brewery = db.entity.Brewery;

router.get("/breweries/user/:id", async function (req, res, next) {
  try {
    await db.helper.findBy(Brewery, { user_id : req.params.id }).then((breweries) => {
      res.json(breweries.toJSON());
    });
  } catch (error) {
    res.status(500).json(error);
  }
});

router.get("/breweries", async function (req, res, next) {
  try {
    
    let model = db.entity.Brewery.forge();
    //podpora za "opened" query atribut
    let withOpened = 'opened' in req.query || 'open' in req.query;
    let withUser = 'user' in req.query;
    if (withOpened) {
      model = model
        ?.where('dat_opened', 'is not', null)
        ?.where('dat_closed', 'is', null);
    }
    if (withUser && req.query.user !== null) {
      model = model
        ?.where('user_id', req.query.user);
    }
    let results = await model.fetchAll();
    if (!results.length) {
      res.json([]);
    } else {
      res.json(results.toJSON());
    }
  } catch (error) {
    res.status(500).json(error);
  }
});

router.get("/brewery/:id(\\d+)", async function (req, res, next) {
  try {
    let brewery = await db.helper.findBy(db.entity.Brewery, { id: req.params.id }, {}, false);
    if (!brewery) {
      res.status(404).send("Pivovarne ni mogoče najti.");
    } else {
      res.json(brewery.toJSON()); 
    }
  } catch(error){
      res.status(500).json(error);  
  }
});

router.post("/brewery", function (req, res, next) {
    db.entity.Brewery.forge({
      name: req.body.name,
      user_id: req.body.user_id,
      dat_opened: req.body.dat_opened,
      dat_closed: req.body.dat_closed,
    }).save().then((result) => {
      //shranimo pivovarno kot aktualno za uporabnika
      db.entity.Users.forge({
        id: req.body.user_id, 
        id_brewery: result.get('id')}
      ).save();
      res.json(result.toJSON());
    }).catch((error) => {
      res.status(500).json(error);
    });
});

router.delete("/brewery/:id(\\d+)", async function (req, res, next) {
  try {
    let obj = await db.helper.deleteById(db.entity.Brewery, req.params.id, res);
    if (obj == null) {
      res
        .status(404)
        .send("Pivovarne id=" + req.params.id + " ni mogoče najti.");
    } else {
      res.json(obj.toJSON());
    }
  } catch (error) {
    res.status(500).json(error);
  }
});

router.put("/brewery/:id(\\d+)", async (req, res, next) => {
  try {
    let result = await db.helper.update(db.entity.Brewery, { id: req.params.id}, req.body, false);
    res.json(result.toJSON());
  } catch (error) {
    res.status(500).json(error);
  }
});

module.exports = router;
