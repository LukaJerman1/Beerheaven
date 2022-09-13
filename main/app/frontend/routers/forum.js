const router = require("express").Router();
const ws = require("../services/beerheaven");
const auth = require("../helpers/auth");
const getUser = auth.getUser;

const { ViewModel, newDefaultViewModel } = require("../models/view");
const { MenuModel, TopMenu } = require("../models/menu");

const PAGE_TITLE = "BeerHeaven - Q&A";

//metoda bo s sinhronim klicem ws, ker strani itak ne moremo prikazati dokler ne dobimo vseh podatkov.
router.get(
  "/forum" /*, auth.requireRegisteredUser*/,
  async function (req, res, next) {
    //try-catch potrebujemo zaradi ws
    try {
      let response = await ws.get("/questions");
      let model = newDefaultViewModel(PAGE_TITLE, req, {
        questions: response.data,
      });
      model.menu.top.forum.selected = true;
      res.render("pages/forum", model.build());
    } catch (error) {
      res.status("404").send("Napaka " + error);
    }
  }
);

//save question data from the body
router.post("/question", function (req, res, next) {
  let tmp = new Date().toISOString();
  let date = tmp.substr(0, 10) + " " + tmp.substr(11, 8);
  let user = getUser(req);
  ws.post("/question", {
    user_id: user ? user.id : null,
    title: req.body.question,
    txt: req.body.question,
    likes: 0,
    views: 0,
    comments: 0,
    activity: date,
  })
    .then((response) => {
      res.redirect("/forum");
    })
    .catch((error) => {
      //not found
      res.status("404").send("Napaka " + error);
    });
});

//primer error handlinga
router.get("/question/delete/:id", async function (req, res, next) {
  let model = newDefaultViewModel(PAGE_TITLE, req);
  try {
    let response = await ws.delete("/question/" + req.params.id);
    model.addError({
      type: "info",
      title: "Brisanje je bilo uspešno",
      message: "Vprašanje (id=" + response.data.id + ") je bilo izbrisano.",
    });
  } catch (error) {
    model.addError({
      type: "debug",
      title: "Ne morem izbrisati vprašanja.",
      message: error.message,
    });
  }
  try {
    let response = await ws.get("/questions");
    model.setData({ questions: response.data });
  } catch (error) {
    model.addError({
      type: "debug",
      title: "Ne morem pridobiti vprašanj.",
      message: error.message,
    });
    res.render("pages/error", mode.build());
  }
  model.menu.top.forum.selected = true;
  res.render("pages/forum", model.build());
});

//prikaže vse odgovore na zastavljeno vprašanje
router.get("/question/:id", async (req, res, next) => {
  let model = newDefaultViewModel(PAGE_TITLE, req);
  let data = {};

  //get question data
  try {
    response = await ws.get("/question/" + req.params.id);
    data.question = response.data;
  } catch (error) {
    model.addError({
      type: "error",
      title:
        "Napaka pri iskanju podatkov o vprašanju (id=" + req.params.id + ")",
      message: error.message,
    });
    res.render("pages/error", model.build());
  }

  //get answers
  try {
    response = await ws.get("/answers/question/" + req.params.id);
    data.answers = response.data;
  } catch (error) {
    model.addError({
      type: "error",
      title:
        "Napaka pri iskanju odgovorov na vprašanje (id=" + req.params.id + ")",
      message: error.message,
    });
    res.render("pages/error", model.build());
  }

  try {
    let tmp = new Date().toISOString();
    let date = tmp.substr(0, 10) + " " + tmp.substr(11, 8);
    const views = data.question.views + 1;
    ws.put("/question/" + req.params.id, {
      user_id: response.data.user_id,
      title: response.data.title,
      txt: response.data.txt,
      likes: response.data.likes,
      views: views,
      comments: data.answers.length,
      activity: date,
    });
  } catch (error) {
    console.log(error);
  }
  model.menu.top.forum.selected = true;
  model.setData(data);
  data = model.build();
  res.render("pages/answers", data);
});

module.exports = router;
