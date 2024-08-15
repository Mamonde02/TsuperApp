//imports
var express         = require('express');
var app             = express();                  
var morgan          = require('morgan');
var bodyparser 		= require("body-parser");
var cors = require('cors')

// config            
app.use(morgan('combined'));
app.use(bodyparser.urlencoded({extended: true}));
app.use(bodyparser.json());
app.use(bodyparser.json({type: 'application/vnd.api+json'}));
app.use(cors())

module.exports = app;