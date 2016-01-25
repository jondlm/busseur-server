# Busseur Server

This small server was written to accompany the _busseur_ command line tool for
Portland TriMet bus arrivals. It's a very thin wrapper around the [TriMet
api][api].

## Usage

**Make sure** you have an `APP_ID` environment variables set with your trimet api
key the can be obtained on [their website][id]. To start the server:

```bash
export APP_ID=123
mix deps.get
mix phoenix.server # or `iex -S mix phoenix.server` for a REPL
```

Now you can visit [`localhost:4000`](http://localhost:4000).

## Docker

There's a Dockerfile which means you can spin up the server with docker.

[api]: http://developer.trimet.org/ws_docs/
[id]: http://developer.trimet.org/appid/registration/
