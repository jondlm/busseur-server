'use strict';

var log = require('./log');

/**
 * stripId
 *
 * The default hapi request id is verbose, this function strips it down to just
 * the last integer for readability.
 *
 * @param {string} reqId - Hapi request id, e.g. "1428518309225:jdelamotte.local:33729:i892x0zq:10000"
 * @return {number} - an integer request id
 */
function stripId (reqId) {
	reqId = reqId || '';
	return parseInt(reqId.split(':')[4], 10);
}

exports.register = function (server, options, next) {

	/**
	 * onRequest
	 *
	 */
	server.ext('onRequest', function (req, reply) {
		var payload = '';
		var jsonPayload;

		log.debug({
			req_id: stripId(req.id),
			method: req.method,
			path: req.path
		}, 'Request ');

		// Inspect the body if there is one
		req.on('peek', function(chunk) { payload += chunk; });
		req.on('finish', function() {
			// Attempt to parse the payload as JSON
			try {
				jsonPayload = JSON.parse(payload);
			} catch (e) {
				// Don't care if it fails
			}
			// Naively assume that if the word "password" is in the payload, then we
			// shouldn't log it
			if (payload && /password/i.test(payload)) {
				log.trace({
					req_id: stripId(req.id),
				}, 'Payload with password omitted');
			} else if (jsonPayload) {
				log.trace({
					req_id: stripId(req.id),
					payload: jsonPayload
				}, 'JSON payload');
			} else if (payload) {
				log.trace({
					req_id: stripId(req.id),
					payload: payload
				}, 'Payload');
			}
		});

		reply.continue();
	});

	/**
	 * onPreResponse
	 *
	 */
	server.ext('onPreResponse', function (req, reply) {
		var msec = Date.now() - req.info.received;

		log.debug({
			req_id: stripId(req.id),
			method: req.method,
			path: req.path,
			statusCode: req.response.statusCode,
			msec: msec
		}, 'Response');

		reply.continue();
	});

	/**
	 * internalError
	 *
	 */
	server.on('internalError', function(req, err) {
		log.error({error: err}, 'Internal server error');
	});

	next();
};

exports.register.attributes = {
	name: 'hapi-log-hooks'
};
