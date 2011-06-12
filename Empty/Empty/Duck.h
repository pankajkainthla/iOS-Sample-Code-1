//
//  Duck.h
//  Ducks2
//
//  Created by Sergio Botero on 6/11/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBCommitPointsProtocol.h"

@interface Duck : UIView 
{
	int bonusPoints;
	BOOL isDuck;
	CGPoint position;
	NSTimer * popUpTimer;
	NSTimer * bonusTimer;
	id <SBCommitPointsProtocol> delegate;
}

@property (nonatomic) BOOL isDuck;
@property (nonatomic) CGPoint position;
@property (nonatomic, retain) NSTimer * popUpTimer;
@property (nonatomic, retain) NSTimer * bonusTimer;
@property (nonatomic, assign) id <SBCommitPointsProtocol> delegate;

-(id) initWithPosition:(CGPoint) pos;

@end