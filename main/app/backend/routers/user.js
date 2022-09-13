const router = require('express').Router();
const { bookshelf } = require('../db');
const db = require('../db');
const Users = db.entity.Users;

router.get('/users', async function(req, res, next) {
    try {
      let users = await new db.entity.Users().fetchAll();
      res.json(users.toJSON());
    } catch(error){
        res.status(500).json(error);
    }
});

router.get('/user/:id', async function(req, res, next) {
  try {
    let user = await db.entity.Users.forge().where({id: req.params.id}).fetch({ require: false, withRelated: ['brewery']});
    res.json(user.toJSON({ hidden: ['_pivot_id_brewery', 'id_brewery']}));
  } catch (error) {
    res.status(500).json(error);
  }
});

router.get('/user', async function(req, res, next) {
  try {
    let user = await db.helper.findBy(Users, req.query);
    res.json(user.toJSON());
  } catch (error) {
    res.status(500).json(error);
  }
});

router.post('/user', async function(req, res, next) {
  try {
    Users.forge({
      email: req.body.email,
      password: req.body.password,
      first_name: req.body.first_name,
      last_name: req.body.last_name
    }).save().then((user) => {
      res.json(user.toJSON());
    });
  } catch(error){
      res.status(500).json(error);
  }
});  

module.exports = router;