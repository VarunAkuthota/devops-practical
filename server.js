'use strict';

require('dotenv').config();

const fs = require('fs');
const join = require('path').join;
const express = require('express');
const mongoose = require('mongoose');
const passport = require('passport');
const config = require('./config');

const models = join(__dirname, 'app/models');
const port = process.env.PORT || 3000;
const app = express();

module.exports = app;

fs.readdirSync(models)
  .filter(file => ~file.search(/^[^.].*\.js$/))
  .forEach(file => require(join(models, file)));

require('./config/passport')(passport);
require('./config/express')(app, passport);
require('./config/routes')(app, passport);

connect();

function listen() {
  if (app.get('env') === 'test') return;
  app.listen(port, () => {
    console.log('Express app started on port ' + port);
  });
}

function connect() {
  const mongoURI = process.env.MONGO_URI || config.db;
  console.log(`Connecting to MongoDB at ${mongoURI}`);

  mongoose.set('debug', true);

  mongoose.connection
    .on('error', (err) => {
      console.error('MongoDB connection error:', err);
    })
    .on('disconnected', connect)
    .once('open', listen);

  mongoose.connect(mongoURI, {
    keepAlive: 1,
    useNewUrlParser: true,
    useUnifiedTopology: true
  }).catch(err => {
    console.error('Initial MongoDB connection error:', err);
  });
}