process.env.DEBUG="knex:query";

//express generator defaults
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var template_engine = require('./frontend/templates/engine');
//preberemo .env, da dobimo v process.env.* vrednosti
// require('dotenv').config();

//init express app
var app = express();

//declare views path for the template engine
var VIEWS_PATH = __dirname + '/frontend/templates/views';

//html will be the template's extension, hbs is the engine
app.engine('html', template_engine);
app.set('view engine', 'html');
app.set('views', VIEWS_PATH);

//default middleware
app.use(logger('dev'));
app.use(express.json({ limit: '50mb'}));
app.use(express.urlencoded({ extended: false, limit: '50mb' }));
app.use(cookieParser());
//serve static content from this dir
app.use(express.static(path.join(__dirname, 'frontend/public')));

//declare main routers for frontend and backend
var frontend = require('./frontend/frontend');
var backend = require('./backend/api');

//pozor! vrstni red je pomemben: najprej api router, potem frontend
app.use('/api', backend);
app.use('/', frontend);

//export the app to be used with our server
module.exports = app;
