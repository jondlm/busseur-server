# Busseur Server

This small server was written to accompany the _busseur_ command line tool for
Portland TriMet bus arrivals. It's a very thin wrapper around _one_ of the
endpoints provided by the [TriMet api][api].

## Usage

Create a file called `secret.js` and put the following contents in it:

```
module.exports = {
  appId: 'your app token goes here'
};

```

Make sure you [sign up][id] for your own `appId` and swap it in. Then you can
run the following commands to get things running:

```bash
npm install
npm start
```

[api]: http://developer.trimet.org/ws_docs/
[id]: http://developer.trimet.org/appid/registration/
