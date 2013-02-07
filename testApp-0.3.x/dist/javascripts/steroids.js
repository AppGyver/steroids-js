(function(window){
/*! steroids-js - v0.2.5 - 2013-02-07 */
;var Bridge,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Bridge = (function() {

  Bridge.prototype.uid = 0;

  Bridge.prototype.callbacks = {};

  Bridge.bestNativeBridge = null;

  Bridge.getBestNativeBridge = function() {
    var bridgeClass, prioritizedList, _i, _len;
    prioritizedList = [AndroidBridge, WebsocketBridge];
    if (this.bestNativeBridge == null) {
      for (_i = 0, _len = prioritizedList.length; _i < _len; _i++) {
        bridgeClass = prioritizedList[_i];
        if (!(this.bestNativeBridge != null)) {
          if (bridgeClass.isUsable()) {
            this.bestNativeBridge = new bridgeClass();
          }
        }
      }
    }
    return this.bestNativeBridge;
  };

  function Bridge() {
    this.send = __bind(this.send, this);

    this.message_handler = __bind(this.message_handler, this);

  }

  Bridge.prototype.sendMessageToNative = function(options) {
    throw "ERROR: Bridge#sendMessageToNative not overridden by subclass!";
  };

  Bridge.isUsable = function() {
    throw "ERROR: Bridge.isUsable not overridden by subclass!";
  };

  Bridge.prototype.message_handler = function(e) {
    var msg;
    msg = JSON.parse(e);
    if ((msg != null ? msg.callback : void 0) != null) {
      if (this.callbacks[msg.callback] != null) {
        return this.callbacks[msg.callback].call(msg.parameters, msg.parameters);
      }
    }
  };

  Bridge.prototype.send = function(options) {
    var callbacks, request;
    callbacks = this.storeCallbacks(options);
    request = {
      method: options.method,
      parameters: (options != null ? options.parameters : void 0) != null ? options.parameters : {},
      callbacks: callbacks
    };
    request.parameters["view"] = window.top.AG_VIEW_ID;
    request.parameters["screen"] = window.top.AG_SCREEN_ID;
    request.parameters["layer"] = window.top.AG_LAYER_ID;
    return this.sendMessageToNative(JSON.stringify(request));
  };

  Bridge.prototype.storeCallbacks = function(options) {
    var callback_prefix, callbacks,
      _this = this;
    if ((options != null ? options.callbacks : void 0) == null) {
      return {};
    }
    callback_prefix = "" + options.method + "_" + (this.uid++);
    callbacks = {};
    if (options.callbacks.recurring != null) {
      callbacks.recurring = "" + callback_prefix + "_recurring";
      this.callbacks[callbacks.recurring] = function(parameters) {
        return options.callbacks.recurring.call(parameters, parameters);
      };
    }
    if (options.callbacks.success != null) {
      callbacks.success = "" + callback_prefix + "_success";
      this.callbacks[callbacks.success] = function(parameters) {
        delete _this.callbacks[callbacks.success];
        delete _this.callbacks[callbacks.failure];
        return options.callbacks.success.call(parameters, parameters);
      };
    }
    if (options.callbacks.failure != null) {
      callbacks.failure = "" + callback_prefix + "_fail";
      this.callbacks[callbacks.failure] = function(parameters) {
        delete _this.callbacks[callbacks.success];
        delete _this.callbacks[callbacks.failure];
        return options.callbacks.failure.call(parameters, parameters);
      };
    }
    return callbacks;
  };

  return Bridge;

})();
;var AndroidBridge,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

AndroidBridge = (function(_super) {

  __extends(AndroidBridge, _super);

  function AndroidBridge() {
    AndroidAPIBridge.registerHandler("Steroids.nativeBridge.message_handler");
    window.AG_SCREEN_ID = AndroidAPIBridge.getAGScreenId();
    window.AG_LAYER_ID = AndroidAPIBridge.getAGLayerId();
    window.AG_VIEW_ID = AndroidAPIBridge.getAGViewId();
    return true;
  }

  AndroidBridge.isUsable = function() {
    return typeof AndroidAPIBridge !== 'undefined';
  };

  AndroidBridge.prototype.sendMessageToNative = function(message) {
    return AndroidAPIBridge.send(message);
  };

  return AndroidBridge;

})(Bridge);
;var WebsocketBridge,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

WebsocketBridge = (function(_super) {

  __extends(WebsocketBridge, _super);

  function WebsocketBridge() {
    this.message_handler = __bind(this.message_handler, this);

    this.map_context = __bind(this.map_context, this);

    this.reopen = __bind(this.reopen, this);
    this.reopen();
  }

  WebsocketBridge.isUsable = function() {
    return true;
  };

  WebsocketBridge.prototype.reopen = function() {
    this.websocket = new WebSocket("ws://localhost:31337");
    this.websocket.onmessage = this.message_handler;
    this.websocket.onclose = this.reopen;
    this.websocket.addEventListener("open", this.map_context);
    this.map_context();
    return false;
  };

  WebsocketBridge.prototype.map_context = function() {
    this.send({
      method: "mapWebSocketConnectionToContext"
    });
    return this;
  };

  WebsocketBridge.prototype.sendMessageToNative = function(message) {
    var _this = this;
    if (this.websocket.readyState === 0) {
      return this.websocket.addEventListener("open", function() {
        return _this.websocket.send(message);
      });
    } else {
      return this.websocket.send(message);
    }
  };

  WebsocketBridge.prototype.message_handler = function(e) {
    return WebsocketBridge.__super__.message_handler.call(this, e.data);
  };

  return WebsocketBridge;

})(Bridge);
;var NativeObject;

NativeObject = (function() {

  function NativeObject() {}

  NativeObject.prototype.didOccur = function(options, parameters) {
    var callback, _i, _len, _ref, _results;
    _ref = options.recurringCallbacks;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      callback = _ref[_i];
      if (callback != null) {
        _results.push(callback.call(this, parameters, options));
      }
    }
    return _results;
  };

  NativeObject.prototype.didHappen = function(options, parameters) {
    var callback, _i, _len, _ref, _results;
    _ref = options.successCallbacks;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      callback = _ref[_i];
      if (callback != null) {
        _results.push(callback.call(this, parameters, options));
      }
    }
    return _results;
  };

  NativeObject.prototype.didFail = function(options) {
    var callback, _i, _len, _ref, _results;
    _ref = options.failureCallbacks;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      callback = _ref[_i];
      if (callback != null) {
        _results.push(callback.call(this, parameters, options));
      }
    }
    return _results;
  };

  NativeObject.prototype.nativeCall = function(options) {
    var _this = this;
    return steroids.nativeBridge.send({
      method: options.method,
      parameters: options.parameters,
      callbacks: {
        recurring: function(parameters) {
          return _this.didOccur(options, parameters);
        },
        success: function(parameters) {
          return _this.didHappen(options, parameters);
        },
        failure: function(parameters) {
          return _this.didFail(options, parameters);
        }
      }
    });
  };

  return NativeObject;

})();
;var Device,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Device = (function(_super) {

  __extends(Device, _super);

  function Device() {
    return Device.__super__.constructor.apply(this, arguments);
  }

  Device.prototype.ping = function(options, callbacks) {
    if (callbacks == null) {
      callbacks = {};
    }
    return this.nativeCall({
      method: "ping",
      parameters: {
        payload: options.data
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return Device;

})(NativeObject);
;var Animation,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Animation = (function(_super) {

  __extends(Animation, _super);

  function Animation() {
    return Animation.__super__.constructor.apply(this, arguments);
  }

  Animation.prototype.start = function(options, callbacks) {
    if (callbacks == null) {
      callbacks = {};
    }
    return this.nativeCall({
      method: "performTransition",
      parameters: {
        transition: options.name,
        curve: options.curve || "easeInOut",
        duration: options.duration || 0.7
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return Animation;

})(NativeObject);
;var App,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

App = (function(_super) {

  __extends(App, _super);

  App.prototype.path = void 0;

  App.prototype.absolutePath = void 0;

  function App() {
    var _this = this;
    App.__super__.constructor.call(this);
    this.getPath({}, {
      onSuccess: function(params) {
        _this.path = params.applicationPath;
        _this.absolutePath = params.applicationFullPath;
        return Steroids.markComponentReady("App");
      }
    });
  }

  App.prototype.getPath = function(options, callbacks) {
    return this.nativeCall({
      method: "getApplicationPath",
      parameters: {},
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return App;

})(NativeObject);
;var Button,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Button = (function(_super) {

  __extends(Button, _super);

  function Button() {
    return Button.__super__.constructor.apply(this, arguments);
  }

  Button.prototype.show = function(options, callbacks) {
    if (callbacks == null) {
      callbacks = {};
    }
    return this.nativeCall({
      method: "showNavigationBarRightButton",
      parameters: {
        title: options.title
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure],
      recurringCallbacks: [callbacks.onRecurring]
    });
  };

  return Button;

})(NativeObject);
;var Modal,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Modal = (function(_super) {

  __extends(Modal, _super);

  function Modal() {
    return Modal.__super__.constructor.apply(this, arguments);
  }

  Modal.prototype.show = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return this.nativeCall({
      method: "openModal",
      parameters: {
        url: options.layer.location
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  Modal.prototype.hide = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return this.nativeCall({
      method: "closeModal",
      parameters: options,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return Modal;

})(NativeObject);
;var LayerCollection,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

LayerCollection = (function(_super) {

  __extends(LayerCollection, _super);

  function LayerCollection() {
    LayerCollection.__super__.constructor.call(this);
    this.array = [];
  }

  LayerCollection.prototype.pop = function(options, callbacks) {
    var defaultOnSuccess,
      _this = this;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    defaultOnSuccess = function() {
      return _this.array.pop();
    };
    this.nativeCall({
      method: "popLayer",
      successCallbacks: [defaultOnSuccess, callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
    return this.array.pop();
  };

  LayerCollection.prototype.push = function(options, callbacks) {
    var defaultOnSuccess, parameters,
      _this = this;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    defaultOnSuccess = function() {
      return function() {
        return _this.array.push(options.layer);
      };
    };
    parameters = {
      url: options.layer.location
    };
    if (options.layer.pushAnimation != null) {
      parameters.pushAnimation = options.layer.pushAnimation;
    }
    if (options.layer.pushAnimationDuration != null) {
      parameters.pushAnimationDuration = options.layer.pushAnimationDuration;
    }
    if (options.layer.popAnimation != null) {
      parameters.popAnimation = options.layer.popAnimation;
    }
    if (options.layer.popAnimationDuration != null) {
      parameters.popAnimationDuration = options.layer.popAnimationDuration;
    }
    return this.nativeCall({
      method: "openLayer",
      parameters: parameters,
      successCallbacks: [defaultOnSuccess, callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return LayerCollection;

})(NativeObject);
;var Layer,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Layer = (function(_super) {

  __extends(Layer, _super);

  function Layer(options) {
    Layer.__super__.constructor.call(this);
    this.location = options.location;
    if (this.location.indexOf("://") === -1) {
      if (window.location.href.indexOf("file://") === -1) {
        this.location = "" + window.location.protocol + "//" + window.location.host + "/" + this.location;
      }
    }
    if (options.pushAnimation != null) {
      this.pushAnimation = options.pushAnimation;
    }
    if (options.pushAnimationDuration != null) {
      this.pushAnimationDuration = options.pushAnimationDuration;
    }
    if (options.popAnimation != null) {
      this.popAnimation = options.popAnimation;
    }
    if (options.popAnimationDuration != null) {
      this.popAnimationDuration = options.popAnimationDuration;
    }
    this.params = this.getParams();
  }

  Layer.prototype.params = {};

  Layer.prototype.getParams = function() {
    var pair, pairString, pairStrings, params, _i, _len;
    params = {};
    pairStrings = this.location.slice(this.location.indexOf('?') + 1).split('&');
    for (_i = 0, _len = pairStrings.length; _i < _len; _i++) {
      pairString = pairStrings[_i];
      pair = pairString.split('=');
      params[pair[0]] = pair[1];
    }
    return params;
  };

  return Layer;

})(NativeObject);
;var Tab;

Tab = (function() {

  function Tab() {}

  return Tab;

})();
;var NavigationBar,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

NavigationBar = (function(_super) {

  __extends(NavigationBar, _super);

  function NavigationBar() {
    return NavigationBar.__super__.constructor.apply(this, arguments);
  }

  NavigationBar.prototype.rightButton = new Button;

  NavigationBar.prototype.show = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return this.nativeCall({
      method: "showNavigationBar",
      parameters: {
        title: options.title
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return NavigationBar;

})(NativeObject);
;var Audio,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Audio = (function(_super) {

  __extends(Audio, _super);

  function Audio() {
    return Audio.__super__.constructor.apply(this, arguments);
  }

  Audio.prototype.play = function(options, callbacks) {
    var _this = this;
    if (callbacks == null) {
      callbacks = {};
    }
    return Steroids.on("ready", function() {
      var mediaPath;
      if (options.absolutePath) {
        mediaPath = options.absolutePath;
      } else {
        mediaPath = "" + Steroids.app.path + "/" + options.path;
      }
      return _this.nativeCall({
        method: "play",
        parameters: {
          filenameWithPath: mediaPath
        },
        successCallbacks: [callbacks.onSuccess],
        failureCallbacks: [callbacks.onFailure]
      });
    });
  };

  Audio.prototype.prime = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return this.nativeCall({
      method: "primeAudioPlayer",
      parameters: options,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return Audio;

})(NativeObject);
;var Flash,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Flash = (function(_super) {

  __extends(Flash, _super);

  function Flash() {
    return Flash.__super__.constructor.apply(this, arguments);
  }

  Flash.prototype.toggle = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return this.nativeCall({
      method: "cameraFlashToggle",
      parameters: options,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return Flash;

})(NativeObject);
;var Camera,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Camera = (function(_super) {

  __extends(Camera, _super);

  function Camera() {
    return Camera.__super__.constructor.apply(this, arguments);
  }

  Camera.prototype.flash = new Flash;

  return Camera;

})(NativeObject);
;var OAuth2Flow;

OAuth2Flow = (function() {

  function OAuth2Flow(options) {
    this.options = options;
    this.options.callbackUrl = "http://localhost:13101/" + this.options.callbackPath;
  }

  OAuth2Flow.prototype.authenticate = function() {
    throw "ERROR: " + this.name + " has not overridden authenticate method";
  };

  OAuth2Flow.prototype.concatenateUrlParams = function(params) {
    var first, key, result, value;
    first = true;
    result = "";
    for (key in params) {
      value = params[key];
      if (first) {
        result = result.concat("?");
        first = false;
      } else {
        result = result.concat("&");
      }
      result = result.concat("" + key + "=" + (encodeURIComponent(value)));
    }
    return result;
  };

  OAuth2Flow.prototype.urlEncode = function(string) {
    var c, hex, i, reserved_chars, str_len, string_arr;
    hex = function(code) {
      var result;
      result = code.toString(16).toUpperCase();
      if (result.length < 2) {
        result = 0 + result;
      }
      return "%" + result;
    };
    if (!string) {
      return "";
    }
    string = string + "";
    reserved_chars = /[ \r\n!*"'();:@&=+$,\/?%#\[\]<>{}|`^\\\u0080-\uffff]/;
    str_len = string.length;
    i = void 0;
    string_arr = string.split("");
    c = void 0;
    i = 0;
    while (i < str_len) {
      if (c = string_arr[i].match(reserved_chars)) {
        c = c[0].charCodeAt(0);
        if (c < 128) {
          string_arr[i] = hex(c);
        } else if (c < 2048) {
          string_arr[i] = hex(192 + (c >> 6)) + hex(128 + (c & 63));
        } else if (c < 65536) {
          string_arr[i] = hex(224 + (c >> 12)) + hex(128 + ((c >> 6) & 63)) + hex(128 + (c & 63));
        } else {
          if (c < 2097152) {
            string_arr[i] = hex(240 + (c >> 18)) + hex(128 + ((c >> 12) & 63)) + hex(128 + ((c >> 6) & 63)) + hex(128 + (c & 63));
          }
        }
      }
      i++;
    }
    return string_arr.join("");
  };

  return OAuth2Flow;

})();
;var AuthorizationCodeFlow,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

AuthorizationCodeFlow = (function(_super) {

  __extends(AuthorizationCodeFlow, _super);

  function AuthorizationCodeFlow() {
    this.finish = __bind(this.finish, this);

    this.authenticate = __bind(this.authenticate, this);
    return AuthorizationCodeFlow.__super__.constructor.apply(this, arguments);
  }

  AuthorizationCodeFlow.prototype.authenticate = function() {
    var authenticationLayer, authorizationUrl;
    this.xhrAuthorizationParams = {
      response_type: "code",
      client_id: this.options.clientID,
      redirect_uri: this.options.callbackUrl,
      scope: this.options.scope || ""
    };
    authorizationUrl = this.options.authorizationUrl.concat(this.concatenateUrlParams(this.xhrAuthorizationParams));
    authenticationLayer = new Steroids.Layer({
      location: authorizationUrl
    });
    return Steroids.modal.show({
      layer: authenticationLayer
    });
  };

  AuthorizationCodeFlow.prototype.finish = function(callback) {
    var body, key, request, value, _ref,
      _this = this;
    this.xhrAccessTokenParams = {
      client_id: this.options.clientID,
      client_secret: this.options.clientSecret,
      redirect_uri: this.callbackUrl,
      grant_type: "authorization_code"
    };
    request = new XMLHttpRequest();
    request.open("POST", this.options.accessTokenUrl);
    body = [];
    _ref = this.xhrAccessTokenParams;
    for (key in _ref) {
      value = _ref[key];
      body.push("" + key + "=" + (this.urlEncode(value)));
    }
    body.push("code=" + Steroids.layer.params['code']);
    body = body.sort().join('&');
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.onreadystatechange = function() {
      var responseJSON;
      if (request.readyState === 4) {
        responseJSON = JSON.parse(request.responseText);
        callback(responseJSON.access_token);
        return Steroids.modal.hide();
      }
    };
    return request.send(body);
  };

  return AuthorizationCodeFlow;

})(OAuth2Flow);
;var ClientCredentialsFlow,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

ClientCredentialsFlow = (function(_super) {

  __extends(ClientCredentialsFlow, _super);

  function ClientCredentialsFlow() {
    return ClientCredentialsFlow.__super__.constructor.apply(this, arguments);
  }

  ClientCredentialsFlow.prototype.authenticate = function(callback) {
    var body, key, request, value, _ref,
      _this = this;
    this.xhrAccessTokenParams = {
      client_id: this.options.clientID,
      client_secret: this.options.clientSecret,
      scope: this.options.scope || "",
      grant_type: "client_credentials"
    };
    request = new XMLHttpRequest();
    request.open("POST", this.options.accessTokenUrl);
    body = [];
    _ref = this.xhrAccessTokenParams;
    for (key in _ref) {
      value = _ref[key];
      body.push("" + key + "=" + (this.urlEncode(value)));
    }
    body = body.sort().join('&');
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.onreadystatechange = function() {
      var responseJSON;
      if (request.readyState === 4) {
        responseJSON = JSON.parse(request.responseText);
        return callback(responseJSON.access_token);
      }
    };
    return request.send(body);
  };

  return ClientCredentialsFlow;

})(OAuth2Flow);
;var OAuth2;

OAuth2 = (function() {

  function OAuth2() {}

  OAuth2.AuthorizationCodeFlow = AuthorizationCodeFlow;

  OAuth2.ClientCredentialFlow = ClientCredentialsFlow;

  return OAuth2;

})();
;var TouchDB;

TouchDB = (function() {

  TouchDB.baseURL = "http://.touchdb.";

  function TouchDB(options) {
    this.options = options;
    if (!this.options.name) {
      throw "Database name required";
    }
    this.replicas = {};
    this.baseURL = "" + TouchDB.baseURL + "/" + this.options.name;
  }

  TouchDB.prototype.startMonitoringChanges = function(options, callbacks) {
    var request,
      _this = this;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    request = new XMLHttpRequest();
    request.open("GET", "" + this.baseURL + "/_changes?feed=continuous");
    request.onreadystatechange = function() {
      if (request.readyState !== 3) {
        return;
      }
      return callbacks.onChange();
    };
    return request.send();
  };

  TouchDB.prototype.createDB = function(options, callbacks) {
    var request,
      _this = this;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    request = new XMLHttpRequest();
    request.open("PUT", "" + this.baseURL + "/");
    request.onreadystatechange = function() {
      var errorObj, responseObj;
      if (request.readyState !== 4) {
        return;
      }
      if (request.status === 412) {
        errorObj = JSON.parse(request.responseText);
        if (callbacks.onFailure) {
          callbacks.onFailure(errorObj);
        }
      }
      if (request.status === 201) {
        responseObj = JSON.parse(request.responseText);
        if (callbacks.onSuccess) {
          return callbacks.onSuccess(responseObj);
        }
      }
    };
    return request.send();
  };

  TouchDB.prototype.addTwoWayReplica = function(options, callbacks) {
    var fromCloudAdded, fromCloudFailed, toCloudAdded, toCloudFailed,
      _this = this;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    toCloudAdded = function() {
      return _this.startReplication({
        source: options.url,
        target: _this.options.name
      }, {
        onSuccess: fromCloudAdded,
        onFailure: fromCloudFailed
      });
    };
    toCloudFailed = function() {
      if (callbacks.onFailure) {
        return callbacks.onFailure();
      }
    };
    fromCloudAdded = function() {
      _this.replicas[options.url] = {};
      if (callbacks.onSuccess) {
        return callbacks.onSuccess();
      }
    };
    fromCloudFailed = function() {
      if (callbacks.onFailure) {
        return callbacks.onFailure();
      }
    };
    return this.startReplication({
      source: this.options.name,
      target: options.url
    }, {
      onSuccess: toCloudAdded,
      onFailure: toCloudFailed
    });
  };

  TouchDB.prototype.startReplication = function(options, callbacks) {
    var request,
      _this = this;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    request = new XMLHttpRequest();
    request.open("POST", "" + TouchDB.baseURL + "/_replicate");
    request.onreadystatechange = function() {
      var errorObj, responseObj;
      if (request.readyState !== 4) {
        return;
      }
      if (request.status === 412) {
        errorObj = JSON.parse(request.responseText);
        callbacks.onFailure(errorObj);
      }
      if (request.status === 200) {
        responseObj = JSON.parse(request.responseText);
        return callbacks.onSuccess.call(responseObj);
      }
    };
    return request.send(JSON.stringify({
      source: options.source,
      target: options.target,
      continuous: true
    }));
  };

  return TouchDB;

})();
;var XHR,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

XHR = (function(_super) {

  __extends(XHR, _super);

  XHR.prototype.headers = [];

  function XHR() {
    this.setRequestHeader = __bind(this.setRequestHeader, this);

    this.send = __bind(this.send, this);
    this.method = void 0;
    this.url = void 0;
    this.async = void 0;
    this.status = 0;
    this.readyState = 0;
    this.headers = {};
  }

  XHR.prototype.open = function(methodString, urlString, isAsync) {
    if (isAsync == null) {
      isAsync = true;
    }
    this.method = methodString;
    this.url = urlString;
    return this.async = isAsync;
  };

  XHR.prototype.send = function(data) {
    if (!(this.method && this.url)) {
      throw "Error: INVALID_STATE_ERR: DOM Exception 11";
    }
    if (this.method !== "GET") {
      throw "Method not implemented";
    }
    return this.fetch({
      url: this.url,
      filenameWithPath: "temp",
      headers: this.headers
    });
  };

  XHR.prototype.setRequestHeader = function(name, value) {
    return this.headers[name] = value;
  };

  XHR.prototype.fetch = function(options, callbacks) {
    var fullPath;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    fullPath = "" + Steroids.app.path + "/" + options.filename;
    return this.nativeCall({
      method: "downloadFile",
      parameters: {
        url: options.url || this.url,
        headers: options.headers || this.headers,
        filenameWithPath: fullPath
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return XHR;

})(NativeObject);
;var Analytics,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Analytics = (function(_super) {

  __extends(Analytics, _super);

  function Analytics() {
    return Analytics.__super__.constructor.apply(this, arguments);
  }

  Analytics.prototype.recordEvent = function(opts, callbacks) {
    if (opts == null) {
      opts = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return this.nativeCall({
      method: "recordEvent",
      parameters: {
        type: "custom",
        attributes: opts.event
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return Analytics;

})(NativeObject);
;
window.steroids = {
  eventCallbacks: {},
  waitingForComponents: [],
  on: function(event, callback) {
    var _base;
    if (this["" + event + "_has_fired"] != null) {
      return callback();
    } else {
      (_base = this.eventCallbacks)[event] || (_base[event] = []);
      return this.eventCallbacks[event].push(callback);
    }
  },
  fireSteroidsEvent: function(event) {
    var callback, _i, _len, _ref, _results;
    this["" + event + "_has_fired"] = new Date().getTime();
    if (this.eventCallbacks[event] != null) {
      _ref = this.eventCallbacks[event];
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        callback = _ref[_i];
        callback();
        _results.push(this.eventCallbacks[event].splice(this.eventCallbacks[event].indexOf(callback), 1));
      }
      return _results;
    }
  },
  markComponentReady: function(model) {
    this.waitingForComponents.splice(this.waitingForComponents.indexOf(model), 1);
    if (this.waitingForComponents.length === 0) {
      return this.fireSteroidsEvent("ready");
    }
  }
};

window.steroids.nativeBridge = Bridge.getBestNativeBridge();

window.steroids.version = "0.2.5";

window.steroids.Layer = Layer;

window.steroids.Tab = Tab;

window.steroids.OAuth2 = OAuth2;

window.steroids.Animation = new Animation;

window.steroids.animation = window.steroids.Animation;

window.steroids.layers = new LayerCollection;

window.steroids.layer = new Layer({
  location: window.location.href
});

window.steroids.modal = new Modal;

window.steroids.audio = new Audio;

window.steroids.camera = new Camera;

window.steroids.navigationBar = new NavigationBar;

window.steroids.waitingForComponents.push("App");

window.steroids.app = new App;

window.steroids.device = new Device;

window.steroids.data = {};

window.steroids.data.TouchDB = TouchDB;

window.steroids.XHR = XHR;

window.steroids.analytics = new Analytics;

})(window)
