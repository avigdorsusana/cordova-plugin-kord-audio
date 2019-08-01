var argscheck = require('cordova/argscheck'),
    exec = require('cordova/exec');

var mplExport = {
    addAudioWithIdAndUrl: function ( anId, aUrl, aSuccessCallback, aFailureCallback) {
        return cordova.exec(aSuccessCallback, aFailureCallback, "DeviceAudioService", "addAudioWithIdAndUrl", [anId, aUrl]);
    },    
        
    playAudioWithId: function (anId, aSuccessCallback, aFailureCallback) {
        if(voices === undefined) voices = 1;
        return cordova.exec(aSuccessCallback, aFailureCallback, "DeviceAudioService", "playAudioWithId", [anId]);
    },
        
    pauseAudioWithId: function (anId, aSuccessCallback, aFailureCallback) {
        return cordova.exec(aSuccessCallback, aFailureCallback, "DeviceAudioService", "pauseAudioWithId", [anId]);
    },
        
    audioWithIdIsPaused: function (anId, aSuccessCallback, aFailureCallback) {
        return cordova.exec(aSuccessCallback, aFailureCallback, "DeviceAudioService", "audioWithIdIsPaused", [anId]);
    },
        
    audioWithIdShouldResumePlayback: function (anId, aSuccessCallback, aFailureCallback) {
        return cordova.exec(aSuccessCallback, aFailureCallback, "DeviceAudioService", "audioWithIdShouldResumePlayback", [anId]);
    },
        
    removeAllAudio: function (aSuccessCallback, aFailureCallback) {
        return cordova.exec(aSuccessCallback, aFailureCallback, "DeviceAudioService", "removeAllAudio", []);
    }
};

module.exports = mplExport;