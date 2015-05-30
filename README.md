# Busseur Server

This small server was written to accompany the _busseur_ command line tool for
Portland TriMet bus arrivals. It's a very thin wrapper around _one_ of the
endpoints provided by the [TriMet api][api].

## Usage

**Make sure** you have an `APP_ID` environment variables set with your trimet api
key the can be obtained on [their website][id]. To start the server:

```bash
export APP_ID=123
npm install
npm start
```

[api]: http://developer.trimet.org/ws_docs/
[id]: http://developer.trimet.org/appid/registration/
