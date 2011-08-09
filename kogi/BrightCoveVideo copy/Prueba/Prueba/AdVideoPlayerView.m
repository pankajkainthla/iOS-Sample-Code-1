//
//  VideoPlayerView.m
//
//  Created by Venkat on 5/17/10.
//  Copyright 2010 Auditude. All rights reserved.
//

#import "AdVideoPlayerView.h"

#define AuditudeZoneID 51301

//#import "VideoViewController.h"

@interface AdVideoPlayerView()

- (void)addMoviePlayerListeners;
- (void)removeMoviePlayerListeners;
- (void)removePlayheadTimer;

@end

@implementation AdVideoPlayerView

@synthesize auditudeView, session, moviePlayer, myViewController;

- (id)init
{
	if (self = [super init])
	{
		MPMoviePlayerController *movieController = [[MPMoviePlayerController alloc] init];
		self.moviePlayer = movieController;
		self.moviePlayer.shouldAutoplay = NO;
		[movieController release];
		
		self.moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
		[self addSubview:self.moviePlayer.view];
		
		// initialize the auditude view.
		self.auditudeView = [[[AuditudeView alloc] init] autorelease];

		// turn off logging
		[AuditudeView enableDebugLog:NO];
		
		// set the dimensions
		self.auditudeView.frame = self.moviePlayer.view.frame;
		self.auditudeView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;		

		// set the delegate on the view
		self.auditudeView.delegate = self;
		
		// add auditude over the video player
		[self addSubview:self.auditudeView];
		
		remainig = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 0, 0)];
		[remainig setTextColor:[UIColor redColor]];
		[remainig setBackgroundColor:[UIColor clearColor]];
		
		[self addSubview:remainig];
	}

	return self;
}

- (void)showVideo:(NSString *)url andID:(long long) videoID
{
	isMainVideoPlaying = false;
	
	// if auditude is currently playing a break, end it.
    [self.auditudeView endBreak];
    [self.moviePlayer stop];
	
	// reset the playbacktime
	playheadTime = -1.0;
	_skipBreak = YES;
	
	videoUrl = [url copy];
	
	// passing key-value pairs to Auditude
	NSMutableDictionary *cp = [[[NSMutableDictionary alloc] init] autorelease];
	//[cp setValue:@"ipad" forKey:@"device"];

	[cp setValue:@"SF" forKey:@"PLR"];
	[cp setValue:@"LIVE" forKey:@"ENV"];
	[cp setValue:@"F" forKey:@"SYN"];
	[cp setValue:@"five.tv" forKey:@"DOM"];
	
	// requesting ads requires three parameters and one optional parameter
	// a) the video id
	// b) zoneId
	// c) domain
	// d) customParams (optional)
	// wait for 'auditudeInitComplete' delegate method to be called.
	//[self.auditudeView requestAdsForVideo:@"asset1" 
	//								   zoneId:9797 domain:@"auditude.com" targetingParams:cp];
	
	[self.auditudeView requestAdsForVideo:[NSString stringWithFormat:@"%llu", videoID] zoneId:AuditudeZoneID domain:@"auditude.com" targetingParams:cp];	
}

-(void)startMainVideo
{
	self.moviePlayer.contentURL = [NSURL URLWithString:videoUrl];
	
	// add listeners to notify auditude.
	[self addMoviePlayerListeners];
	
	// start playing the video
	[moviePlayer play];
	isMainVideoPlaying = true;
	[self.moviePlayer setFullscreen:YES];
	[self.moviePlayer setControlStyle:MPMovieControlStyleEmbedded];
}

- (void)stopMainVideo
{
	[moviePlayer stop];
}


- (void) cancelVideoPlayback {
	[self.auditudeView endBreak];
    [self.moviePlayer stop];
}

#pragma mark -
#pragma mark Auditude Delegate Methods

- (BOOL) shouldAuditudeSkipUpcomingBreak
{
	return _skipBreak;
}

- (void)auditudeInitComplete:(NSDictionary *)data;
{
	NSLog(@"AdEvent: init complete");
	// ads are initialized. begin the break to show the ads.
	[self.auditudeView beginBreak];
}

- (void)auditudeBreakBegin:(NSDictionary *)data;
{
	NSLog(@"AdEvent: break begin");
	_skipBreak = true;
}

- (void)auditudeLinearAdBegin:(NSDictionary *)data;
{
	NSLog(@"AdEvent: linear ad begin");
	
	if (data)
	{
		self.session = [data valueForKey:@"session"];
		[self.session notifyPause]; // to pause the ad
		[self.session notifyPlay]; // to play the ad
	}
}

- (void)skipBreak
{
	_skipBreak = YES;
}

- (void)unskipBreak
{
	_skipBreak = NO;
}

- (void)auditudeLinearAdEnd:(NSDictionary *)data;
{
	NSLog(@"AdEvent: linear ad end");
	//	[self startMainVideo];
	//	[self.auditudeView endBreak];
}

- (void)auditudeLinearAdProgress:(NSTimeInterval)currentPlaybackTime totalTime:(NSTimeInterval)totalTime
{
	[remainig setText:[NSString stringWithFormat:@"Remaining time %d seconds...",  (int)(totalTime - currentPlaybackTime)]];
	[remainig sizeToFit];
	///NSLog(@"AdEvent: linear ad progress: %f", totalTime - currentPlaybackTime);
}

