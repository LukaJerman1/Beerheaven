const router = require("express").Router();
const db = require("../db");
const getUser= (req) => { return req.session.user; }

//model
const Questions = db.entity.Questions;
const Answers = db.entity.Answers;

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

router.get("/answers", async function (req, res, next) {
  try {
    let answers = await db.helper.findBy(Answers);
    if (answers === null) {
      res.status(404).send("Ni podatkov.");
    } else {
      res.json(answers.toJSON());
    }
  } catch (error) {
    res.status(500).json(error);
  }
});

router.post("/answer", function (req, res, next) {
  try {
    // console.log(req.body);
    //create model instance (forge) with parameters and save it
    let answer = Answers.forge({
      question_id: req.body.question_id,
      user_id: req.body.user_id,
      txt: req.body.txt,
    })
      .save()
      .then((q) => {
        res.json(q.toJSON());
      });
  } catch (error) {
    res.status(500).json(error);
  }
});

//vrne odgovore na zastavljeno vprašanje
router.get("/answers/question/:id", async function (req, res, next) {
  try {
    result = await db.helper.findBy(db.entity.Answers, {question_id: req.params.id});
    res.json(result.toJSON());
  } catch (error) {
    res.status(500).json(error);
  }
});

router.delete("/answer/:id", async function (req, res, next) {
  try {
    let obj = await db.helper.deleteBy(
      db.entity.Answers,
      { id: req.params.id },
      false
    );
    if (obj === null) {
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
