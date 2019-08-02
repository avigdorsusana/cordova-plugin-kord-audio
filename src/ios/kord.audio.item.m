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

- (void)volumemax {
	[thePlayer setVolume: 1];
}
- (void)volumehalf {
	[thePlayer setVolume: 0.3];
}
- (void)mute {
	[thePlayer setVolume: 0];
}

- (void)seek {
	//double position = [[command argumentAtIndex:1] doubleValue];
	double position = 1000;
    double posInSeconds = position / 1000;

   
        int32_t timeScale = [thePlayer currentItem].asset.duration.timescale;
        //CMTime timeToSeek = CMTimeMakeWithSeconds(posInSeconds, timeScale);
	
        //BOOL isPlaying = (avPlayer.rate > 0 && !avPlayer.error);
        //BOOL isReadyToSeek = (avPlayer.status == AVPlayerStatusReadyToPlay) && (avPlayer.currentItem.status == AVPlayerItemStatusReadyToPlay);

        // CB-10535:
        // When dealing with remote files, we can get into a situation where we start playing before AVPlayer has had the time to buffer the file to be played.
        // To avoid the app crashing in such a situation, we only seek if both the player and the player item are ready to play. If not ready, we send an error back to JS land.
        //if(isReadyToSeek) {

			/*
            [thePlayer seekToTime: timeToSeek
                 toleranceBefore: kCMTimeZero
                  toleranceAfter: kCMTimeZero
               completionHandler: ^(BOOL finished) {
                   if (!isPaused) [avPlayer play];
               }];*/

        //} else {
        //    NSString* errMsg = @"AVPlayerItem cannot service a seek request with a completion handler until its status is AVPlayerItemStatusReadyToPlay.";
        //    [self onStatus:MEDIA_ERROR mediaId:mediaId param:
        //      [self createAbortError:errMsg]];
        //}
    }






	//int32_t timeScale = [thePlayer currentTime].asset.duration.timescale;
    //CMTime timeToSeek = CMTimeMakeWithSeconds(1000, timeScale);
	//[thePlayer seekToTime: 1000];
	
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