- (void)auditudeBreakEnd:(NSDictionary *)data;
{
	NSLog(@"AdEvent: break end received");
	if (!isMainVideoPlaying)
	{
		[self startMainVideo];
	}

	_skipBreak = YES;
	[self performSelector:@selector(unskipBreak) withObject:nil afterDelay:20.0];

	[[NSNotificationCenter defaultCenter] postNotificationName:@"KGAuditudeBreakEnd" object:nil];
}

- (void)auditudePausePlayback
{
	NSLog(@"AdEvent: pause playback received");
	if (self.moviePlayer) { [self.moviePlayer pause]; }
}

- (void)auditudeResumePlayback
{
	NSLog(@"AdEvent: resume playback received");
	if (self.moviePlayer) { [self.moviePlayer play]; }
}

// set this to true for mid-rolls. Auditude requires playhead update events to be passed
// to show mid-rolls. return NO if you plan to call breakBegin at the appropriate time.
- (BOOL)shouldAuditudeManageBreaks
{
	return YES;
}


#pragma mark -
#pragma mark MoviePlayer Notifications

- (void)addMoviePlayerListeners
{
	if (!listenersAdded)
	{
        // Listen for duration availabile so that we can seek to the current viewing's last stop position (if available)
		[[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(movieDurationAvailable:)
                                                     name:MPMovieDurationAvailableNotification
                                                   object:self.moviePlayer];

		[[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlaybackDidFinish:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:self.moviePlayer];
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(movieLoadStateDidChange:)	
													 name:MPMoviePlayerLoadStateDidChangeNotification
												   object:self.moviePlayer];
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(moviePlaybackStateDidChange:)	
													 name:MPMoviePlayerPlaybackStateDidChangeNotification
												   object:self.moviePlayer];				

		listenersAdded = true;
	}

	[self removePlayheadTimer];
	playheadTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self
												   selector:@selector(moviePlaybackProgress) userInfo:nil repeats:YES];
}

- (void)removeMoviePlayerListeners
{
	if (listenersAdded)
	{
		[[NSNotificationCenter defaultCenter] removeObserver:self
                                                     name:MPMovieDurationAvailableNotification
                                                   object:self.moviePlayer];

		[[NSNotificationCenter defaultCenter] removeObserver:self
														name:MPMoviePlayerPlaybackDidFinishNotification
													  object:self.moviePlayer];
		[[NSNotificationCenter defaultCenter] removeObserver:self
													 name:MPMoviePlayerLoadStateDidChangeNotification
												   object:self.moviePlayer];
		[[NSNotificationCenter defaultCenter] removeObserver:self
													 name:MPMoviePlayerPlaybackStateDidChangeNotification
												   object:self.moviePlayer];						

		listenersAdded = false;
	}

	[self removePlayheadTimer];
}

- (void)removePlayheadTimer
{
	if (playheadTimer != nil)
	{
		[playheadTimer invalidate];
		playheadTimer = nil;
	}
}

- (void)movieDurationAvailable:(NSNotification*)notification
{
	NSLog(@"movie duration available.");
	[[self auditudeView] notify:AuditudeNotificationTypeVideoPlaybackStarted notificationParams:nil];
}

- (void) moviePlaybackDidFinish:(NSNotification*)notification
{
	[self removeMoviePlayerListeners];
	
	if ([notification userInfo])
	{
		NSNumber *reason = (NSNumber *)[[notification userInfo] valueForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
		NSLog(@"movie playback finished. reason: %d", [reason intValue]);
		if ([reason intValue] == MPMovieFinishReasonPlaybackEnded)
		{
			[[self auditudeView] notify:AuditudeNotificationTypeVideoPlaybackComplete notificationParams:nil];
			// call beginBreak on Auditude here again if you want post-rolls. 
			// and after receiving auditudeBreakEnd, make sure to not start the video again.
		}
	}	
	
}

- (void)moviePlaybackStateDidChange:(NSNotification*)notification
{
	// NSLog(@"--->> playback state changed to - %D", self.moviePlayer.playbackState);
}

- (void)movieLoadStateDidChange:(NSNotification *)notification
{
	// NSLog(@"--->> load state changed to - %D", self.moviePlayer.loadState);
}

- (void)moviePlaybackProgress
{
	if (!self.moviePlayer || [self.moviePlayer duration] <= 0.0) { return; }

	NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
	[params setValue:[NSNumber numberWithDouble:self.moviePlayer.currentPlaybackTime] forKey:PlayheadTimeInSeconds];
	[params setValue:[NSNumber numberWithDouble:self.moviePlayer.duration] forKey:TotalTimeInSeconds];

	[self.auditudeView notify:AuditudeNotificationTypeVideoPlayheadUpdate notificationParams:params];
}

#pragma mark -
#pragma mark dealloc

- (void)dealloc
{
	[remainig release];
	[self removeMoviePlayerListeners];
	[moviePlayer release];
	[session release];
	[auditudeView release];
	[super dealloc];
}


@end