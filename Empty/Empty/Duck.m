//
//  Duck.m
//  Ducks2
//
//  Created by Sergio Botero on 6/11/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import "Duck.h"

@interface Duck (hidden)
-(void) bonusCount;
@end

@implementation Duck

@synthesize duckType, position, bonusTimer, isUp;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    id me = [super initWithFrame:frame];
    if (me) {
		[me setPosition:CGPointMake(frame.origin.x, frame.origin.y)];
	}
    return me;
}

-(id) initWithPosition:(CGPoint) pos andTargetType:(SBTType) type;
{
	self = [self initWithFrame:CGRectMake(pos.x, pos.y, 50, 50)];
	
	if( type == SBTTyellowDuck)
		[self setBackgroundColor:[UIColor yellowColor]];
	else if( type == SBTTblueDuck)
		[self setBackgroundColor:[UIColor blueColor]];
	
	[self setIsUp:YES];
	
	return self;
}

- (void) duckUpAs:(SBTType) type {
	bonusPoints = 3;
	[self setIsUp:YES];
	[self setDuckType:type];
	if( type == SBTTyellowDuck)
		[self setBackgroundColor:[UIColor yellowColor]];
	else if( type == SBTTblueDuck)
		[self setBackgroundColor:[UIColor blueColor]];
	else
		[self setBackgroundColor:[UIColor redColor]];
	
	[UIView beginAnimations:@"duckup" context:nil];
	[UIView setAnimationDuration:0.1];
	[self setFrame:CGRectMake([self position].x, [self position].y, 50, 50)];
	[UIView commitAnimations];
	[self setBonusTimer:[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(bonusCount) userInfo:nil repeats:YES]];
}

- (void) duckDown {
	[self setIsUp:NO];
	[UIView beginAnimations:@"duckdn" context:nil];
	[UIView setAnimationDuration:0.1];
	[self setFrame:CGRectMake([self position].x, [self position].y, 0, 50)];
	[UIView commitAnimations];
	
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

	int shootPoints = 0;
	switch (duckType) {
		case SBTTyellowDuck:
			shootPoints = (bonusPoints > 0)? 12 : 10;
			break;
		case SBTTblueDuck:
			shootPoints = (bonusPoints > 0)? 14 : 10 ;
			break;
		case SBTTgoose:
			shootPoints = -20;
			break;
		default:
			break;
	}
	[self.delegate commitHitPoints:shootPoints];
	[self duckDown];	
}

-(void) bonusCount {
	bonusPoints--;
	if(bonusPoints == 0) [self.bonusTimer invalidate];
}

@end
