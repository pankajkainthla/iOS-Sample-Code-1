//
//  VideoViewController.h
//  Prueba
//
//  Created by Sergio Botero on 8/6/11.
//  Copyright 2011 Kogi Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BCMediaAPI.h"
//#import "BCMoviePlayerController.h"
//#import "BCItemCollection.h"

#import "AdVideoPlayerView.h"

#import "KGAuditudeView.h"

@interface VideoViewController : UIViewController
{
	UIButton * closeButton;
	CGRect fullScreen;
	CGRect portraitScreen;
	BOOL firstUp;
	
	KGAuditudeView * viewOverTouchEvent;
}
@property (nonatomic) long long videoID;
@property (nonatomic, retain) AdVideoPlayerView * adVideoPlayer;
@property (nonatomic, retain) BCVideo *video;
@property (nonatomic) BOOL firstUp;

@end
