/**
 * INIT
 */
const knex = require("knex")({
  client: "mysql",
  connection: {
    host: "127.0.0.1",
    user: "bh",
    password: "bh123",
    database: "beerheaven",
  },
});

const bookshelf = require("bookshelf")(knex);

/**
 * ENTITIES
 */
const entities = {
  Tutorials: bookshelf.Model.extend({
    tableName: "tutorials",
    idAttribute: "id",
    breweries() {
      return this.belongsToMany(
        entities.Brewery,
        "brewery_tutorials",
        "tutorial_id",
        "brewery_id",
        "id",
        "id"
      ).withPivot(["dat_started", "dat_completed"]);
    },
  }),

  Users: bookshelf.Model.extend({
    tableName: "users",
    idAttribute: "id",
    brewery() {
      return this.hasOne(entities.Brewery, "id", "id_brewery");
    },
  }),

  Brewery: bookshelf.Model.extend({
    tableName: "brewery",
    idAttribute: "id",
    tutorials() {
      return this.belongsToMany(
        entities.Tutorials,
        "brewery_tutorials",
        "brewery_id",
        "tutorial_id",
        "id",
        "id"
      ).withPivot(["dat_started", "dat_completed"]);
    },
  }),

  Questions: bookshelf.Model.extend({
    tableName: "questions",
    idAttribute: "id",
  }),

  Answers: bookshelf.Model.extend({
    tableName: "answers",
    idAttribute: "id",
  }),

  Elements: bookshelf.Model.extend({
    tableName: "elements",
    idAttribute: "id",
  }),
};

/**
 * HELPERS
 */
//alwaysArray: če imamo samo 1 zadetek za brisanje, ga vrnemo kot objekt, ne kot array izbrisanih elementov
//če zadetka ni, vrnemo null
const helpers = {
  deleteBy: async (model, params, alwaysArray = true) => {
    //await: ker želimo sinhroni klic, sicer ne moremo vračati vrednosti
    //return naredimo čisto na koncu
    let ret = null;
    await model
      .forge()
      .where(params)
      .fetchAll({ require: false })
      ?.then((result) => {
        result.forEach((m) => {
          m.destroy();
        });
        if (result.length === 1 && !alwaysArray) {
          ret = result.at(0);
        } else if (result.length) {
          ret = result;
        }
      });
    return ret;
  },

  //naredimo jo sinhorno
  //alwaysArray: če je false in imamo samo 0-1 zadetek, se bo ta zadetek vrnil kot objekt, ne kot array
  findBy: async (model, params, options, alwaysArray = true) => {
    let defopts = { require: false };
    let opts = { ...defopts, ...options };
    let result = await model
      .forge()
      .where(params ? params : {})
      .fetchAll(opts);
    if (result.length <= 1 && !alwaysArray) {
      return result.length ? result.at(0) : null;
    }
    return result;
  },

  update: async (model, params, data, alwaysArray = true) => {
    let ret = null;
    await model
      .forge()
      .where(params)
      .fetchAll({ require: false })
      ?.then((result) => {
        result.forEach((m) => {
          m.save(data, {
            method: "update",
            patch: true,
          });
        });
        if (result.length === 1 && !alwaysArray) {
          ret = result.at(0);
        } else if (result.length) {
          ret = result;
        }
      });
    return ret;
  },
};

/**
 * EXPORTS
 */
module.exports = {
  knex: knex,
  bookshelf: bookshelf,
  entity: entities,
  helper: helpers,
};
