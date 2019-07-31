var exec = require('cordova/exec');

exports.sayHello = function(arg0, success, error) {
    alert("exports.sayHello "+arg0);
    exec(success, error, "Hello", "sayHello", [arg0]);
};