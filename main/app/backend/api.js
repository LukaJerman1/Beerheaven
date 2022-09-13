var api = require("express").Router();
var tutorials = require("./routers/tutorials");
var cors = require("cors");

//enable CORS for API calls
api.use(cors());

//add routers
api.use(
  "/",
  require("./routers/tutorials"),
  require("./routers/user"),
  require("./routers/brewery"),
  require("./routers/forum"),
  require("./routers/answers")
);

//default router when endpoint was not handled by any previous routers
api.use((req, res, next) => {
  res.status(404).send("Končna točka " + req.originalUrl + " ne obstaja.");
});

module.exports = api;
