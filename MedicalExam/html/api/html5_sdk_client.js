(function() {
	if (typeof iTek == 'undefined') {
		iTek = {};
	}

	iTek.__events = {};
	/*绑定事件函数*/
	iTek.on = function(eventName, callback) {
		this.__events[eventName] = this.__events[eventName] || [];
		this.__events[eventName].push(callback);
	};
	
	iTek.format = function(template, data) {
		return template.replace(/\{([\w\.]*)\}/g, function(str, key) {
			var keys = key.split(".");
			var v = data[keys.shift()];
			for (var i = 0, l = keys.length; i < l; i++) {
				v = v[keys[i]];
			}
			return (typeof v !== "undefined" && v !== null) ? v : "";
		});
	};
})();