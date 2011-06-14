//
//  Duck.h
//  Ducks2
//
//  Created by Sergio Botero on 6/11/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBCommitPointsProtocol.h"


enum {
	SBTTblueDuck = 0,
	SBTTyellowDuck,
	SBTTgoose
};

typedef NSInteger SBTType;

@interface Duck : UIView 
{
	SBTType duckType;
	
	int bonusPoints;
	
	BOOL isUp;
	
	CGPoint position;
	
	NSTimer * bonusTimer;
	
	id <SBCommitPointsProtocol> delegate;
}

@property (nonatomic) SBTType duckType;
@property (nonatomic) BOOL isUp;
@property (nonatomic) CGPoint position;

@property (nonatomic, retain) NSTimer * bonusTimer;

@property (nonatomic, assign) id <SBCommitPointsProtocol> delegate;


-(id) initWithPosition:(CGPoint) pos andTargetType:(SBTType) type;
-(void) duckDown;
-(void) duckUpAs:(SBTType)type;

@end