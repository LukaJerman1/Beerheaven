const router = require("express").Router();
const db = require("../db");

//model
const Questions = db.entity.Questions;

/*
router.get("/questions", async function (req, res, next) {
  try {
    let questions = await Questions.fetchAll();
    res.json(questions.toJSON());
  } catch (error) {
    res.status(500).json(error);
  }
});
*/

router.get("/questions", async function (req, res, next) {
  try {
    let questions = await db.helper.findBy(Questions);
    if (questions === null) {
      res.status(404).send("Ni podatkov.");
    } else {
      res.json(questions.toJSON());
    }
  } catch (error) {
    res.status(500).json(error);
  }
});

router.post("/question", function (req, res, next) {
  try {
    //create model instance (forge) with parameters and save it
    let question = Questions.forge({
      user_id: req.body.user_id,
      title: req.body.title,
      txt: req.body.txt,
      likes: req.body.likes,
      views: req.body.views,
      comments: req.body.comments,
      activity: req.body.activity,
    })
      .save()
      .then((q) => {
        res.json(q.toJSON());
      });
  } catch (error) {
    res.status(500).json(error);
  }
});

router.get("/question/:id", async function (req, res, next) {
  try {
    //pazi! 4. parameter pove, da želimo samo 1 objekt, ne arraya
    let question = await db.helper.findBy(
      db.entity.Questions,
      { id: req.params.id },
      null,
      false
    );
    if (question === null) {
      res
        .status(404)
        .send(
          "Podatka o vprašanju (id=" + req.params.id + ") ni mogoče najti."
        );
    }
    // console.log(id_question.toJSON());
    res.json(question.toJSON());
  } catch (error) {
    res.status(500).json(error);
  }
});

router.delete("/question/:id", async function (req, res, next) {
  try {
    let obj = await db.helper.deleteBy(
      db.entity.Questions,
      { id: req.params.id },
      false
    );
    if (obj == null) {
      res
        .status(404)
        .send("Vprašanja id=" + req.params.id + " ni mogoče najti.");
    } else {
      res.json(obj.toJSON());
    }
  } catch (error) {
    res.status(500).json(error);
  }
});

router.put("/question/:id", async function (req, res, next) {
  try {
    let obj = await db.helper.update(
      db.entity.Questions,
      { id: req.params.id },
      {
        user_id: req.body.user_id,
        title: req.body.title,
        txt: req.body.txt,
        likes: req.body.likes,
        views: req.body.views,
        comments: req.body.comments,
        activity: req.body.activity,
      },
      false
    );

    if (obj == null) {
      res
        .status(404)
        .send("Vprašanja id=" + req.params.id + " ni mogoče najti.");
    } else {
      res.json(obj.toJSON());
    }
  } catch (error) {
    res.status(500).json(error);
  }
});

router.put("/question/:id", async function (req, res, next) {
  try {
    let obj = await db.helper.update(
      db.entity.Questions,
      { id: req.params.id },
      {
        user_id: req.body.user_id,
        title: req.body.title,
        txt: req.body.txt,
        likes: req.body.likes,
        views: req.body.views,
        comments: req.body.comments,
        activity: req.body.activity,
      },
      false
    );

    if (obj == null) {
      res
        .status(404)
        .send("Vprašanja id=" + req.params.id + " ni mogoče najti.");
    } else {
      res.json(obj.toJSON());
    }
  } catch (error) {
    res.status(500).json(error);
  }
});

module.exports = router;
