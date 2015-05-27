'use strict';

//
// Dependencies
// -------------------------------------
var Hapi    = require('hapi');
var Joi     = require('joi');
var log     = require('./util/log');
var secrets = require('./secrets');
var rxHttp  = require('rx-http');
var Boom    = require('boom');

//
// Constants
// -------------------------------------
var BASE_URL = 'http://developer.trimet.org/ws/v2/arrivals'; // http://developer.trimet.org/ws_docs/arrivals2_ws.shtml

//
// Server
// -------------------------------------
var server = new Hapi.Server();
server.connection({ port: 3000 });

//
// Routes
// -------------------------------------
server.route([{
  method: 'GET',
  path: '/',
  handler: function(req, reply) {
    var qs = {
      locIDs: req.query.locIDs,
      appID: secrets.appId
    };

    rxHttp.getJson$(BASE_URL, qs).subscribe(reply, function(err) {
      reply(Boom.badRequest(err));
    });
  },
  config: {
    validate: {
      query: {
        locIDs: Joi.number().integer()
      },
      options: {
        presence: 'required'
      }
    }
  }
}]);


//
// Plugins
// -------------------------------------
server.register([
  { register: require('./util/log-hooks') }
], function(err) {
  if (err) { log.fatal(err); }

  //
  // Start server
  // -------------------------------------
  server.start(function () {
    log.info('Server running at %s', server.info.uri);
  });
});


