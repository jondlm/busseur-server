# Busseur Server

Check out [busseur.jondelamotte.com][jd] for a live example.

This small server was written to accompany the [busseur][busseur] command line
tool for Portland TriMet bus arrivals. It's a thin wrapper around the [TriMet
api][api] and a mobile optimized web app to show bus arrivals in Portland,
Oregon.

## Usage

**Make sure** you have an `APP_ID` environment variables set with your TriMet api
key the can be obtained on [their website][id]. To start the server:

```bash
export APP_ID=123
mix deps.get
mix phoenix.server # or `iex -S mix phoenix.server` for a REPL
```

Now you can visit [`localhost:4000`](http://localhost:4000).

## Docker

There's a Dockerfile which means you can do this:

```
docker build -t busseur-server .
docker run -d -p 4000:80 -e "APP_ID=1234" busseur-server
# browse to port 4000 on the docker host
```

[api]: http://developer.trimet.org/ws_docs/
[id]: http://developer.trimet.org/appid/registration/
[busseur]: https://github.com/jondlm/busseur/
[jd]: http://busseur.jondelamotte.com/
