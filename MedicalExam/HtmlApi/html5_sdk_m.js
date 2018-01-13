(function() {

    if (typeof iTek == 'undefined') {
        iTek = {};
    }

    iTek.local = {};

    var _native = {
        uuid: 1,
        invokeCBMap: {}
    };

    var _invoke = (function() {
        if (typeof __Native__ == "undefined") {
            return function(module, funcName, params, callback) {
                var data = {};
                data["params"] = params;
                if (callback) {
                    var callbackId = "cb_" + (_native.uuid++) + "_" + new Date().getTime();
                    data["callbackId"] = callbackId;
                    _native.invokeCBMap[callbackId] = callback;
                }
                window.webkit.messageHandlers["invoke"].postMessage([{
                    module: module,
                    funcName: funcName,
                    data: JSON.stringify(data)
                }]);
            }
        } else {
            return function(module, funcName, params, callback) {
                var data = {};
                data["params"] = params;
                if (callback) {
                    var callbackId = "cb_" + (_native.uuid++) + "_" + new Date().getTime();
                    data["callbackId"] = callbackId;
                    _native.invokeCBMap[callbackId] = callback;
                }
                return __Native__.invoke(module, funcName, JSON.stringify(data));
            }
        }
    })();

    iTek.__html5_reg = function(module, methods) {
        var c = iTek[module];
        if (!c) {
            c = (iTek[module] = {});
        }
        var m = methods.split(",");
        m.forEach(function(func) {
            if (c[func]) {
                return;
            }
            c[func] = function() {
                var params = {};
                var callback;
                for (var i = 0; i < arguments.length; i++) {
                    var arg = arguments[i];
                    if (typeof arg == 'function') {
                        if (!callback) {
                            callback = arg;
                        }
                    } else {
                        params["arg_" + i] = arg;
                    }
                }
                return _invoke(module, func, params, callback);
            };
        });
    };

    iTek.__html5_cb = function(result) {
        var callbackId = result["callbackId"];
        if (callbackId) {
            _native.invokeCBMap[callbackId](result.body);
        } else {
            alert(result.body);
        }

        callbackId && (delete _native.invokeCBMap[callbackId]);
    };

    iTek.__html5_evt = function(eventName) {
        if (!this.__events) {
            return;
        }
        var events = this.__events[eventName],
            args = Array.prototype.slice.call(arguments, 1),
            i, m;

        if (!events) {
            return;
        }
        for (i = 0, m = events.length; i < m; i++) {
            events[i].apply(null, args);
        }
    };

    iTek.__html5_setLocalInfo = function(key, data) {
        iTek.local[key] = data;
    };
})();