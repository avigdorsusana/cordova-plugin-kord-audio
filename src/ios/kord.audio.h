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
- (void)volumemaxAudioWithId:(CDVInvokedUrlCommand *)command;
- (void)volumehalfAudioWithId:(CDVInvokedUrlCommand *)command;
- (void)muteAudioWithId:(CDVInvokedUrlCommand *)command;
- (void)seekAudioWithId:(CDVInvokedUrlCommand *)command;
- (void)removeAllAudio:(CDVInvokedUrlCommand *)command;
- (void)audioWithIdIsPaused:(CDVInvokedUrlCommand *)command;
- (void)audioWithIdShouldResumePlayback:(CDVInvokedUrlCommand *)command;

@end