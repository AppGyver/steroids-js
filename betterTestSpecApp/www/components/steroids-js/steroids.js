/*! steroids-js - v3.5.5 - 2014-10-15 13:02 */
(function(window){
var Bridge,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Bridge = (function() {
  Bridge.prototype.uid = 0;

  Bridge.prototype.callbacks = {};

  Bridge.bestNativeBridge = null;

  Bridge.getBestNativeBridge = function() {
    var bridgeClass, prioritizedList, _i, _len;
    prioritizedList = [FreshAndroidBridge, TizenBridge, WebBridge, AndroidBridge, WebsocketBridge, JSCoreBridge];
    if (this.bestNativeBridge == null) {
      for (_i = 0, _len = prioritizedList.length; _i < _len; _i++) {
        bridgeClass = prioritizedList[_i];
        if (this.bestNativeBridge == null) {
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
    this.nativeCall = __bind(this.nativeCall, this);
    this.message_handler = __bind(this.message_handler, this);
  }

  Bridge.prototype.sendMessageToNative = function(options) {
    if (options == null) {
      options = {};
    }
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

  Bridge.prototype.nativeCall = function(options) {
    var _this = this;
    if (options == null) {
      options = {};
    }
    return this.send({
      method: options.method,
      parameters: options.parameters,
      callbacks: {
        recurring: function(parameters) {
          var callback, _i, _len, _ref, _results;
          if (options.recurringCallbacks != null) {
            _ref = options.recurringCallbacks;
            _results = [];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              callback = _ref[_i];
              if (callback != null) {
                _results.push(callback.call(_this, parameters, options));
              }
            }
            return _results;
          }
        },
        success: function(parameters) {
          var callback, _i, _len, _ref, _results;
          if (options.successCallbacks != null) {
            _ref = options.successCallbacks;
            _results = [];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              callback = _ref[_i];
              if (callback != null) {
                _results.push(callback.call(_this, parameters, options));
              }
            }
            return _results;
          }
        },
        failure: function(parameters) {
          var callback, _i, _len, _ref, _results;
          if (options.failureCallbacks != null) {
            _ref = options.failureCallbacks;
            _results = [];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              callback = _ref[_i];
              if (callback != null) {
                _results.push(callback.call(_this, parameters, options));
              }
            }
            return _results;
          }
        }
      }
    });
  };

  Bridge.prototype.send = function(options) {
    var callbacks, request;
    if (options == null) {
      options = {};
    }
    callbacks = this.storeCallbacks(options);
    request = {
      method: options.method,
      parameters: (options != null ? options.parameters : void 0) != null ? options.parameters : {},
      callbacks: callbacks
    };
    request.parameters["view"] = window.top.AG_VIEW_ID;
    request.parameters["screen"] = window.top.AG_SCREEN_ID;
    request.parameters["layer"] = window.top.AG_LAYER_ID;
    request.parameters["udid"] = window.top.AG_WEBVIEW_UDID;
    request = this.parseMessage(request);
    return this.sendMessageToNative(request);
  };

  Bridge.prototype.parseMessage = function(message) {
    if (message == null) {
      message = {};
    }
    return JSON.stringify(message);
  };

  Bridge.prototype.storeCallbacks = function(options) {
    var callback_prefix, callbacks,
      _this = this;
    if (options == null) {
      options = {};
    }
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
;var FreshAndroidBridge,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

FreshAndroidBridge = (function(_super) {
  __extends(FreshAndroidBridge, _super);

  function FreshAndroidBridge() {
    this.message_handler = __bind(this.message_handler, this);
    FreshAndroidAPIBridge.registerHandler("steroids.nativeBridge.message_handler");
    return true;
  }

  FreshAndroidBridge.isUsable = function() {
    return typeof FreshAndroidAPIBridge !== 'undefined';
  };

  FreshAndroidBridge.prototype.sendMessageToNative = function(message) {
    return FreshAndroidAPIBridge.send(message);
  };

  FreshAndroidBridge.prototype.message_handler = function(msg) {
    if ((msg != null ? msg.callback : void 0) != null) {
      if (this.callbacks[msg.callback] != null) {
        return this.callbacks[msg.callback].call(msg.parameters, msg.parameters);
      }
    }
  };

  return FreshAndroidBridge;

})(Bridge);
;var AndroidBridge,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

AndroidBridge = (function(_super) {
  __extends(AndroidBridge, _super);

  function AndroidBridge() {
    AndroidAPIBridge.registerHandler("steroids.nativeBridge.message_handler");
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
;var WebBridge,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

WebBridge = (function(_super) {
  __extends(WebBridge, _super);

  function WebBridge() {
    var pollForRefresh, refresh, source;
    window.AG_SCREEN_ID = 0;
    window.AG_LAYER_ID = 0;
    window.AG_VIEW_ID = 0;
    refresh = {
      id: null,
      timestamp: (new Date()).getTime()
    };
    if (window.EventSource != null) {
      source = new EventSource("http://localhost:4567/refresh_client_events?" + refresh.timestamp);
      source.addEventListener("refresh", function(e) {
        if (e.data === "true") {
          return window.location.reload();
        }
      }, false);
      source.addEventListener("open", function(e) {
        return console.log("Monitoring updates from steroids npm.");
      }, false);
      source.addEventListener("error", function(e) {
        if (e.readyState === EventSource.CLOSED) {
          return console.log("No longer monitoring updates from steroids npm.");
        }
      });
    } else {
      pollForRefresh = function() {
        var xhr;
        xhr = new XMLHttpRequest();
        xhr.onload = function() {
          if (this.readyState === 4 && this.status === 200 && this.responseText === "true") {
            return window.location.reload();
          }
        };
        xhr.open("GET", "http://localhost:4567/refresh_client?" + refresh.timestamp);
        return xhr.send();
      };
      refresh.id = setInterval(pollForRefresh, 1000);
    }
    return this;
  }

  WebBridge.isUsable = function() {
    return navigator.userAgent.indexOf("AppGyverSteroids") === -1;
  };

  WebBridge.prototype.sendMessageToNative = function(messageString) {
    var closeButton, failed, failureOptions, message, modal, successOptions,
      _this = this;
    message = JSON.parse(messageString);
    console.log("WebBridge: ", message);
    failed = false;
    successOptions = {};
    failureOptions = {};
    switch (message.method) {
      case "ping":
        successOptions.message = "PONG";
        break;
      case "openLayer":
        window.open(message.parameters.url, "_blank");
        break;
      case "openURL":
        window.open(message.parameters.url, "_blank");
        break;
      case "openModal":
        modal = document.createElement("iframe");
        modal.src = message.parameters.url;
        modal.width = "100%";
        modal.height = "100%";
        modal.style.position = "absolute";
        modal.style.top = "10px";
        modal.style.left = "10px";
        modal.className = "steroidsModal";
        document.body.appendChild(modal);
        closeButton = document.createElement("button");
        closeButton.style.position = "absolute";
        closeButton.style.top = "0px";
        closeButton.style.left = "0px";
        closeButton.textContent = "CLOSE MODAL";
        closeButton.onclick = function() {
          modal.parentNode.removeChild(modal);
          return closeButton.parentNode.removeChild(closeButton);
        };
        document.body.appendChild(closeButton);
        break;
      default:
        console.log("WebBridge: unsupported API method: " + message.method);
        failed = true;
    }
    if (failed) {

    } else {
      return this.callbacks[message.callbacks.success].call(this, successOptions);
    }
  };

  return WebBridge;

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
    this.open = __bind(this.open, this);
    this.reopen = __bind(this.reopen, this);
    this.reopen();
  }

  WebsocketBridge.websocketBridgeUsable = false;

  WebsocketBridge.isUsable = function() {
    return WebsocketBridge.websocketBridgeUsable;
  };

  WebsocketBridge.prototype.reopen = function() {
    window.steroids.debug("websocket reopen");
    window.steroids.resetSteroidsEvent("websocketUsable");
    this.websocket = null;
    window.steroids.debug("websocket using dynamic port");
    return this.requestWebSocketPort(this.open);
  };

  WebsocketBridge.prototype.open = function(port) {
    var _this = this;
    window.steroids.debug("websocket websocket open");
    this.websocket = new WebSocket("ws://localhost:" + port);
    this.websocket.onmessage = this.message_handler;
    this.websocket.onclose = this.reopen;
    this.websocket.onopen = function() {
      window.steroids.debug("websocket websocket opened");
      _this.map_context();
      return _this.markWebsocketUsable();
    };
    return window.steroids.debug("websocket websocket opening");
  };

  WebsocketBridge.prototype.requestWebSocketPort = function(callback) {
    var xmlhttp,
      _this = this;
    window.steroids.debug("websocket request port");
    xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
      if (xmlhttp.readyState === XMLHttpRequest.DONE) {
        window.steroids.debug("websocket request port success: " + xmlhttp.responseText);
        return callback(xmlhttp.responseText);
      }
    };
    xmlhttp.open("GET", "http://dolans.inetrnul.do.nut.cunnoct.localhost/");
    xmlhttp.send();
    return window.steroids.debug("websocket requesting port");
  };

  WebsocketBridge.prototype.markWebsocketUsable = function() {
    window.steroids.debug("websocket open, marking usable");
    return window.steroids.fireSteroidsEvent("websocketUsable");
  };

  WebsocketBridge.prototype.map_context = function() {
    this.send({
      method: "mapWebSocketConnectionToContext"
    });
    return this;
  };

  WebsocketBridge.prototype.sendMessageToNative = function(message) {
    var _ref,
      _this = this;
    if (((_ref = this.websocket) != null ? _ref.readyState : void 0) === WebSocket.OPEN) {
      return this.websocket.send(message);
    } else {
      return window.steroids.on("websocketUsable", function() {
        var _ref1;
        if (((_ref1 = _this.websocket) != null ? _ref1.readyState : void 0) === WebSocket.OPEN) {
          return _this.websocket.send(message);
        } else {
          return _this.sendMessageToNative(message);
        }
      });
    }
  };

  WebsocketBridge.prototype.message_handler = function(e) {
    return WebsocketBridge.__super__.message_handler.call(this, e.data);
  };

  return WebsocketBridge;

})(Bridge);
;var TizenBridge,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

TizenBridge = (function(_super) {
  __extends(TizenBridge, _super);

  function TizenBridge() {
    var pollForRefresh, refresh;
    refresh = {
      id: null,
      timestamp: (new Date()).getTime()
    };
    pollForRefresh = function() {
      var getURL, xhr;
      xhr = new XMLHttpRequest();
      xhr.onload = function() {
        if (this.readyState === 4 && this.status === 200 && this.responseText === "true") {
          return window.location.reload();
        }
      };
      getURL = "http://" + location.hostname + ":4567/refresh_client?" + refresh.timestamp;
      xhr.open("GET", getURL);
      xhr.send();
      return refresh.id = setTimeout(pollForRefresh, 1000);
    };
    pollForRefresh();
    return this;
  }

  TizenBridge.isUsable = function() {
    var userAgentHasTizen;
    userAgentHasTizen = navigator.userAgent.indexOf("Tizen") !== -1;
    return (window.tizen != null) || userAgentHasTizen;
  };

  TizenBridge.prototype.sendMessageToNative = function(messageString) {
    var failed, failureOptions, message, successOptions;
    message = JSON.parse(messageString);
    console.log("TizenBridge: ", message);
    failed = false;
    successOptions = {};
    failureOptions = {};
    switch (message.method) {
      case "ping":
        successOptions.message = "PONG";
        break;
      case "openLayer":
        window.open(message.parameters.url);
        break;
      case "popLayer":
        window.close();
        break;
      case "openModal":
        window.open(message.parameters.url);
        break;
      case "closeModal":
        window.close();
        break;
      default:
        console.log("TizenBridge: unsupported API method: " + message.method);
        failed = true;
    }
    if (failed) {

    } else {
      return this.callbacks[message.callbacks.success].call(this, successOptions);
    }
  };

  return TizenBridge;

})(Bridge);
;var JSCoreBridge,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

JSCoreBridge = (function(_super) {
  __extends(JSCoreBridge, _super);

  function JSCoreBridge() {
    this.message_handler = __bind(this.message_handler, this);
    this.executeInWebThread = __bind(this.executeInWebThread, this);
    return true;
  }

  JSCoreBridge.isUsable = function() {
    return true;
  };

  JSCoreBridge.prototype.sendMessageToNative = function(message) {
    var _this = this;
    if (window.__JSCoreBridgeImpl != null) {
      return window.__JSCoreBridgeImpl.send(message);
    } else {
      return window.steroids.on("jsCoreBridgeUsable", function() {
        return window.__JSCoreBridgeImpl.send(message);
      });
    }
  };

  JSCoreBridge.prototype.parseMessage = function(message) {
    if (message == null) {
      message = {};
    }
    return message;
  };

  JSCoreBridge.prototype.executeInWebThread = function(msg) {
    if ((msg != null ? msg.callback : void 0) != null) {
      if (this.callbacks[msg.callback] != null) {
        return this.callbacks[msg.callback].call(msg.parameters, msg.parameters);
      }
    }
  };

  JSCoreBridge.prototype.message_handler = function(msg) {
    var _this = this;
    return setTimeout(function() {
      return _this.executeInWebThread(msg);
    }, 1);
  };

  return JSCoreBridge;

})(Bridge);
;var Events;

Events = (function() {
  function Events() {}

  Events.dispatchVisibilitychangedEvent = function(options) {
    var visibilityChangeCustomEvent;
    if (options == null) {
      options = {};
    }
    steroids.debug({
      msg: "dispatched visibilitychanged"
    });
    visibilityChangeCustomEvent = document.createEvent("CustomEvent");
    visibilityChangeCustomEvent.initCustomEvent("visibilitychange", true, true);
    return document.dispatchEvent(visibilityChangeCustomEvent);
  };

  Events.initializeVisibilityState = function(options) {
    if (options == null) {
      options = {};
    }
    steroids.debug({
      msg: "set document.visibilityState to unloaded"
    });
    document.visibilityState = "unloaded";
    document.hidden = "true";
    return document.addEventListener("DOMContentLoaded", function() {
      steroids.debug({
        msg: "got DOMContentLoaded, setting document.visibilityState to prerender"
      });
      return document.visibilityState = "prerender";
    });
  };

  Events.checkInitialVisibility = function(options, callbacks) {
    var setVisibilityStatus;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    setVisibilityStatus = function(event) {
      document.hidden = event.currentVisibility === "hidden";
      document.visibilityState = event.currentVisibility;
      return steroids.markComponentReady("Events.initialVisibility");
    };
    return steroids.nativeBridge.nativeCall({
      method: "getCurrentVisibility",
      successCallbacks: [setVisibilityStatus, callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  Events.extend = function(options, callbacks) {
    var becomeHiddenEvent, becomeVisibleEvent, focusAdded, lostFocusAdded,
      _this = this;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    if (!navigator.userAgent.match(/Android/i)) {
      steroids.markComponentReady("Events.initialVisibility");
      steroids.markComponentReady("Events.focuslisteners");
      return;
    }
    this.initializeVisibilityState();
    this.checkInitialVisibility();
    focusAdded = function() {
      steroids.debug({
        msg: "focus added"
      });
      return steroids.nativeBridge.nativeCall({
        method: "addEventListener",
        parameters: {
          event: "lostFocus"
        },
        successCallbacks: [lostFocusAdded, callbacks.onSuccess],
        recurringCallbacks: [becomeHiddenEvent, callbacks.onFailure]
      });
    };
    lostFocusAdded = function() {
      steroids.debug({
        msg: "lostfocus added"
      });
      return steroids.markComponentReady("Events.focuslisteners");
    };
    becomeVisibleEvent = function() {
      steroids.debug({
        msg: "become visible"
      });
      document.visibilityState = "visible";
      document.hidden = false;
      return _this.dispatchVisibilitychangedEvent();
    };
    becomeHiddenEvent = function() {
      steroids.debug({
        msg: "document become hidden"
      });
      document.visibilityState = "hidden";
      document.hidden = true;
      return _this.dispatchVisibilitychangedEvent();
    };
    return steroids.nativeBridge.nativeCall({
      method: "addEventListener",
      parameters: {
        event: "focus"
      },
      successCallbacks: [focusAdded, callbacks.onSuccess],
      recurringCallbacks: [becomeVisibleEvent, callbacks.onFailure]
    });
  };

  return Events;

}).call(this);
;var EventsSupport;

EventsSupport = (function() {
  function EventsSupport(prefixName, validEvents) {
    this.prefixName = prefixName;
    this.validEvents = validEvents;
  }

  EventsSupport.eventCounter = Date.now();

  EventsSupport.prototype.on = function(event, callback) {
    var errorAddingEventListener, eventHandlerId, eventListenerAdded, fireEventHandler;
    if (!(this.validEvents.indexOf(event) >= 0)) {
      throw new Error("Invalid event name!");
    }
    if (this.prefixName != null) {
      event = this.prefixName + event;
    }
    eventHandlerId = ++EventsSupport.eventCounter;
    eventListenerAdded = function(params) {
      return steroids.debug({
        msg: "eventListenerAdded event: " + event + " params: " + params
      });
    };
    errorAddingEventListener = function(error) {
      return steroids.debug({
        msg: "Error on addEventListener event: " + event + " error: " + error
      });
    };
    fireEventHandler = function(params) {
      var key;
      event = {};
      for (key in params) {
        event[key] = params[key];
      }
      if (params.webview != null) {
        event.webview = new steroids.views.WebView({
          location: params.webview.location,
          id: params.webview.id,
          uuid: params.webview.uuid
        });
      }
      if ((params.target != null) && (params.target.webview != null)) {
        event.target = {
          webview: new steroids.views.WebView({
            location: params.target.webview.location,
            id: params.target.webview.id,
            uuid: params.target.webview.uuid
          })
        };
      }
      if ((params.source != null) && (params.source.webview != null)) {
        event.source = {
          webview: new steroids.views.WebView({
            location: params.source.webview.location,
            id: params.source.webview.id,
            uuid: params.source.webview.uuid
          })
        };
      }
      if ((params.target != null) && (params.target.tab != null)) {
        event.target.tab = params.target.tab;
      }
      if (params.source && (params.source.tab != null)) {
        event.source.tab = params.source.tab;
      }
      if (params.drawer != null) {
        event.drawer = params.drawer;
      }
      return callback(event);
    };
    steroids.nativeBridge.nativeCall({
      method: "addEventListener",
      parameters: {
        event: event,
        eventHandlerId: "" + event + "_" + eventHandlerId
      },
      successCallbacks: [eventListenerAdded],
      recurringCallbacks: [fireEventHandler],
      failureCallbacks: [errorAddingEventListener]
    });
    return eventHandlerId;
  };

  EventsSupport.prototype.off = function(event, eventHandlerId) {
    var errorRemovingEventListener, eventListenerRemoved, parameters;
    if (!(this.validEvents.indexOf(event) >= 0)) {
      throw new Error("Invalid event name!");
    }
    if ((eventHandlerId != null) && eventHandlerId <= 0) {
      throw new Error("Invalid event handler id!");
    }
    if (this.prefixName != null) {
      event = this.prefixName + event;
    }
    eventListenerRemoved = function(params) {
      return steroids.debug({
        msg: "eventListenerRemoved eventHandlerId: " + eventHandlerId + " params: " + params
      });
    };
    errorRemovingEventListener = function(error) {
      return steroids.debug({
        msg: "Error on removeEventListener eventHandlerId: " + eventHandlerId + " error: " + error
      });
    };
    parameters = {
      event: event
    };
    if (eventHandlerId != null) {
      parameters.eventHandlerId = "" + event + "_" + eventHandlerId;
    }
    return steroids.nativeBridge.nativeCall({
      method: "removeEventListener",
      parameters: parameters,
      successCallbacks: [eventListenerRemoved],
      failureCallbacks: [errorRemovingEventListener]
    });
  };

  return EventsSupport;

})();
;var Torch;

Torch = (function() {
  function Torch() {}

  Torch.prototype.turnOn = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return steroids.nativeBridge.nativeCall({
      method: "cameraFlashOn",
      parameters: options,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  Torch.prototype.turnOff = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return steroids.nativeBridge.nativeCall({
      method: "cameraFlashOff",
      parameters: options,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  Torch.prototype.toggle = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return steroids.nativeBridge.nativeCall({
      method: "cameraFlashToggle",
      parameters: options,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return Torch;

})();
;var Device,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Device = (function() {
  function Device() {
    this.setSleepDisabled = __bind(this.setSleepDisabled, this);
    this.enableSleep = __bind(this.enableSleep, this);
    this.disableSleep = __bind(this.disableSleep, this);
    this.getIPAddress = __bind(this.getIPAddress, this);
    this.ping = __bind(this.ping, this);
  }

  Device.prototype.torch = new Torch();

  Device.prototype.platform = {
    getName: function(options, callbacks) {
      var name;
      if (options == null) {
        options = {};
      }
      if (callbacks == null) {
        callbacks = {};
      }
      name = typeof AndroidAPIBridge !== 'undefined' ? "android" : navigator.userAgent.indexOf("Tizen") !== -1 ? "tizen" : navigator.userAgent.match(/(iPod|iPhone|iPad)/) ? "ios" : void 0;
      if (callbacks.onSuccess != null) {
        return callbacks.onSuccess(name);
      }
    }
  };

  Device.prototype.ping = function(options, callbacks) {
    var data;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    data = options.constructor.name === "String" ? options : options.data;
    return steroids.nativeBridge.nativeCall({
      method: "ping",
      parameters: {
        payload: data
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  Device.prototype.getIPAddress = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return steroids.nativeBridge.nativeCall({
      method: "getIPAddress",
      parameters: {},
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  Device.prototype.disableSleep = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    options.disabled = true;
    return this.setSleepDisabled(options, callbacks);
  };

  Device.prototype.enableSleep = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    options.disabled = false;
    return this.setSleepDisabled(options, callbacks);
  };

  Device.prototype.setSleepDisabled = function(options, callbacks) {
    var disabled;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    disabled = options.constructor.name === "Boolean" ? options : options.disabled;
    return steroids.nativeBridge.nativeCall({
      method: "setSleepDisabled",
      parameters: {
        sleepDisabled: disabled
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return Device;

})();
;var Animation,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Animation = (function() {
  Animation.TRANSITION_REVERSION_MAPPING = {
    slideFromLeft: "slideFromRight",
    slideFromRight: "slideFromLeft",
    slideFromBottom: "slideFromTop",
    slideFromTop: "slideFromBottom",
    curlUp: "curlDown",
    curlDown: "curlUp",
    fade: "fade",
    flipVerticalFromBottom: "flipVerticalFromTop",
    flipVerticalFromTop: "flipVerticalFromBottom",
    flipHorizontalFromLeft: "flipHorizontalFromRight",
    flipHorizontalFromRight: "flipHorizontalFromLeft",
    slide: "slide",
    slideAndScale: "slideAndScale",
    swingingDoor: "swingingDoor",
    parallax: "parallax"
  };

  function Animation(options) {
    var _ref, _ref1, _ref2, _ref3, _ref4, _ref5, _ref6;
    if (options == null) {
      options = {};
    }
    this.perform = __bind(this.perform, this);
    this.transition = options.constructor.name === "String" ? options : (_ref = options.transition) != null ? _ref : "curlUp";
    if (this.transition == null) {
      throw "transition required";
    }
    this.reversedTransition = (_ref1 = options.reversedTransition) != null ? _ref1 : this.constructor.TRANSITION_REVERSION_MAPPING[this.transition];
    this.duration = (_ref2 = options.duration) != null ? _ref2 : 0.7;
    this.reversedDuration = (_ref3 = options.reversedDuration) != null ? _ref3 : this.duration;
    this.curve = (_ref4 = options.curve) != null ? _ref4 : "easeInOut";
    this.reversedCurve = (_ref5 = options.reversedCurve) != null ? _ref5 : "easeInOut";
    this.parallaxFactor = (_ref6 = options.parallaxFactor) != null ? _ref6 : 2.0;
  }

  Animation.prototype.perform = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return steroids.nativeBridge.nativeCall({
      method: "performTransition",
      parameters: {
        transition: this.transition,
        curve: options.curve || this.curve,
        duration: options.duration || this.duration
      },
      successCallbacks: [callbacks.onSuccess, callbacks.onAnimationStarted],
      recurringCallbacks: [callbacks.onAnimationEnded],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return Animation;

})();
;var App;

App = (function() {
  App.prototype.path = void 0;

  App.prototype.userFilesPath = void 0;

  App.prototype.absolutePath = void 0;

  App.prototype.absoluteUserFilesPath = void 0;

  App.prototype.host = {
    getURL: function(options, callbacks) {
      var betterResponseCb;
      if (options == null) {
        options = {};
      }
      if (callbacks == null) {
        callbacks = {};
      }
      betterResponseCb = function(hostObj) {
        var aElem, actualURL;
        actualURL = "http://" + hostObj.endpointURL;
        aElem = document.createElement("a");
        aElem.href = actualURL;
        return callbacks.onSuccess(aElem.origin);
      };
      return steroids.nativeBridge.nativeCall({
        method: "getEndpointURL",
        parameters: {},
        successCallbacks: [betterResponseCb],
        failureCallbacks: [callbacks.onFailure]
      });
    }
  };

  function App() {
    var _this = this;
    this.getPath({}, {
      onSuccess: function(params) {
        _this.path = params.applicationPath;
        _this.userFilesPath = params.userFilesPath;
        _this.absolutePath = params.applicationFullPath;
        _this.absoluteUserFilesPath = params.userFilesFullPath;
        return steroids.markComponentReady("App");
      }
    });
  }

  App.prototype.loadTheme = function(options, callbacks) {
    var theme;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    theme = options.constructor.name === "String" ? options : options.theme;
    return steroids.nativeBridge.nativeCall({
      method: "loadStyleTheme",
      parameters: {
        theme: theme
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  App.prototype.getPath = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return steroids.nativeBridge.nativeCall({
      method: "getApplicationPath",
      parameters: {},
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  App.prototype.getLaunchURL = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return window.AG_STEROIDS_SCANNER_URL;
  };

  App.prototype.getMode = function(options, callbacks) {
    var mode;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    mode = navigator.userAgent.match(/(StandAlonePackage)/) ? "standalone" : "scanner";
    if (callbacks.onSuccess != null) {
      return callbacks.onSuccess(mode);
    }
  };

  App.prototype.getNSUserDefaults = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return steroids.nativeBridge.nativeCall({
      method: "getNSUserDefaults",
      parameters: {},
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return App;

})();
;var Modal,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Modal = (function(_super) {
  __extends(Modal, _super);

  function Modal() {
    Modal.__super__.constructor.call(this, "modal", ["willshow", "didshow", "willclose", "didclose"]);
  }

  Modal.prototype.show = function(options, callbacks) {
    var allowedRotations, parameters, view;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    view = options.constructor.name === "Object" ? options.view : options;
    allowedRotations = null;
    if (options.allowedRotations != null) {
      allowedRotations = options.allowedRotations.constructor.name === "Array" ? options.allowedRotations : [options.allowedRotations];
      allowedRotations = allowedRotations.map(function(value) {
        return Screen.mapDegreesToOrientations(value);
      });
    }
    switch (view.constructor.name) {
      case "PreviewFileView":
        return steroids.nativeBridge.nativeCall({
          method: "previewFile",
          parameters: {
            filenameWithPath: view.getNativeFilePath()
          },
          successCallbacks: [callbacks.onSuccess],
          failureCallbacks: [callbacks.onFailure]
        });
      case "MapView":
      case "WebView":
        parameters = view.id != null ? {
          id: view.id
        } : {
          url: view.location
        };
        parameters.keepTransitionHelper = options.keepLoading;
        parameters.disableAnimation = options.disableAnimation;
        parameters.waitTransitionEnd = options.waitTransitionEnd;
        if (allowedRotations != null) {
          parameters.allowedRotations = allowedRotations;
        }
        if (options.navigationBar === true) {
          parameters.hidesNavigationBar = false;
        } else {
          parameters.hidesNavigationBar = true;
        }
        if (view.constructor.name === "MapView") {
          parameters.map = view;
        }
        return steroids.nativeBridge.nativeCall({
          method: "openModal",
          parameters: parameters,
          successCallbacks: [callbacks.onSuccess],
          failureCallbacks: [callbacks.onFailure]
        });
      default:
        throw "Unsupported view sent to steroids.modal.show - " + view.constructor.name;
    }
  };

  Modal.prototype.hide = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return steroids.nativeBridge.nativeCall({
      method: "closeModal",
      parameters: options,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  Modal.prototype.hideAll = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return steroids.nativeBridge.nativeCall({
      method: "closeAllModal",
      parameters: options,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return Modal;

})(EventsSupport);
;var DrawerCollection,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

DrawerCollection = (function(_super) {
  __extends(DrawerCollection, _super);

  function DrawerCollection() {
    DrawerCollection.__super__.constructor.call(this, "drawer", ["willshow", "didshow", "willclose", "didclose"]);
    this.defaultAnimations = {
      SLIDE: new Animation({
        transition: "slide",
        duration: 0.8
      }),
      SLIDE_AND_SCALE: new Animation({
        transition: "slideAndScale",
        duration: 0.8
      }),
      SWINGING_DOOR: new Animation({
        transition: "swingingDoor",
        duration: 0.8
      }),
      PARALLAX: new Animation({
        transition: "parallax",
        duration: 0.8,
        parallaxFactor: 2.0
      })
    };
  }

  DrawerCollection.prototype.hide = function(options, callbacks) {
    var parameters;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    steroids.debug("steroids.drawers.hide called");
    parameters = {
      center: {},
      fullChange: false
    };
    if (options.fullChange != null) {
      parameters.fullChange = options.fullChange;
    }
    if (options.center != null) {
      parameters.fullChange = true;
      DrawerCollection.applyViewOptions(options.center, parameters.center);
    }
    return steroids.nativeBridge.nativeCall({
      method: "closeDrawer",
      parameters: parameters,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  DrawerCollection.prototype.show = function(options, callbacks) {
    var parameters;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    steroids.debug("steroids.drawers.show called");
    parameters = {
      edge: options.edge || steroids.screen.edges.LEFT
    };
    return steroids.nativeBridge.nativeCall({
      method: "openDrawer",
      parameters: parameters,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  DrawerCollection.prototype.update = function(options, callbacks) {
    var parameters, validViews;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    steroids.debug("steroids.drawers.update called");
    parameters = {
      left: {},
      right: {},
      options: {}
    };
    validViews = true;
    if (options.left != null) {
      if ((options.left.id == null) && options.left.location) {
        validViews = false;
        if (callbacks.onFailure != null) {
          callbacks.onFailure("No identifier provided for the preloaded webview!");
        }
      } else {
        DrawerCollection.applyViewOptions(options.left, parameters.left);
      }
    }
    if (options.right != null) {
      if ((options.right.id == null) && options.right.location) {
        validViews = false;
        if (callbacks.onFailure != null) {
          callbacks.onFailure("No identifier provided for the preloaded webview!");
        }
      } else {
        DrawerCollection.applyViewOptions(options.right, parameters.right);
      }
    }
    if (options.options != null) {
      DrawerCollection.applyDrawerSettings(options.options, parameters.options);
    }
    if (validViews) {
      return steroids.nativeBridge.nativeCall({
        method: "updateDrawer",
        parameters: parameters,
        successCallbacks: [callbacks.onSuccess],
        failureCallbacks: [callbacks.onFailure]
      });
    }
  };

  DrawerCollection.prototype.disableGesture = function(options, callbacks) {
    var parameters;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    steroids.debug("steroids.drawers.disableGesture called");
    parameters = {
      options: {
        openGestures: ["None"],
        closeGestures: ["None"]
      }
    };
    return steroids.nativeBridge.nativeCall({
      method: "updateDrawer",
      parameters: parameters,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  DrawerCollection.prototype.enableGesture = function(options, callbacks) {
    var edge, parameters;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    steroids.debug("steroids.drawers.enableGesture called");
    parameters = {
      left: {},
      right: {},
      options: {}
    };
    if (options.constructor.name === "WebView") {
      options = {
        view: options
      };
    }
    if (options.keepLoading != null) {
      options.view.keepLoading = options.keepLoading;
    }
    if (options.widthOfDrawerInPixels != null) {
      options.view.widthOfDrawerInPixels = options.widthOfDrawerInPixels;
    } else if (options.widthOfLayerInPixels != null) {
      parameters.options.widthOfLayerInPixels = options.widthOfLayerInPixels;
    }
    edge = options.edge || steroids.screen.edges.LEFT;
    if (edge === steroids.screen.edges.RIGHT) {
      DrawerCollection.applyViewOptions(options.view, parameters.right);
    } else {
      DrawerCollection.applyViewOptions(options.view, parameters.left);
    }
    parameters.options.openGestures = ["PanNavBar", "PanCenterView"];
    parameters.options.closeGestures = ["PanNavBar", "PanCenterView", "TapNavBar", "TapCenterView", "PanDrawerView"];
    return steroids.nativeBridge.nativeCall({
      method: "updateDrawer",
      parameters: parameters,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  DrawerCollection.applyViewOptions = function(view, parameters) {
    if (view == null) {
      view = {};
    }
    if (parameters == null) {
      parameters = {};
    }
    if (view.id != null) {
      parameters.id = view.id;
    }
    if (view.location != null) {
      parameters.url = view.location;
    }
    if (view.keepLoading === true) {
      steroids.debug("steroids.drawers using keepLoading");
      parameters.keepTransitionHelper = true;
    }
    if (view.widthOfDrawerInPixels != null) {
      steroids.debug("steroids.drawers using custom width of drawer to determine cutoff point");
      parameters.widthOfDrawerInPixels = view.widthOfDrawerInPixels;
    }
    return parameters;
  };

  DrawerCollection.applyDrawerSettings = function(options, parameters) {
    if (options == null) {
      options = {};
    }
    if (parameters == null) {
      parameters = {};
    }
    if (options.showShadow != null) {
      parameters.showShadow = options.showShadow;
    }
    if (options.openGestures != null) {
      parameters.openGestures = options.openGestures;
    }
    if (options.closeGestures != null) {
      parameters.closeGestures = options.closeGestures;
    }
    if (options.stretchDrawer != null) {
      parameters.stretchDrawer = options.stretchDrawer;
    }
    if (options.centerViewInteractionMode != null) {
      parameters.centerViewInteractionMode = options.centerViewInteractionMode;
    }
    if (options.animation != null) {
      steroids.debug("steroids.drawers.show using custom animation");
      parameters.animation = options.animation.transition;
      parameters.animationDuration = options.animation.duration;
      parameters.parallaxFactor = options.animation.parallaxFactor;
    }
    if (options.widthOfLayerInPixels != null) {
      steroids.debug("steroids.drawers using custom width of layer to determine cutoff point");
      parameters.widthOfLayerInPixels = options.widthOfLayerInPixels;
    }
    return parameters;
  };

  return DrawerCollection;

})(EventsSupport);
;var LayerCollection,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

LayerCollection = (function(_super) {
  __extends(LayerCollection, _super);

  function LayerCollection() {
    LayerCollection.__super__.constructor.call(this, "layer", ["willchange", "didchange"]);
  }

  LayerCollection.prototype.pop = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return steroids.nativeBridge.nativeCall({
      method: "popLayer",
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  LayerCollection.prototype.popAll = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return steroids.nativeBridge.nativeCall({
      method: "popAllLayers",
      successCallbacks: [callbacks.onSuccess, callbacks.onTransitionStarted],
      recurringCallbacks: [callbacks.onTransitionEnd],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  LayerCollection.prototype.push = function(options, callbacks) {
    var parameters, view;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    view = options.constructor.name === "WebView" ? options : options.view;
    parameters = view.id != null ? {
      id: view.id
    } : {
      url: view.location
    };
    if (options.navigationBar === false) {
      parameters.hidesNavigationBar = true;
    }
    if (options.tabBar === false) {
      parameters.hidesTabBar = true;
    }
    if (options.keepLoading === true) {
      parameters.keepTransitionHelper = true;
    }
    if (options.animation != null) {
      parameters.pushAnimation = options.animation.transition;
      parameters.pushAnimationDuration = options.animation.duration;
      parameters.popAnimation = options.animation.reversedTransition;
      parameters.popAnimationDuration = options.animation.reversedDuration;
      parameters.pushAnimationCurve = options.animation.curve;
      parameters.popAnimationCurve = options.animation.reversedCurve;
    }
    switch (view.constructor.name) {
      case "MapView":
        parameters.map = view.getMapParameters();
        return steroids.nativeBridge.nativeCall({
          method: "openMapLayer",
          parameters: parameters,
          successCallbacks: [callbacks.onSuccess],
          failureCallbacks: [callbacks.onFailure]
        });
      default:
        return steroids.nativeBridge.nativeCall({
          method: "openLayer",
          parameters: parameters,
          successCallbacks: [callbacks.onSuccess],
          failureCallbacks: [callbacks.onFailure]
        });
    }
  };

  LayerCollection.prototype.replace = function(options, callbacks) {
    var parameters, view;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    steroids.debug("steroids.layers.replace called");
    view = options.constructor.name === "WebView" ? (steroids.debug("steroids.layers.replace using view shorthand"), options) : (steroids.debug("steroids.layers.replace using longhand"), options.view);
    parameters = {};
    if (view.id != null) {
      steroids.debug("steroids.layers.replace using preloaded view");
      parameters.id = view.id;
    } else {
      steroids.debug("steroids.layers.replace using new view");
      parameters.url = view.location;
    }
    return steroids.nativeBridge.nativeCall({
      method: "replaceLayers",
      parameters: parameters,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return LayerCollection;

})(EventsSupport);
;var Logger;

Logger = (function() {
  var LogMessage, LogMessageQueue;

  LogMessage = (function() {
    function LogMessage(message) {
      this.message = message;
      this.location = window.location.href;
      this.screen_id = window.AG_SCREEN_ID;
      this.layer_id = window.AG_LAYER_ID;
      this.view_id = window.AG_VIEW_ID;
      this.date = new Date();
    }

    LogMessage.prototype.asJSON = function() {
      var err, messageJSON, obj;
      try {
        messageJSON = JSON.stringify(this.message);
      } catch (_error) {
        err = _error;
        messageJSON = err.toString();
      }
      obj = {
        message: messageJSON,
        location: this.location,
        date: this.date.toJSON(),
        screen_id: this.screen_id,
        layer_id: this.layer_id,
        view_id: this.view_id
      };
      return obj;
    };

    return LogMessage;

  })();

  LogMessageQueue = (function() {
    function LogMessageQueue() {
      this.messageQueue = [];
    }

    LogMessageQueue.prototype.push = function(logMessage) {
      return this.messageQueue.push(logMessage);
    };

    LogMessageQueue.prototype.flush = function() {
      var logMessage, xhr;
      if (steroids.logger.logEndpoint == null) {
        return false;
      }
      while ((logMessage = this.messageQueue.pop())) {
        xhr = new XMLHttpRequest();
        xhr.open("POST", steroids.logger.logEndpoint, true);
        xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        xhr.send(JSON.stringify(logMessage.asJSON()));
      }
      return true;
    };

    LogMessageQueue.prototype.autoFlush = function(every) {
      var _this = this;
      return steroids.app.getMode({}, {
        onSuccess: function(mode) {
          if (mode !== "scanner") {
            return;
          }
          return steroids.logger.queue.startFlushing(every);
        }
      });
    };

    LogMessageQueue.prototype.startFlushing = function(every) {
      var _this = this;
      if (this.flushingInterval != null) {
        return false;
      }
      this.flushingInterval = window.setInterval(function() {
        return _this.flush();
      }, every);
      return true;
    };

    LogMessageQueue.prototype.stopFlushing = function() {
      if (this.flushingInterval == null) {
        return false;
      }
      window.clearInterval(this.flushingInterval);
      this.flushingInterval = void 0;
      return true;
    };

    LogMessageQueue.prototype.getLength = function() {
      return this.messageQueue.length;
    };

    return LogMessageQueue;

  })();

  function Logger() {
    var _this = this;
    this.messages = [];
    this.queue = new LogMessageQueue;
    steroids.app.host.getURL({}, {
      onSuccess: function(url) {
        return _this.logEndpoint = "" + url + "/__appgyver/logger";
      }
    });
  }

  Logger.prototype.log = function(message) {
    var logMessage,
      _this = this;
    logMessage = new LogMessage(message);
    this.messages.push(logMessage);
    return steroids.app.getMode({}, {
      onSuccess: function(mode) {
        if (mode !== "scanner") {
          return;
        }
        return _this.queue.push(logMessage);
      }
    });
  };

  return Logger;

})();
;var NavigationBarButton;

NavigationBarButton = (function() {
  function NavigationBarButton(options) {
    if (options == null) {
      options = {};
    }
    this.title = options.title;
    this.onTap = options.onTap;
    this.imagePath = options.imagePath;
    this.imageAsOriginal = options.imageAsOriginal;
    this.styleClass = options.styleClass;
    this.styleId = options.styleId;
    this.styleCSS = options.styleCSS;
  }

  NavigationBarButton.prototype.toParams = function() {
    var params, relativeTo;
    params = {};
    if (this.title != null) {
      params.title = this.title;
    } else {
      relativeTo = steroids.app.path;
      params.imagePath = relativeTo + this.imagePath;
    }
    params.imageAsOriginal = this.imageAsOriginal;
    params.styleClass = this.styleClass;
    params.styleId = this.styleId;
    params.styleCSS = this.styleCSS;
    return params;
  };

  NavigationBarButton.prototype.getCallback = function() {
    if (this.onTap != null) {
      return this.onTap;
    }
  };

  return NavigationBarButton;

})();
;var NavigationBar,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

NavigationBar = (function() {
  function NavigationBar() {
    this.buttonTapped = __bind(this.buttonTapped, this);
  }

  NavigationBar.prototype.setStyleId = function(options, callbacks) {
    var styleId;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    styleId = options.constructor.name === "String" ? options : options.styleId;
    return steroids.nativeBridge.nativeCall({
      method: "setNavigationBarStyleId",
      parameters: {
        styleId: styleId
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  NavigationBar.prototype.setStyleCSS = function(options, callbacks) {
    var styleCSS;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    styleCSS = options.constructor.name === "String" ? options : options.styleCSS;
    return steroids.nativeBridge.nativeCall({
      method: "setNavigationBarStyleCSS",
      parameters: {
        styleCSS: styleCSS
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  NavigationBar.prototype.addStyleClass = function(options, callbacks) {
    var styleClass;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    styleClass = options.constructor.name === "String" ? options : options.styleClass;
    return steroids.nativeBridge.nativeCall({
      method: "addNavigationBarStyleClass",
      parameters: {
        styleClass: styleClass
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  NavigationBar.prototype.setStyleClass = function(options, callbacks) {
    var styleClass;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    styleClass = options.constructor.name === "String" ? options : options.styleClass;
    return steroids.nativeBridge.nativeCall({
      method: "setNavigationBarStyleClass",
      parameters: {
        styleClass: styleClass
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  NavigationBar.prototype.tapButton = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return steroids.nativeBridge.nativeCall({
      method: "navigationBarTapButton",
      parameters: options,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  NavigationBar.prototype.hide = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    options.animated = options.animated != null;
    options.visible = false;
    return steroids.nativeBridge.nativeCall({
      method: "setNavigationBarVisibility",
      parameters: options,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  NavigationBar.prototype.show = function(options, callbacks) {
    var title,
      _this = this;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    steroids.debug("steroids.navigationBar.show options: " + (JSON.stringify(options)) + " callbacks: " + (JSON.stringify(callbacks)));
    title = options.constructor.name === "String" ? options : options.title;
    if (title || options.titleImagePath) {
      return steroids.on("ready", function() {
        var parameters, relativeTo, _ref;
        relativeTo = (_ref = options.relativeTo) != null ? _ref : steroids.app.path;
        parameters = title ? {
          title: title
        } : {
          titleImagePath: relativeTo + options.titleImagePath
        };
        return steroids.nativeBridge.nativeCall({
          method: "showNavigationBar",
          parameters: parameters,
          successCallbacks: [callbacks.onSuccess],
          failureCallbacks: [callbacks.onFailure]
        });
      });
    } else {
      return steroids.nativeBridge.nativeCall({
        method: "setNavigationBarVisibility",
        parameters: {
          visible: true,
          animated: options.animated != null
        },
        successCallbacks: [callbacks.onSuccess],
        failureCallbacks: [callbacks.onFailure]
      });
    }
  };

  NavigationBar.prototype.setButtons = function(options, callbacks) {
    var _this = this;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    steroids.debug("steroids.navigationBar.setButtons options: " + (JSON.stringify(options)) + " callbacks: " + (JSON.stringify(callbacks)));
    return steroids.on("ready", function() {
      var button, buttonParameters, buttonParametersFrom, callback, location, locations, params, relativeTo, _i, _j, _len, _len1, _ref, _ref1, _ref2;
      relativeTo = (_ref = options.relativeTo) != null ? _ref : steroids.app.path;
      _this.buttonCallbacks = {};
      params = {
        overrideBackButton: options.overrideBackButton
      };
      buttonParametersFrom = function(obj) {
        var btnParams;
        btnParams = obj.toParams();
        if (obj.imagePath != null) {
          btnParams.imagePath = relativeTo + obj.imagePath;
        }
        return btnParams;
      };
      if (typeof AndroidAPIBridge === 'undefined') {
        locations = ["right", "left"];
        for (_i = 0, _len = locations.length; _i < _len; _i++) {
          location = locations[_i];
          steroids.debug("steroids.navigationBar.setButtons constructing location " + location);
          _this.buttonCallbacks[location] = [];
          params[location] = [];
          if (options[location] != null) {
            _ref1 = options[location];
            for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
              button = _ref1[_j];
              buttonParameters = buttonParametersFrom(button);
              callback = (_ref2 = button.onTap) != null ? _ref2 : function() {};
              steroids.debug("steroids.navigationBar.setButtons adding button " + (JSON.stringify(buttonParameters)) + " to location " + location);
              _this.buttonCallbacks[location].push(callback);
              params[location].push(buttonParameters);
            }
          }
        }
        return steroids.nativeBridge.nativeCall({
          method: "setNavigationBarButtons",
          parameters: params,
          successCallbacks: [callbacks.onSuccess],
          recurringCallbacks: [_this.buttonTapped],
          failureCallbacks: [callbacks.onFailure]
        });
      } else {
        if ((options.right != null) && options.right !== []) {
          steroids.debug("steroids.navigationBar.setButtons showing right button title: " + options.right[0].title + " callback: " + options.right[0].onTap);
          return steroids.nativeBridge.nativeCall({
            method: "showNavigationBarRightButton",
            parameters: {
              title: options.right[0].title
            },
            successCallbacks: [callbacks.onSuccess],
            recurringCallbacks: [options.right[0].onTap],
            failureCallbacks: [callbacks.onFailure]
          });
        } else {
          steroids.debug("steroids.navigationBar.setButtons hiding right button");
          return steroids.nativeBridge.nativeCall({
            method: "hideNavigationBarRightButton",
            parameters: {},
            successCallbacks: [callbacks.onSuccess],
            failureCallbacks: [callbacks.onFailure]
          });
        }
      }
    });
  };

  NavigationBar.prototype.buttonTapped = function(options) {
    var _name, _ref;
    return (_ref = this.buttonCallbacks[options.location]) != null ? typeof _ref[_name = options.index] === "function" ? _ref[_name]() : void 0 : void 0;
  };

  NavigationBar.prototype.setAppearance = (function() {
    var appearancePropertyNames, camelcasedNavBarAppearancePropertyName, optionsToAppearanceParams, ucfirst;
    appearancePropertyNames = ['portraitBackgroundImage', 'landscapeBackgroundImage', 'tintColor', 'titleTextColor', 'titleShadowColor', 'buttonTintColor', 'buttonTitleTextColor', 'buttonTitleShadowColor'];
    camelcasedNavBarAppearancePropertyName = function(appearancePropertyName) {
      return 'navBar' + ucfirst(appearancePropertyName);
    };
    ucfirst = function(string) {
      if ((string != null ? string.length : void 0) > 0) {
        return string.charAt(0).toUpperCase() + string.slice(1);
      } else {
        return "";
      }
    };
    optionsToAppearanceParams = function(options) {
      var appearance, propertyName, _i, _len;
      appearance = {};
      for (_i = 0, _len = appearancePropertyNames.length; _i < _len; _i++) {
        propertyName = appearancePropertyNames[_i];
        if (options[propertyName] != null) {
          appearance[camelcasedNavBarAppearancePropertyName(propertyName)] = options[propertyName];
        }
      }
      return {
        appearance: appearance
      };
    };
    return function(options, callbacks) {
      if (options == null) {
        options = {};
      }
      if (callbacks == null) {
        callbacks = {};
      }
      steroids.debug("steroids.navigationBar.setAppearance options: " + (JSON.stringify(options)) + " callbacks: " + (JSON.stringify(callbacks)));
      return steroids.on("ready", function() {
        return steroids.nativeBridge.nativeCall({
          method: "setAppearance",
          parameters: optionsToAppearanceParams(options),
          successCallbacks: [callbacks.onSuccess],
          failureCallbacks: [callbacks.onFailure]
        });
      });
    };
  })();

  NavigationBar.prototype.update = function(options, callbacks) {
    var _this = this;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    steroids.debug("steroids.navigationBar.update options: " + (JSON.stringify(options)) + " callbacks: " + (JSON.stringify(callbacks)));
    return steroids.on("ready", function() {
      var button, callback, location, locations, parameters, params, relativeTo, _i, _j, _len, _len1, _ref;
      relativeTo = steroids.app.path;
      params = {};
      if (options.constructor.name === "String") {
        params.title = options;
      }
      if (options.title != null) {
        params.title = options.title;
        params.titleImagePath = "";
      }
      params.border = options.border;
      if (options.titleImagePath != null) {
        if (options.title == null) {
          params.titleImagePath = relativeTo + options.titleImagePath;
          params.title = "";
        }
      }
      if (options.overrideBackButton != null) {
        params.overrideBackButton = options.overrideBackButton;
      }
      if (options.backButton != null) {
        params.backButton = options.backButton.toParams();
      }
      if (options.buttons != null) {
        locations = ["right", "left"];
        for (_i = 0, _len = locations.length; _i < _len; _i++) {
          location = locations[_i];
          if (options.buttons[location] != null) {
            if (params.buttons == null) {
              params.buttons = {};
            }
            if (_this.buttonCallbacks == null) {
              _this.buttonCallbacks = {};
            }
            steroids.debug("steroids.navigationBar.update constructing location " + location);
            _this.buttonCallbacks[location] = [];
            params.buttons[location] = [];
            _ref = options.buttons[location];
            for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
              button = _ref[_j];
              parameters = button.toParams();
              callback = button.getCallback();
              steroids.debug("steroids.navigationBar.update adding button " + (JSON.stringify(parameters)) + " to location " + location);
              params.buttons[location].push(parameters);
              _this.buttonCallbacks[location].push(callback);
            }
          }
        }
      }
      return steroids.nativeBridge.nativeCall({
        method: "updateNavigationBar",
        parameters: params,
        successCallbacks: [callbacks.onSuccess],
        recurringCallbacks: [_this.buttonTapped],
        failureCallbacks: [callbacks.onFailure]
      });
    });
  };

  return NavigationBar;

})();
;var StatusBar;

StatusBar = (function() {
  function StatusBar() {}

  StatusBar.prototype.onTap = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    this.onTap = options;
    return steroids.nativeBridge.nativeCall({
      method: "setupStatusBarOnTap",
      parameters: {},
      successCallbacks: [callbacks.onSuccess],
      recurringCallbacks: [this.onTap],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  StatusBar.prototype.hide = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    steroids.debug("steroids.statusBar.hide options: " + (JSON.stringify(options)) + " callbacks: " + (JSON.stringify(callbacks)));
    return steroids.nativeBridge.nativeCall({
      method: "hideStatusBar",
      parameters: {},
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  StatusBar.prototype.show = function(options, callbacks) {
    var parameters;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    steroids.debug("steroids.statusBar.show options: " + (JSON.stringify(options)) + " callbacks: " + (JSON.stringify(callbacks)));
    parameters = options.constructor.name === "Object" ? {
      style: options.style
    } : {
      style: options
    };
    return steroids.nativeBridge.nativeCall({
      method: "showStatusBar",
      parameters: parameters,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return StatusBar;

})();
;var Splashscreen;

Splashscreen = (function() {
  function Splashscreen() {}

  Splashscreen.prototype.show = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return this.setVisibility(true, callbacks);
  };

  Splashscreen.prototype.hide = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return this.setVisibility(false, callbacks);
  };

  Splashscreen.prototype.setVisibility = function(visibility, callbacks) {
    var options;
    options = {
      visible: visibility
    };
    return steroids.nativeBridge.nativeCall({
      method: "setSplashScreenVisibility",
      parameters: options,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return Splashscreen;

})();
;var TabBar,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

TabBar = (function(_super) {
  __extends(TabBar, _super);

  function TabBar() {
    TabBar.__super__.constructor.call(this, "tab", ["willchange", "didchange"]);
  }

  TabBar.prototype.setStyleId = function(options, callbacks) {
    var styleId;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    styleId = options.constructor.name === "String" ? options : options.styleId;
    return steroids.nativeBridge.nativeCall({
      method: "setTabBarStyleId",
      parameters: {
        styleId: styleId
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  TabBar.prototype.setStyleCSS = function(options, callbacks) {
    var styleCSS;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    styleCSS = options.constructor.name === "String" ? options : options.styleCSS;
    return steroids.nativeBridge.nativeCall({
      method: "setTabBarStyleCSS",
      parameters: {
        styleCSS: styleCSS
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  TabBar.prototype.addStyleClass = function(options, callbacks) {
    var styleClass;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    styleClass = options.constructor.name === "String" ? options : options.styleClass;
    return steroids.nativeBridge.nativeCall({
      method: "addTabBarStyleClass",
      parameters: {
        styleClass: styleClass
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  TabBar.prototype.setStyleClass = function(options, callbacks) {
    var styleClass;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    styleClass = options.constructor.name === "String" ? options : options.styleClass;
    return steroids.nativeBridge.nativeCall({
      method: "setTabBarStyleClass",
      parameters: {
        styleClass: styleClass
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  TabBar.prototype.hide = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    steroids.debug("steroids.tabBar.hide options: " + (JSON.stringify(options)) + " callbacks: " + (JSON.stringify(callbacks)));
    return steroids.nativeBridge.nativeCall({
      method: "hideTabBar",
      parameters: {},
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  TabBar.prototype.show = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    steroids.debug("steroids.tabBar.show options: " + (JSON.stringify(options)) + " callbacks: " + (JSON.stringify(callbacks)));
    return steroids.nativeBridge.nativeCall({
      method: "showTabBar",
      parameters: {},
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  TabBar.prototype.selectTab = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    steroids.debug("steroids.tabBar.selectTab options: " + (JSON.stringify(options)) + " callbacks: " + (JSON.stringify(callbacks)));
    this.index = options.constructor.name === "Number" ? options : options.index;
    return steroids.nativeBridge.nativeCall({
      method: "selectTab",
      parameters: {
        index: this.index
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  TabBar.prototype.currentTab = {
    update: function(options, callbacks) {
      if (options == null) {
        options = {};
      }
      if (callbacks == null) {
        callbacks = {};
      }
      return steroids.nativeBridge.nativeCall({
        method: "updateTab",
        parameters: options,
        successCallbacks: [callbacks.onSuccess],
        failureCallbacks: [callbacks.onFailure]
      });
    }
  };

  TabBar.prototype.update = function(options, callbacks) {
    var parameters, scale, _i, _ref;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    steroids.debug("steroids.tabBar.update options: " + (JSON.stringify(options)) + " callbacks: " + (JSON.stringify(callbacks)));
    if (options.constructor.name === "Object") {
      parameters = {};
      parameters.position = options.position;
      parameters.tabs = [];
      if (options.tabs) {
        for (scale = _i = 0, _ref = options.tabs.length; 0 <= _ref ? _i < _ref : _i > _ref; scale = 0 <= _ref ? ++_i : --_i) {
          parameters.tabs.push({
            title: options.tabs[scale].title,
            image_path: options.tabs[scale].icon,
            badge: options.tabs[scale].badge,
            styleClass: options.tabs[scale].styleClass,
            styleId: options.tabs[scale].styleId,
            styleCSS: options.tabs[scale].styleCSS
          });
        }
      }
    }
    return steroids.nativeBridge.nativeCall({
      method: "updateTabs",
      parameters: parameters,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  TabBar.prototype.replace = function(options, callbacks) {
    var parameters, scale, _i, _ref;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    steroids.debug("steroids.tabBar.replace options: " + (JSON.stringify(options)) + " callbacks: " + (JSON.stringify(callbacks)));
    if (options.constructor.name === "Object") {
      parameters = {};
      parameters.tabs = [];
      for (scale = _i = 0, _ref = options.tabs.length; 0 <= _ref ? _i < _ref : _i > _ref; scale = 0 <= _ref ? ++_i : --_i) {
        parameters.tabs.push({
          target_url: options.tabs[scale].location,
          title: options.tabs[scale].title,
          image_path: options.tabs[scale].icon,
          position: options.tabs[scale].position,
          styleClass: options.tabs[scale].styleClass,
          styleId: options.tabs[scale].styleId,
          styleCSS: options.tabs[scale].styleCSS
        });
      }
      return steroids.nativeBridge.nativeCall({
        method: "replaceTabs",
        parameters: parameters,
        successCallbacks: [callbacks.onSuccess],
        failureCallbacks: [callbacks.onFailure]
      });
    }
  };

  return TabBar;

})(EventsSupport);
;var WebView,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

WebView = (function(_super) {
  __extends(WebView, _super);

  WebView.prototype.params = {};

  WebView.prototype.id = null;

  WebView.prototype.location = null;

  WebView.prototype.navigationBar = new NavigationBar;

  function WebView(options) {
    if (options == null) {
      options = {};
    }
    WebView.__super__.constructor.call(this, "webview", ["created", "preloaded", "unloaded"]);
    this.location = options.constructor.name === "String" ? options : options.location;
    if (options._parameters != null) {
      this.setParams(options._parameters);
    }
    this.id = options.id != null ? options.id : void 0;
    if (this.location.indexOf("://") === -1) {
      if (window.location.href.indexOf("file://") === -1) {
        this.location = "" + window.location.protocol + "//" + window.location.host + "/" + this.location;
      }
    }
    this.params = this.getParams();
  }

  WebView.prototype.preload = function(options, callbacks) {
    var proposedId, setIdOnSuccess,
      _this = this;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    steroids.debug("preload called for WebView " + (JSON.stringify(this)));
    proposedId = options.id || this.id || this.location;
    setIdOnSuccess = function() {
      steroids.debug("preload success: setting id");
      return _this.id = proposedId;
    };
    return steroids.nativeBridge.nativeCall({
      method: "preloadLayer",
      parameters: {
        id: proposedId,
        url: options.location || this.location
      },
      successCallbacks: [setIdOnSuccess, callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  WebView.prototype.unload = function(options, callbacks) {
    var _ref;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    steroids.debug("unload called for WebView " + (JSON.stringify(this)));
    if (this.id != null) {
      return steroids.nativeBridge.nativeCall({
        method: "unloadLayer",
        parameters: {
          id: this.id
        },
        successCallbacks: [callbacks.onSuccess],
        failureCallbacks: [callbacks.onFailure]
      });
    } else {
      return (_ref = callbacks.onFailure) != null ? _ref.call(this, {
        errorDescription: "Cannot unload a WebView that is not preloaded"
      }) : void 0;
    }
  };

  WebView.prototype.getParams = function() {
    var pair, pairString, pairStrings, params, _i, _len;
    params = {};
    pairStrings = this.location.slice(this.location.indexOf('?') + 1).split('&');
    for (_i = 0, _len = pairStrings.length; _i < _len; _i++) {
      pairString = pairStrings[_i];
      if (!(pairString !== location.href)) {
        continue;
      }
      pair = pairString.split('=');
      params[decodeURIComponent(pair[0])] = decodeURIComponent(pair[1]);
    }
    return params;
  };

  WebView.prototype.setParams = function(object) {
    var key, value, _results;
    _results = [];
    for (key in object) {
      value = object[key];
      _results.push(this.setParam(key, value));
    }
    return _results;
  };

  WebView.prototype.setParam = function(key, value) {
    return this.location = this.location + (__indexOf.call(this.location, "?") >= 0 ? "&" : "?") + ("" + (encodeURIComponent(key)) + "=" + (encodeURIComponent(value)));
  };

  WebView.prototype.removeLoading = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return steroids.nativeBridge.nativeCall({
      method: "removeTransitionHelper",
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  WebView.prototype.displayLoading = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return steroids.nativeBridge.nativeCall({
      method: "displayTransitionHelper",
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  WebView.prototype.setAllowedRotations = function(options, callbacks) {
    var allowedRotations;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    allowedRotations = options.constructor.name === "Array" ? options : options.constructor.name === "String" ? [options] : options.allowedRotations;
    if ((allowedRotations == null) || allowedRotations.length === 0) {
      allowedRotations = [0];
    }
    allowedRotations = allowedRotations.map(function(value) {
      return Screen.mapDegreesToOrientations(value);
    });
    return steroids.nativeBridge.nativeCall({
      method: "setAllowedOrientation",
      parameters: {
        allowedRotations: allowedRotations
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  WebView.prototype.rotateTo = function(options, callbacks) {
    var degrees, orientation;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    degrees = options.constructor.name === "String" || options.constructor.name === "Number" ? options : options.degrees;
    orientation = Screen.mapDegreesToOrientations(degrees);
    return steroids.nativeBridge.nativeCall({
      method: "setOrientation",
      parameters: {
        orientation: orientation
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  WebView.prototype.setBackgroundColor = function(options, callbacks) {
    var newColor;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    newColor = options.constructor.name === "String" ? options : options.color;
    return steroids.nativeBridge.nativeCall({
      method: "setWebViewBackgroundColor",
      parameters: {
        color: newColor
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  WebView.prototype.setBackgroundImage = function(options, callbacks) {
    var newImage;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    newImage = options.constructor.name === "String" ? options : options.image;
    return steroids.nativeBridge.nativeCall({
      method: "setWebViewBackgroundImage",
      parameters: {
        image: newImage
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  WebView.prototype.updateKeyboard = function(options, callbacks) {
    var params;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    params = {};
    if (options.accessoryBarEnabled != null) {
      params.accessoryBarEnabled = options.accessoryBarEnabled;
    }
    return steroids.nativeBridge.nativeCall({
      method: "updateKeyboard",
      parameters: params,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return WebView;

})(EventsSupport);
;var PreviewFileView;

PreviewFileView = (function() {
  function PreviewFileView(options) {
    var _ref;
    if (options == null) {
      options = {};
    }
    this.filePath = options.constructor.name === "String" ? options : options.filePath;
    this.relativeTo = (_ref = options.relativeTo) != null ? _ref : steroids.app.path;
  }

  PreviewFileView.prototype.getNativeFilePath = function() {
    return "" + this.relativeTo + "/" + this.filePath;
  };

  return PreviewFileView;

})();
;var MapView,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

MapView = (function(_super) {
  __extends(MapView, _super);

  function MapView(options) {
    if (options == null) {
      options = {};
    }
    if (options.location == null) {
      options.location = "map_empty_overlay.html";
    }
    MapView.__super__.constructor.call(this, options);
    this.mapType = options.constructor.name === "String" ? options : options.mapType;
    this.showsUserLocation = options.showsUserLocation;
    this.region = options.region;
  }

  MapView.prototype.getMapParameters = function() {
    return {
      mapType: this.mapType,
      showsUserLocation: this.showsUserLocation,
      region: this.region
    };
  };

  MapView.prototype.addMarkers = function(options, callbacks) {
    var markers;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    markers = options.constructor.name === "Array" ? options : options.markers;
    return steroids.nativeBridge.nativeCall({
      method: "addMarkersToMap",
      parameters: {
        id: this.id,
        markers: markers
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return MapView;

})(WebView);
;var Audio;

Audio = (function() {
  function Audio() {}

  Audio.prototype.play = function(options, callbacks) {
    var readyCapableDevice,
      _this = this;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    readyCapableDevice = false;
    setTimeout(function() {
      if (readyCapableDevice) {
        return;
      }
      return navigator.notification.alert("Audio playback requires a newer version of Scanner, please update from the App Store.", null, "Update Required");
    }, 500);
    return steroids.on("ready", function() {
      var mediaPath, relativeTo, _ref;
      readyCapableDevice = true;
      relativeTo = (_ref = options.relativeTo) != null ? _ref : steroids.app.path;
      mediaPath = options.constructor.name === "String" ? "" + relativeTo + "/" + options : "" + relativeTo + "/" + options.path;
      return steroids.nativeBridge.nativeCall({
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
    return steroids.nativeBridge.nativeCall({
      method: "primeAudioPlayer",
      parameters: options,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return Audio;

})();
;var OAuth2Flow;

OAuth2Flow = (function() {
  function OAuth2Flow(options) {
    this.options = options != null ? options : {};
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
;var AuthorizationCodeFlow, _ref,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

AuthorizationCodeFlow = (function(_super) {
  __extends(AuthorizationCodeFlow, _super);

  function AuthorizationCodeFlow() {
    this.finish = __bind(this.finish, this);
    this.authenticate = __bind(this.authenticate, this);
    _ref = AuthorizationCodeFlow.__super__.constructor.apply(this, arguments);
    return _ref;
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
    authenticationLayer = new steroids.views.WebView({
      location: authorizationUrl
    });
    return steroids.modal.show({
      view: authenticationLayer
    });
  };

  AuthorizationCodeFlow.prototype.finish = function(callback) {
    var body, key, request, value, _ref1,
      _this = this;
    this.xhrAccessTokenParams = {
      client_id: this.options.clientID,
      client_secret: this.options.clientSecret,
      redirect_uri: this.options.callbackUrl,
      grant_type: "authorization_code"
    };
    request = new XMLHttpRequest();
    request.open("POST", this.options.accessTokenUrl);
    body = [];
    _ref1 = this.xhrAccessTokenParams;
    for (key in _ref1) {
      value = _ref1[key];
      body.push("" + key + "=" + (this.urlEncode(value)));
    }
    body.push("code=" + steroids.view.params['code']);
    body = body.sort().join('&');
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.onreadystatechange = function() {
      var responseJSON;
      if (request.readyState === 4) {
        responseJSON = JSON.parse(request.responseText);
        callback(responseJSON.access_token);
        return steroids.modal.hide();
      }
    };
    return request.send(body);
  };

  return AuthorizationCodeFlow;

})(OAuth2Flow);
;var ClientCredentialsFlow, _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

ClientCredentialsFlow = (function(_super) {
  __extends(ClientCredentialsFlow, _super);

  function ClientCredentialsFlow() {
    _ref = ClientCredentialsFlow.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  ClientCredentialsFlow.prototype.authenticate = function(callback) {
    var body, key, request, value, _ref1,
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
    _ref1 = this.xhrAccessTokenParams;
    for (key in _ref1) {
      value = _ref1[key];
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
;var RSS;

RSS = (function() {
  function RSS(options) {
    this.options = options != null ? options : {};
    this.url = options.constructor.name === "String" ? options : options.url;
    if (!this.url) {
      throw "URL required";
    }
  }

  return RSS;

})();
;var TouchDB,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

TouchDB = (function() {
  TouchDB.baseURL = "http://.touchdb.";

  function TouchDB(options) {
    var _this = this;
    this.options = options != null ? options : {};
    this.replicateFrom = __bind(this.replicateFrom, this);
    this.fireCallbacks = __bind(this.fireCallbacks, this);
    if (!this.options.name) {
      throw "Database name required";
    }
    this.replicas = {};
    this.baseURL = "" + TouchDB.baseURL + "/" + this.options.name;
    this.eventCallbacks = {};
    this.createDB({}, {
      onSuccess: function() {
        return _this.fireCallbacks('ready');
      },
      onFailure: function(error) {
        if (error.status === 412) {
          return _this.fireCallbacks('ready');
        } else {
          return console.log("unable to initialize database: " + error.error);
        }
      }
    });
    this.startMonitoringChanges({}, {
      onChange: function() {
        return _this.fireCallbacks('change');
      }
    });
  }

  TouchDB.prototype.fireCallbacks = function(name) {
    var callback, _i, _len, _ref, _results;
    if (!this.eventCallbacks[name]) {
      return;
    }
    _ref = this.eventCallbacks[name];
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      callback = _ref[_i];
      _results.push(callback.call());
    }
    return _results;
  };

  TouchDB.prototype.on = function(eventName, callback) {
    var _base;
    (_base = this.eventCallbacks)[eventName] || (_base[eventName] = []);
    return this.eventCallbacks[eventName].push(callback);
  };

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

  TouchDB.prototype.replicateFrom = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return this.startReplication({
      source: options.url,
      target: this.options.name
    }, {
      onSuccess: callbacks.onSuccess,
      onFailure: callbacks.onFailure
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
;var SQLiteDB,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

SQLiteDB = (function() {
  function SQLiteDB(options) {
    this.options = options != null ? options : {};
    this.execute = __bind(this.execute, this);
    this.createTable = __bind(this.createTable, this);
    this.dropTable = __bind(this.dropTable, this);
    this.databaseName = options.constructor.name === "String" ? options : options.name;
    if (!window.sqlitePlugin) {
      throw "window.sqlitePlugin is undefined, please load plugin";
    }
    if (!this.databaseName) {
      throw "database name required";
    }
  }

  SQLiteDB.prototype.dropTable = function(opts, callbacks) {
    var tableName;
    if (opts == null) {
      opts = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    tableName = opts.constructor.name === "String" ? opts : opts.name;
    steroids.debug("dropping table " + tableName);
    return this.execute({
      statement: "DROP TABLE " + tableName
    }, callbacks);
  };

  SQLiteDB.prototype.createTable = function(opts, callbacks) {
    var columnDefinitionString, columnsString, key, statement, tableName, type;
    if (opts == null) {
      opts = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    tableName = opts.constructor.name === "String" ? opts : opts.name;
    statement = "CREATE TABLE " + tableName;
    if (opts.columns != null) {
      columnsString = (function() {
        var _ref, _results;
        _ref = opts.columns;
        _results = [];
        for (key in _ref) {
          type = _ref[key];
          _results.push("" + key + " " + (type.toUpperCase()));
        }
        return _results;
      })();
      columnDefinitionString = columnsString.join(", ");
    }
    steroids.debug("creating table " + tableName + " with " + columnDefinitionString);
    if (columnDefinitionString != null) {
      statement += " (" + columnDefinitionString + ")";
    }
    return this.execute({
      statement: statement
    }, callbacks);
  };

  SQLiteDB.prototype.execute = function(opts, callbacks) {
    var statement,
      _this = this;
    if (opts == null) {
      opts = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    statement = opts.constructor.name === "String" ? opts : opts.statement;
    steroids.debug("stament to execute: " + statement);
    return document.addEventListener('deviceready', function() {
      if (!_this.db) {
        _this.db = window.sqlitePlugin.openDatabase(_this.databaseName);
      }
      return _this.db.transaction(function(tx) {
        var failure, success;
        steroids.debug("execute transaction started");
        success = function(stx, res) {
          var i, rows, _i, _ref;
          rows = [];
          for (i = _i = 0, _ref = res.rows.length - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
            rows.push(res.rows.item(i));
          }
          steroids.debug("execute success, returned " + rows.length + " rows");
          if (callbacks.onSuccess) {
            return callbacks.onSuccess(rows, res, stx);
          }
        };
        failure = function(tx, err) {
          steroids.debug("execute failure -- err.message: " + err.message);
          if (callbacks.onFailure) {
            return callbacks.onFailure(err, tx);
          }
        };
        return tx.executeSql(statement, [], success, failure);
      });
    });
  };

  return SQLiteDB;

})();
;var Analytics;

Analytics = (function() {
  function Analytics() {}

  Analytics.prototype.track = function(event, callbacks) {
    if (event == null) {
      event = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return steroids.nativeBridge.nativeCall({
      method: "recordEvent",
      parameters: {
        type: "custom",
        attributes: event
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return Analytics;

})();
;var Screen,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Screen = (function(_super) {
  __extends(Screen, _super);

  function Screen() {
    Screen.__super__.constructor.call(this, "screen", ["alertdidshow"]);
  }

  Screen.prototype.edges = {
    LEFT: "left",
    RIGHT: "right",
    TOP: "top",
    BOTTOM: "bottom"
  };

  Screen.prototype.freeze = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return steroids.nativeBridge.nativeCall({
      method: "freeze",
      parameters: options,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  Screen.prototype.unfreeze = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return steroids.nativeBridge.nativeCall({
      method: "unfreeze",
      parameters: options,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  Screen.prototype.capture = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return steroids.nativeBridge.nativeCall({
      method: "takeScreenshot",
      parameters: options,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  Screen.prototype.tap = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return steroids.nativeBridge.nativeCall({
      method: "sendTouchEvent",
      parameters: options,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  Screen.prototype.dismissAlert = function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return steroids.nativeBridge.nativeCall({
      method: "dismissAlert",
      parameters: options,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  Screen.mapDegreesToOrientations = function(degrees) {
    if (degrees === 0 || degrees === "0") {
      return "portrait";
    } else if (degrees === 180 || degrees === "180") {
      return "portraitUpsideDown";
    } else if (degrees === -90 || degrees === "-90") {
      return "landscapeLeft";
    } else if (degrees === 90 || degrees === "90") {
      return "landscapeRight";
    } else {
      return degrees;
    }
  };

  Screen.prototype.setAllowedRotations = function(options, callbacks) {
    var allowedRotations;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    allowedRotations = options.constructor.name === "Array" ? options : options.constructor.name === "String" ? [options] : options.allowedRotations;
    if ((allowedRotations == null) || allowedRotations.length === 0) {
      allowedRotations = [0];
    }
    allowedRotations = allowedRotations.map(function(value) {
      return Screen.mapDegreesToOrientations(value);
    });
    return steroids.nativeBridge.nativeCall({
      method: "setAllowedOrientation",
      parameters: {
        allowedRotations: allowedRotations
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  Screen.prototype.rotate = function(options, callbacks) {
    var params;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    params = {};
    params.orientation = options.constructor.name === "String" ? options : options.orientation != null ? options.orientation : "portrait";
    params.orientation = Screen.mapDegreesToOrientations(params.orientation);
    return steroids.nativeBridge.nativeCall({
      method: "setOrientation",
      parameters: params,
      successCallbacks: [callbacks.onSuccess, callbacks.onTransitionStarted],
      recurringCallbacks: [callbacks.onTransitionEnded],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return Screen;

})(EventsSupport);
;var File;

File = (function() {
  function File(options) {
    var _ref;
    if (options == null) {
      options = {};
    }
    this.path = options.constructor.name === "String" ? options : options.path;
    this.relativeTo = (_ref = options.relativeTo) != null ? _ref : steroids.app.path;
  }

  File.prototype.resizeImage = function(options, callbacks) {
    var nativeCompression, parameters, userCompression, _ref, _ref1, _ref2, _ref3;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    if (this.relativeTo !== steroids.app.userFilesPath) {
      throw "Cannot resize images outside `steroids.app.userFilesPath`. Files must first be copied under application document root and then resized.";
    }
    userCompression = (_ref = (_ref1 = options.format) != null ? _ref1.compression : void 0) != null ? _ref : 100;
    nativeCompression = 1 - (userCompression / 100);
    parameters = {
      filenameWithPath: "" + this.relativeTo + "/" + this.path,
      format: (_ref2 = (_ref3 = options.format) != null ? _ref3.type : void 0) != null ? _ref2 : "jpg",
      compression: nativeCompression
    };
    if (options.constraint != null) {
      switch (options.constraint.dimension) {
        case "width":
          parameters.size = {
            width: options.constraint.length
          };
          break;
        case "height":
          parameters.size = {
            height: options.constraint.length
          };
          break;
        default:
          throw "unknown constraint name";
      }
    } else {
      throw "constraint not specified";
    }
    return steroids.nativeBridge.nativeCall({
      method: "resizeImage",
      parameters: parameters,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  File.prototype.unzip = function(options, callbacks) {
    var destinationPath, parameters, sourcePath;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    sourcePath = "" + this.relativeTo + "/" + this.path;
    destinationPath = options.constructor.name === "String" ? options : options.destinationPath;
    parameters = {
      filenameWithPath: sourcePath,
      path: destinationPath
    };
    return steroids.nativeBridge.nativeCall({
      method: "unzip",
      parameters: parameters,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return File;

})();
;var OpenURL;

OpenURL = (function() {
  function OpenURL() {}

  OpenURL.open = function(options, callbacks) {
    var url;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    url = options.constructor.name === "String" ? options : options.url;
    return steroids.nativeBridge.nativeCall({
      method: "openURL",
      parameters: {
        url: url
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return OpenURL;

})();
;var Notifications;

Notifications = (function() {
  function Notifications() {}

  Notifications.prototype.post = function(options, callbacks) {
    var message;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    message = options.constructor.name === "String" ? options : options.message;
    return steroids.nativeBridge.nativeCall({
      method: "postNotification",
      parameters: {
        body: message
      },
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return Notifications;

})();
;var InitialView;

InitialView = (function() {
  function InitialView() {}

  InitialView.prototype.dismiss = function(options, callbacks) {
    var parameters;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    console.log("InitialView.dismiss called");
    parameters = {};
    if (options.animation != null) {
      parameters.animation = options.animation;
    } else {
      parameters.animation = new steroids.Animation({
        transition: "fade"
      });
    }
    return steroids.nativeBridge.nativeCall({
      method: "dismissInitialView",
      parameters: parameters,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  InitialView.prototype.show = function(options, callbacks) {
    var parameters;
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    console.log("InitialView.show called");
    parameters = {};
    if (options.animation != null) {
      parameters.animation = options.animation;
    } else {
      parameters.animation = new steroids.Animation({
        transition: "fade"
      });
    }
    return steroids.nativeBridge.nativeCall({
      method: "showInitialView",
      parameters: parameters,
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  };

  return InitialView;

})();
;var Keyboard,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Keyboard = (function(_super) {
  __extends(Keyboard, _super);

  function Keyboard(options) {
    if (options == null) {
      options = {};
    }
    Keyboard.__super__.constructor.call(this, "keyboard_", ["actionButtonPressed"]);
  }

  return Keyboard;

})(EventsSupport);
;var PostMessage;

PostMessage = (function() {
  function PostMessage() {}

  PostMessage.postMessage = function(message, targetOrigin) {
    var escapedJSONMessage;
    escapedJSONMessage = escape(JSON.stringify(message));
    return steroids.nativeBridge.nativeCall({
      method: "broadcastJavascript",
      parameters: {
        javascript: "steroids.PostMessage.dispatchMessageEvent('" + escapedJSONMessage + "', '*');"
      },
      successCallbacks: [],
      failureCallbacks: [],
      recurringCallbacks: []
    });
  };

  PostMessage.dispatchMessageEvent = function(escapedJSONMessage, targetOrigin) {
    return setTimeout(function() {
      var e, message;
      message = JSON.parse(unescape(escapedJSONMessage));
      e = document.createEvent("MessageEvent");
      e.initMessageEvent("message", false, false, message, "", "", window, null);
      return window.dispatchEvent(e);
    }, 1);
  };

  return PostMessage;

}).call(this);
;var _this = this;

window.steroids = {
  version: "3.5.5",
  Animation: Animation,
  File: File,
  views: {
    WebView: WebView,
    PreviewFileView: PreviewFileView,
    MapView: MapView
  },
  buttons: {
    NavigationBarButton: NavigationBarButton
  },
  data: {
    SQLiteDB: SQLiteDB,
    TouchDB: TouchDB,
    RSS: RSS,
    OAuth2: OAuth2
  },
  openURL: OpenURL.open,
  eventCallbacks: {},
  waitingForComponents: [],
  debugMessages: [],
  debugEnabled: false,
  getApplicationState: function(options, callbacks) {
    if (options == null) {
      options = {};
    }
    if (callbacks == null) {
      callbacks = {};
    }
    return steroids.nativeBridge.nativeCall({
      method: "getApplicationState",
      parameters: {},
      successCallbacks: [callbacks.onSuccess],
      failureCallbacks: [callbacks.onFailure]
    });
  },
  debug: function(msg) {
    var blue, debugMessage, msgJSON, red, reset;
    if (!steroids.debugEnabled) {
      return;
    }
    msgJSON = JSON.stringify(msg);
    red = '\u001b[31m';
    blue = '\u001b[34m';
    reset = '\u001b[0m';
    debugMessage = "[" + red + "DEBUG" + reset + "] - " + msgJSON + " - " + blue + " " + window.location.href + reset;
    window.steroids.debugMessages.push(debugMessage);
    return console.log(debugMessage);
  },
  on: function(event, callback) {
    var _base;
    this.debug("on event " + event);
    if (this["" + event + "_has_fired"] != null) {
      this.debug("on event " + event + ", already fired");
      return callback();
    } else {
      this.debug("on event " + event + ", waiting");
      (_base = this.eventCallbacks)[event] || (_base[event] = []);
      return this.eventCallbacks[event].push(callback);
    }
  },
  fireSteroidsEvent: function(event) {
    var callback, callbacks, _i, _len, _results;
    this.debug("firign event " + event);
    this["" + event + "_has_fired"] = new Date().getTime();
    if (this.eventCallbacks[event] != null) {
      this.debug("firign event " + event + " callbacks");
      callbacks = this.eventCallbacks[event].splice(0);
      _results = [];
      for (_i = 0, _len = callbacks.length; _i < _len; _i++) {
        callback = callbacks[_i];
        this.debug("firing event " + event + " callback");
        _results.push(callback());
      }
      return _results;
    }
  },
  resetSteroidsEvent: function(event) {
    this.debug("resettign event " + event);
    return this["" + event + "_has_fired"] = void 0;
  },
  markComponentReady: function(model) {
    this.debug("" + model + " is ready");
    this.waitingForComponents.splice(this.waitingForComponents.indexOf(model), 1);
    if (this.waitingForComponents.length === 0) {
      this.debug("steroids is ready");
      return this.fireSteroidsEvent("ready");
    }
  }
};

window.steroids.nativeBridge = Bridge.getBestNativeBridge();

window.steroids.waitingForComponents.push("App");

window.steroids.waitingForComponents.push("Events.focuslisteners");

window.steroids.waitingForComponents.push("Events.initialVisibility");

window.steroids.app = new App;

Events.extend();

window.steroids.initialView = new InitialView;

window.steroids.drawers = new DrawerCollection;

window.steroids.layers = new LayerCollection;

window.steroids.view = new steroids.views.WebView({
  location: window.location.href
});

window.steroids.modal = new Modal;

window.steroids.audio = new Audio;

window.steroids.navigationBar = new NavigationBar;

window.steroids.statusBar = new StatusBar;

window.steroids.tabBar = new TabBar;

window.steroids.device = new Device;

window.steroids.analytics = new Analytics;

window.steroids.screen = new Screen;

window.steroids.notifications = new Notifications;

window.steroids.splashscreen = new Splashscreen;

window.steroids.PostMessage = PostMessage;

window.postMessage = PostMessage.postMessage;

window.steroids.logger = new Logger;

window.steroids.logger.queue.autoFlush(100);

window.steroids.keyboard = new Keyboard;

window.addEventListener("error", function(error, url, lineNumber) {
  return steroids.logger.log("" + error.message + " - " + url + ":" + lineNumber);
});

window.steroids.layers.on("didchange", function(event) {
  var dumbElement;
  dumbElement = document.createElement("IMG");
  document.body.appendChild(dumbElement);
  return setTimeout(function() {
    if (dumbElement != null) {
      return document.body.removeChild(dumbElement);
    }
  }, 1);
});

window.shouldRotateToOrientation = function(orientation) {
  return false;
};

})(window);
