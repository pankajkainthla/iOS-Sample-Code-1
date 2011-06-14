//
//  MyViewController.h
//  Empty
//
//  Created by Sergio Botero on 6/12/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBCommitPointsProtocol.h"

@interface MyViewController : UIViewController <SBCommitPointsProtocol>
{
	UILabel * scoreBoard;
	int pointCount;
	NSMutableArray * duckPond;
	NSTimer * swapCheck;
	NSTimer * gameTimer;
}

@property (nonatomic, retain) UILabel * scoreBoard;
@property (nonatomic, retain) NSTimer * swapCheck;
@property (nonatomic, retain) NSTimer * gameTimer;

@end

