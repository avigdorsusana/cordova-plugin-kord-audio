var argscheck = require('cordova/argscheck'),
    exec = require('cordova/exec');

var mplExport = {
    addAudioWithIdAndUrl: function (anId, aUrl, aSuccessCallback, aFailureCallback) {
        return cordova.exec(aSuccessCallback, aFailureCallback, "DeviceAudioService", "addAudioWithIdAndUrl", [anId, aUrl]);
    },    
        
    playAudioWithId: function (anId, aSuccessCallback, aFailureCallback) {
        if(voices === undefined) voices = 1;
        return cordova.exec(aSuccessCallback, aFailureCallback, "DeviceAudioService", "playAudioWithId", [anId]);
    },
        
    pauseAudioWithId: function (anId, aSuccessCallback, aFailureCallback) {
        return cordova.exec(aSuccessCallback, aFailureCallback, "DeviceAudioService", "pauseAudioWithId", [anId]);
	},

	volumemaxAudioWithId: function (anId, aVol, aSuccessCallback, aFailureCallback) {
        return cordova.exec(aSuccessCallback, aFailureCallback, "DeviceAudioService", "volumemaxAudioWithId", [anId, aVol]);
	},
	
	volumehalfAudioWithId: function (anId, aVol, aSuccessCallback, aFailureCallback) {
        return cordova.exec(aSuccessCallback, aFailureCallback, "DeviceAudioService", "volumehalfAudioWithId", [anId, aVol]);
	},
	
	muteAudioWithId: function (anId, aVol, aSuccessCallback, aFailureCallback) {
        return cordova.exec(aSuccessCallback, aFailureCallback, "DeviceAudioService", "muteAudioWithId", [anId, aVol]);
	},
	
	/*seekAudioWithId: function (anId, aVol, aSuccessCallback, aFailureCallback) {
        return cordova.exec(aSuccessCallback, aFailureCallback, "DeviceAudioService", "seekAudioWithId", [anId, aVol]);
    },*/
        
    audioWithIdIsPaused: function (anId, aSuccessCallback, aFailureCallback) {
        return cordova.exec(aSuccessCallback, aFailureCallback, "DeviceAudioService", "audioWithIdIsPaused", [anId]);
    },
        
    audioWithIdShouldResumePlayback: function (anId, aSuccessCallback, aFailureCallback) {
        return cordova.exec(aSuccessCallback, aFailureCallback, "DeviceAudioService", "audioWithIdShouldResumePlayback", [anId]);
    },
        
    playAllAudio: function (aSuccessCallback, aFailureCallback) {
        return cordova.exec(aSuccessCallback, aFailureCallback, "DeviceAudioService", "playAllAudio", []);
	},

	seekAllAudio: function (aSuccessCallback, aFailureCallback) {
        return cordova.exec(aSuccessCallback, aFailureCallback, "DeviceAudioService", "seekAllAudio", []);
	},
	
	pauseAllAudio: function (aSuccessCallback, aFailureCallback) {
        return cordova.exec(aSuccessCallback, aFailureCallback, "DeviceAudioService", "pauseAllAudio", []);
	},
	
	removeAllAudio: function (aSuccessCallback, aFailureCallback) {
        return cordova.exec(aSuccessCallback, aFailureCallback, "DeviceAudioService", "removeAllAudio", []);
    },
};

module.exports = mplExport;