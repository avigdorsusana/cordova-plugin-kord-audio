var cordova = require('cordova');

var Echo = {
	echo: function(str, callback) {
    	cordova.exec(callback, function(err) {
    		callback('Nothing to echo.');
    	}, "Echo", "echo", [str]);
    }
}

module.exports = Echo;