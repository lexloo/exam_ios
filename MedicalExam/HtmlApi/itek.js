(function() {
	if (typeof iTek == 'undefined') {
		iTek = {};
	}

	/* 原生代码需要这部分支持 End*/
	iTek.__events = {};
	/*绑定事件函数*/
	iTek.on = function(eventName, callback) {
		this.__events[eventName] = this.__events[eventName] || [];
		this.__events[eventName].push(callback);
	};
	/* 原生代码需要这部分支持 Start*/

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