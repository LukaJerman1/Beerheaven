const frontend = require("express").Router();
const session = require("express-session");
const passport = require("passport");
const configPassport = require("./helpers/passport-config");
const ws = require("./services/beerheaven");
const files = require("express-fileupload");

const { ViewModel, newDefaultViewModel } = require("./models/view");
const { MenuModel, TopMenu } = require("./models/menu");

//init common handlers
frontend.use(
  session({
    secret: "pivo", //process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false,
  })
);
/*
frontend.use(passport.initialize());
frontend.use(passport.session());
*/
frontend.use(files());

//funkciji, ki poiščeta uporabnika
const getUserByEmail = async (email) => {
  try {
    //vrne array
    let users = await ws.get("/user?email=" + email);
    return users !== null && users.length == 1 ? users[0] : null;
  } catch (error) {
    console.log(error.message);
  }
  return null;
};

const getUserById = async (id) => {
  try {
    //vrne enega ali nič
    let user = await ws.get("/user/" + id);
    return user;
  } catch (error) {
    console.log(error.message);
  }
  return null;
};

//config passport
configPassport(passport, getUserByEmail, getUserById);

//add routers
frontend.use(
  "/",
  require("./routers/user"),
  require("./routers/brewery"),
  require("./routers/forum"),
  require("./routers/answers")
);

/* GET "home" root page or error if not exists (TODO: add favcion.ico to public) */
frontend.get("/*", function (req, res, next) {
  let model = newDefaultViewModel(
    "Dobrodošli v pivskih nebesih :)",
    req
  );
  model.menu.top.home.selected = true;

  
  /* Tako lahko v model (podatkovni objekt) za naš template dodamo še poljubne druge stvari .. 
   * Npr. če se uporabnik imenuje "Test", mu bomo izpisali posebno obvestilo
   * (obvestilo shranimo kot atribut podatkovnega objekta z imenom "special_message")
   * glej /templates/views/pages/home.html kako ta atribut uporabimo
   */
  /*
  let user = req.session.user;
  if (user && user.last_name === "Test") {
    data.special_message = "To pa ne bo šlo";
  }
  */

  if (model.page.path != "") {
    model.addError("Stran ne obstaja.");
    //TODO: change to "error" when error page template is ready
    //res.render("home", model.build());
    res.status(404).send("Stan " + model.page.path + " ne obstaja.");
  } else 
  {
    res.render("pages/home", model.build());
  }
});
module.exports = frontend;
