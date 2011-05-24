//
//  WhatsNextWindow.m
//  WhatsNext
//
//  Created by Sergio on 3/30/10.
//  Copyright 2010 sergiobuj. All rights reserved.
//

#import "WhatsNextWindow.h"


@implementation WhatsNextWindow


- (void)
motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{

	if(motion == UIEventSubtypeMotionShake)
	{
		[[NSNotificationCenter defaultCenter] postNotificationName:@"shake" object:self ];
	}

}

- (void)
motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{}

- (void)
motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{}
@end
