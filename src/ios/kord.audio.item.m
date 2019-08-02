#import "kord.audio.item.h"

@implementation DeviceAudioServiceAudioItem

NSString* OK_AUDIO_IS_READY_FOR_PLAYBACK = @"OK: audio is ready for playback";

NSString* ERROR_AVPLAYER_FAILED = @"Error: AVPlayer instance failed";

- (void)addAudioWithInvokedUrlCommand:(CDVInvokedUrlCommand *)command {

	invokedUrlCommand = command;
	theId = [command.arguments objectAtIndex:0];
	theUrl = [NSURL URLWithString:[[command.arguments objectAtIndex:1] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	thePlayer = [[AVPlayer alloc] initWithURL:theUrl];
	[thePlayer addObserver:self forKeyPath:@"status" options:0 context:NULL];

}

- (void)play {
	
	self.isPaused = NO;
	[thePlayer play];
	
}

- (void)pause {
	if ([thePlayer currentTime].value > 0) {
		self.isPaused = YES;
		[thePlayer pause];
	}
}

- (void)volume:(CDVInvokedUrlCommand *)command {
	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
	numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;

	//float theVol = [numberFormatter numberFromString:@"32.12"].floatValue;
	//float theVol = [numberFormatter numberFromString:[command.arguments objectAtIndex:1]].floatValue;

	//theVol = [[command.arguments objectAtIndex:1] floatValue];
	//theVol = theVol / 100.0;
	//if (theVol >= 0.0 || theVol <= 1.0) {
		[thePlayer setVolume: 0];
		//return [thePlayer volume];
	//}
	/*if ([thePlayer currentTime].value > 0) {
		self.isPaused = YES;
		[thePlayer pause];
	}*/
}

- (BOOL)shouldResumePlayback {
	if ([thePlayer currentTime].value > 0 && self.isPaused == YES) {
		return YES;
	}
	else {
		return NO;
	}
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

	CDVPluginResult *pluginResult;
	
    if ([keyPath isEqualToString:@"status"]) {
        if (thePlayer.status == AVPlayerStatusReadyToPlay) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:OK_AUDIO_IS_READY_FOR_PLAYBACK];
        } else if (thePlayer.status == AVPlayerStatusFailed) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:ERROR_AVPLAYER_FAILED];
        }
    }

	[_commandDelegate sendPluginResult:pluginResult callbackId:invokedUrlCommand.callbackId];
}

@end