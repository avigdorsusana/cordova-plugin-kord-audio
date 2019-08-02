#import <Cordova/CDV.h>
#import <AVFoundation/AVFoundation.h>
#import "kord.audio.item.h"

@interface DeviceAudioService : CDVPlugin {
    NSMutableDictionary *registeredAudioElements;
}

- (void)pluginInitialize;
- (void)addAudioWithIdAndUrl:(CDVInvokedUrlCommand *)command;
- (void)playAudioWithId:(CDVInvokedUrlCommand *)command;
- (void)pauseAudioWithId:(CDVInvokedUrlCommand *)command;
- (void)adjustvolumeAudioWithId:(CDVInvokedUrlCommand *)command;
- (void)removeAllAudio:(CDVInvokedUrlCommand *)command;
- (void)audioWithIdIsPaused:(CDVInvokedUrlCommand *)command;
- (void)audioWithIdShouldResumePlayback:(CDVInvokedUrlCommand *)command;

@end