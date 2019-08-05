#import "kord.audio.h"

@implementation DeviceAudioService

NSString* ERROR_AUDIO_KEY_ALREADY_REGISTERED = @"Error: key already exists";
NSString* ERROR_AUDIO_KEY_NOT_FOUND = @"Error: audio key not found";

NSString* OK_AUDIO_REGISTERED = @"OK: audio registered";
NSString* OK_AUDIO_PLAYING = @"OK: audio playback requested";
NSString* OK_AUDIO_PAUSED = @"OK: audio paused requested";
NSString* OK_AUDIO_VOLUME = @"OK: audio volume adjusted";
NSString* OK_AUDIO_SEEK = @"OK: audio seek requested";

NSString* STATUS_AUDIO_IS_PAUSED = @"Status: audio is paused";
NSString* STATUS_AUDIO_IS_PLAYING = @"Status: audio is playing";
NSString* STATUS_ALL_AUDIO_PLAY = @"Status: all audio is plaiying";
NSString* STATUS_ALL_AUDIO_PAUSE = @"Status: all audio is paused";
NSString* STATUS_ALL_AUDIO_SEEK = @"Status: all audio is seek";
NSString* STATUS_ALL_AUDIO_REMOVED = @"Status: all audio has been removed";

- (void)pluginInitialize
{
    registeredAudioElements = [[NSMutableDictionary alloc] initWithCapacity:2];
}

- (void)addAudioWithIdAndUrl:(CDVInvokedUrlCommand *)command {
	
    [self.commandDelegate runInBackground:^{

		CDVPluginResult *pluginResult;

		NSString *anId = [command.arguments objectAtIndex:0];
		
		if ([registeredAudioElements valueForKey:anId] != nil) {
			// Provide feedback via a callback that the request vas not successful
			pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:ERROR_AUDIO_KEY_ALREADY_REGISTERED];
		}
		else
		{
			DeviceAudioServiceAudioItem *anAudioItem = [[DeviceAudioServiceAudioItem alloc] init];
			anAudioItem.commandDelegate = self.commandDelegate;
			[anAudioItem addAudioWithInvokedUrlCommand:command];

			[registeredAudioElements setObject:anAudioItem forKey:anId];

			// Provide feedback via a callback that the request vas successful
			pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:OK_AUDIO_REGISTERED];

		}

		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

        NSLog(@"registeredAudioElements %@",registeredAudioElements);        
        
    }];

}

- (void)playAudioWithId:(CDVInvokedUrlCommand *)command {

	CDVPluginResult *pluginResult;
	NSString *anId = [command.arguments objectAtIndex:0];
	
	NSLog(@"playAudioWithId %@ %@",anId,[registeredAudioElements valueForKey:[command.arguments objectAtIndex:0]]);

	if ([registeredAudioElements valueForKey:anId] == nil) {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:ERROR_AUDIO_KEY_NOT_FOUND];
	}
	else
	{
		[(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:[command.arguments objectAtIndex:0]] play];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:OK_AUDIO_PLAYING];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)pauseAudioWithId:(CDVInvokedUrlCommand *)command {

	CDVPluginResult *pluginResult;
	NSString *anId = [command.arguments objectAtIndex:0];

	NSLog(@"pauseAudioWithId %@ %@",anId,[registeredAudioElements valueForKey:[command.arguments objectAtIndex:0]]);
	if ([registeredAudioElements valueForKey:anId] == nil) {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:ERROR_AUDIO_KEY_NOT_FOUND];
	}
	else
	{
		[(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:[command.arguments objectAtIndex:0]] pause];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:OK_AUDIO_PAUSED];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}


- (void)volumemaxAudioWithId:(CDVInvokedUrlCommand *)command {
	CDVPluginResult *pluginResult;
	NSString *anId = [command.arguments objectAtIndex:0];

	NSLog(@"pauseAudioWithId %@ %@",anId,[registeredAudioElements valueForKey:[command.arguments objectAtIndex:0]]);
	if ([registeredAudioElements valueForKey:anId] == nil) {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:ERROR_AUDIO_KEY_NOT_FOUND];
	}
	else
	{
		[(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:[command.arguments objectAtIndex:0]] volumemax];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:OK_AUDIO_VOLUME];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}


- (void)volumehalfAudioWithId:(CDVInvokedUrlCommand *)command {
	CDVPluginResult *pluginResult;
	NSString *anId = [command.arguments objectAtIndex:0];

	NSLog(@"pauseAudioWithId %@ %@",anId,[registeredAudioElements valueForKey:[command.arguments objectAtIndex:0]]);
	if ([registeredAudioElements valueForKey:anId] == nil) {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:ERROR_AUDIO_KEY_NOT_FOUND];
	}
	else
	{
		[(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:[command.arguments objectAtIndex:0]] volumehalf];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:OK_AUDIO_VOLUME];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)muteAudioWithId:(CDVInvokedUrlCommand *)command {
	CDVPluginResult *pluginResult;
	NSString *anId = [command.arguments objectAtIndex:0];

	NSLog(@"pauseAudioWithId %@ %@",anId,[registeredAudioElements valueForKey:[command.arguments objectAtIndex:0]]);
	if ([registeredAudioElements valueForKey:anId] == nil) {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:ERROR_AUDIO_KEY_NOT_FOUND];
	}
	else
	{
		[(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:[command.arguments objectAtIndex:0]] mute];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:OK_AUDIO_VOLUME];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

