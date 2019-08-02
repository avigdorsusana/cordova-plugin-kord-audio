//http://media.shopy.net/kord/full.mp3

import Foundation

class DeviceAudioService : CDVPlugin {    

    func addAudioWithIdAndUrl(command: CDVInvokedUrlCommand) {        

        println("DeviceAudioService :: addAudioWithIdAndUrl is called")               

        var pluginResult = CDVPluginResult(status: CDVCommandStatus_OK)
        commandDelegate.sendPluginResult(pluginResult, callbackId:command.callbackId)
    }
}