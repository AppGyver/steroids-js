#Steroids compatibility with Cordova CLI

The `.cordova` folder is included in new Steroids projects for initial [Cordova CLI](https://github.com/apache/cordova-cli) compatibility.

Cordova CLI commands can thus be run inside a Steroids project. The support is not complete; the current main use case is to facilitate plugin development in Xcode/Eclipse without having to create a separate Cordova project. You shouldn't use the native iOS/Android projects for actual development, since Steroids.js features are unavailable there.

Note that you have to load `cordova.js` from the `www/` root in Cordova projects, instead of via `localhost` as it is in Steroids:

```
<script src="cordova.js"></script>
```

The hooks in the `hooks/` folder only affect Cordova CLI commands. For Steroids pre- and post-make hooks, see `config/application.coffee`.