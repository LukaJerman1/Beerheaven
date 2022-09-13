/*
 * HANDLEBARS: https://handlebarsjs.com/
 * EXPRESS-HBS: https://www.npmjs.com/package/express-hbs
 */
const hbs = require('express-hbs');
const helpers = require('./helpers');

const config = {
    partialsDir: __dirname + "/views/partials",
    layoutsDir: __dirname + "/views/layouts",
    extname: ".html"
};

const engine = hbs.express4(config);
helpers.register(hbs);

module.exports = engine;