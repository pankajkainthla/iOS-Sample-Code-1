//
//  VideoPlayerView.h
//
//  Created by Venkat on 5/17/10.
//  Copyright 2010 Auditude. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerController.h>

#import "AuditudeView.h"
#import "AuditudeViewDelegateProtocol.h"
#import "AuditudeAdPlaybackSession.h"

@class VideoViewController;

@interface AdVideoPlayerView:UIView <AuditudeViewDelegate>
{
	AuditudeView *auditudeView;
	AuditudeAdPlaybackSession *session;
	MPMoviePlayerController *moviePlayer;
	NSString *videoUrl;
	bool listenersAdded;
	bool isMainVideoPlaying;
	NSTimer *playheadTimer;
	NSTimeInterval playheadTime;
	BOOL _skipBreak;

	UILabel * remainig;
}

@property (nonatomic, retain) AuditudeView *auditudeView;
@property (nonatomic, retain) AuditudeAdPlaybackSession *session;
@property (nonatomic, retain) MPMoviePlayerController *moviePlayer;
@property (nonatomic, assign) VideoViewController * myViewController;

- (void)showVideo:(NSString *)url andID:(long long) videoID;
- (void)startMainVideo;
- (void)stopMainVideo;

- (void)skipBreak;
- (void)unskipBreak;

- (void)cancelVideoPlayback;
@end