/*
- (void)seekAudioWithId:(CDVInvokedUrlCommand *)command {
	CDVPluginResult *pluginResult;
	NSString *anId = [command.arguments objectAtIndex:0];

	NSLog(@"pauseAudioWithId %@ %@",anId,[registeredAudioElements valueForKey:[command.arguments objectAtIndex:0]]);
	if ([registeredAudioElements valueForKey:anId] == nil) {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:ERROR_AUDIO_KEY_NOT_FOUND];
	}
	else
	{
		[(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:[command.arguments objectAtIndex:0]] seek];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:OK_AUDIO_SEEK];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}*/


- (void)audioWithIdIsPaused:(CDVInvokedUrlCommand *)command {

	NSDictionary *jsonObj;
	NSString *anId = [command.arguments objectAtIndex:0];

	if ([(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:anId] isPaused] == YES) {
		jsonObj = [[NSDictionary alloc] initWithObjectsAndKeys:@"true", @"isPaused",nil];
	}
	else
	{
		jsonObj = [[NSDictionary alloc] initWithObjectsAndKeys:@"false", @"isPaused",nil];
	}
	CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary: jsonObj];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)audioWithIdShouldResumePlayback:(CDVInvokedUrlCommand *)command {
	
	CDVPluginResult *pluginResult;
	NSString *anId = [command.arguments objectAtIndex:0];
	NSDictionary *jsonObj;
	
	if ([(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:anId] shouldResumePlayback] == YES) {
		jsonObj = [[NSDictionary alloc] initWithObjectsAndKeys:@"true", @"shouldResumePlayback",nil];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary: jsonObj];
	}
	else
	{
		jsonObj = [[NSDictionary alloc] initWithObjectsAndKeys:@"false", @"shouldResumePlayback",nil];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary: jsonObj];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)playAllAudio:(CDVInvokedUrlCommand *)command {

	/*for(id key in registeredAudioElements) {
		[(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:key] seek];
		[(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:key] play];
		[(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:key] pause];
		[(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:key] seek];
	}*/

	double delay = 1.00;

    // 2250000000 = 2.25 * 1000000000
    dispatch_time_t offset_time = delay * NSEC_PER_SEC;

    // current mach_absolute_time + offset
    dispatch_time_t fire_time = dispatch_time(DISPATCH_TIME_NOW, offset_time);

    // dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.25), dispatch_get_main_queue(), ^{
	for(id key in registeredAudioElements) {
		dispatch_after(fire_time, dispatch_get_main_queue(), ^{
			//NSLog(@"time %llu", t);
			[(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:key] play];
		});
	}

	/*
	dispatch_time_t playattime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
	for(id key in registeredAudioElements) {
		dispatch_after(playattime, dispatch_get_main_queue(), ^{
			[(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:key] play];
		}
	}*/
	/*
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		for(id key in registeredAudioElements) {
			[(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:key] play];
		}
	});
	*/

	CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:STATUS_ALL_AUDIO_PLAY];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

	NSLog(@"registeredAudioElements %@",registeredAudioElements);
}

- (void)pauseAllAudio:(CDVInvokedUrlCommand *)command {

	for(id key in registeredAudioElements) {
		[(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:key] pause];
	}

	for(id key in registeredAudioElements) {
		[(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:key] seek];
	}

	for(id key in registeredAudioElements) {
		[(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:key] play];
		[(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:key] pause];
	}

	CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:STATUS_ALL_AUDIO_PAUSE];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

	NSLog(@"registeredAudioElements %@",registeredAudioElements);
}

- (void)seekAllAudio:(CDVInvokedUrlCommand *)command {

	for(id key in registeredAudioElements) {
		[(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:key] seek];
	}

	CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:STATUS_ALL_AUDIO_SEEK];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

	NSLog(@"registeredAudioElements %@",registeredAudioElements);
}

- (void)removeAllAudio:(CDVInvokedUrlCommand *)command {

	for(id key in registeredAudioElements) {
		[(DeviceAudioServiceAudioItem *)[registeredAudioElements valueForKey:key] pause];
	}
	
	[registeredAudioElements removeAllObjects];

	CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:STATUS_ALL_AUDIO_REMOVED];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

	NSLog(@"registeredAudioElements %@",registeredAudioElements);
}

@end