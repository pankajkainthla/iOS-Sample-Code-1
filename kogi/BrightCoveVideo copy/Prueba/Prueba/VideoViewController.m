//
//  VideoViewController.m
//  Prueba
//
//  Created by Sergio Botero on 8/6/11.
//  Copyright 2011 Kogi Mobile. All rights reserved.
//

#import "VideoViewController.h"

#warning Remove BCTokens import and define 'BCTestToken' or 'BCToken'
#import "BCTokens.h"


@implementation VideoViewController

@synthesize videoID, adVideoPlayer, video, firstUp;

-(void) viewDidLoad{
	[super viewDidLoad];
	self.firstUp = YES;
	fullScreen = self.view.bounds;
	portraitScreen = CGRectMake(00.0f, 30.0f, self.view.bounds.size.width, self.view.bounds.size.height);
	
	UIImage * doneImage = [UIImage imageNamed:@"done"];
	
	
	closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[closeButton setImage:doneImage forState:UIControlStateNormal];
	
	closeButton.frame = CGRectMake(0, 0,doneImage.size.width, doneImage.size.height);
	closeButton.center = CGPointMake(20, 20);
	
	//	[closeButton setTitle:@"close" forState:UIControlStateNormal];
	[closeButton sizeToFit];
	[closeButton addTarget:self action:@selector(cancelVideoPlayback) forControlEvents:UIControlEventTouchUpInside];

	
	self.view.backgroundColor = [UIColor blackColor];
	
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
	if (!self.videoID) {
		//self.videoID = 1093226789001;
		//self.videoID = 1083677626001;
		
	}

	BCMediaAPI * bc = [[BCMediaAPI alloc] initWithReadToken:BCTestToken];
    
	[bc setMediaDeliveryType:BCMediaDeliveryTypeHTTP];
	
	NSError *err = nil;
    video = [bc findVideoById:self.videoID error: &err];
	    
    if (!video) {
        NSString *errStr = [bc getErrorsAsString: err];
        NSLog(@"ERROR: %@", errStr);
    }
	
	adVideoPlayer = [[AdVideoPlayerView alloc] init];
	adVideoPlayer.myViewController = self; 
	adVideoPlayer.frame = portraitScreen;
	[self.view addSubview:adVideoPlayer];
	[adVideoPlayer showVideo:video.FLVURL andID:self.videoID];
	
	[bc release];
	
	viewOverTouchEvent = [[KGAuditudeView alloc] initWithFrame:self.view.frame];
	[self.view addSubview:viewOverTouchEvent];
	[self.view addSubview:closeButton];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touchNotification) name:@"KGAuditiveVideoTouch" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedAdBreak) name:@"KGAuditudeBreakEnd" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelVideoPlayback) name:@"MPMoviePlayerWillExitFullscreenNotification" object:nil];
	
	[closeButton setHidden:YES];
}

- (void) finishedAdBreak {
	NSLog(@"finished break break");

	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"KGAuditiveVideoTouch" object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"KGAuditudeBreakEnd" object:nil];
	[viewOverTouchEvent removeFromSuperview];
	[closeButton setHidden:YES];
}


- (void) touchNotification {
	[closeButton setHidden:![closeButton isHidden]];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	
	if (fromInterfaceOrientation == UIInterfaceOrientationLandscapeRight || fromInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {

		adVideoPlayer.frame =self.view.bounds;

	}else if (fromInterfaceOrientation == UIInterfaceOrientationPortrait || fromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {

		adVideoPlayer.frame = self.view.bounds;
		
	}
	
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation { return YES; }

- (void)viewWillDisappear:(BOOL)animated
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"MPMoviePlayerWillExitFullscreenNotification" object:nil];
    [super viewWillDisappear:animated];
	[[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void) cancelVideoPlayback {
	[self.adVideoPlayer cancelVideoPlayback];
	[self dismissModalViewControllerAnimated:YES];
	[self.adVideoPlayer release];

} 

@end
