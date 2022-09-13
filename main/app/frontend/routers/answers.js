const router = require("express").Router();
const ws = require("../services/beerheaven");
const auth = require("../helpers/auth");

const { ViewModel, newDefaultViewModel } = require("../models/view");
const { MenuModel, TopMenu } = require("../models/menu");
const { getUser } = require("../helpers/auth");

const PAGE_TITLE = "BeerHeaven - Q&A";

router.get("/answer/delete/:id", async function (req, res, next) {
  let model = newDefaultViewModel(PAGE_TITLE, req);
  try {
    let result = await ws.delete("/answer/" + req.params.id);
    res.redirect("/question/" + result.data.question_id);
  } catch (error) {
    model.addError({
      type: "error",
      title: "Napaka pri brisanju odgovora (id=" + req.params.id + ")",
      message: error.message,
    });
    res.render("pages/error", model.build());
  }
});

router.get("/question/like/:id", async function (req, res, next) {
  try {
    let tmp = new Date().toISOString();
    let date = tmp.substr(0, 10) + " " + tmp.substr(11, 8);

    ws.get("/question/" + req.params.id)
      .then((response) => {
        const like = response.data.likes + 1;
        ws.put("/question/" + req.params.id, {
          user_id: response.data.user_id,
          title: response.data.title,
          txt: response.data.txt,
          likes: like,
          views: response.data.views,
          comments: response.data.comments,
          activity: date,
        });
      })
      .catch((error) => {
        //not found
        res.status("404").send("Napaka " + error);
      });
  } catch (error) {}
});

//shrani odgovor za vprašanje
router.post("/answer", async function (req, res, next) {
  let model = newDefaultViewModel(PAGE_TITLE, req);
  try {
    let user = getUser(req);
    let user_id = user ? user.id : null;
    let response = await ws.post("/answer", {
      user_id,
      question_id: req.body.question_id,
      txt: req.body.answer,
    });
    model.addError({
      type: "info",
      title: "Dodajanje odgovorov",
      message: "Odgovor je bil dodan.",
    });
  } catch (error) {
    model.addError({
      type: "error",
      title:
        "Napaka pri vstavljanju odgovora za vprašanje (id=" +
        req.body.question_id +
        ")",
      message: error.message,
    });
    res.render("pages/error", model.build());
  }
  res.redirect("/question/" + req.body.question_id);
});

module.exports = router;
