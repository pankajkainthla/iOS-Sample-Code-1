//
//  Duck.m
//  Ducks2
//
//  Created by Sergio Botero on 6/11/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import "Duck.h"

#define DuckPercentage 90

@interface Duck (hidden)
-(void) duckDown;
-(void) duckUp;
-(void) bonusCount;
@end

@implementation Duck

@synthesize isDuck, position, popUpTimer, bonusTimer;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

		[self setPosition:CGPointMake(frame.origin.x, frame.origin.y)];
		isDuck = (rand() % 100 > DuckPercentage)? NO : YES;
		if (isDuck) {
			[self setBackgroundColor:[UIColor yellowColor]];
		}else{
			[self setBackgroundColor:[UIColor redColor]];
		}
		[self duckDown];
		[self.popUpTimer invalidate];
		[self setPopUpTimer:[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(duckUp) userInfo:nil repeats:NO]];
	}
    return self;
}

- (id)initWithPosition:(CGPoint) pos 
{
	//	NSLog(@"pato pos");
	return [self initWithFrame:CGRectMake(pos.x, pos.y, 0, 50)];
}

- (void) duckUp {
	bonusPoints = 2;
	[[self popUpTimer] invalidate];
	isDuck = (rand() % 100 > DuckPercentage)? NO : YES;
	if (isDuck) {
		[self setBackgroundColor:[UIColor yellowColor]];
	}else{
		[self setBackgroundColor:[UIColor redColor]];
	}
	
	[UIView beginAnimations:@"duckup" context:nil];
	[UIView setAnimationDuration:0.1];
	[self setFrame:CGRectMake([self position].x, [self position].y, 50, 50)];
	[UIView commitAnimations];
	[self setBonusTimer:[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(bonusCount) userInfo:nil repeats:YES]];
	[self setPopUpTimer:[NSTimer scheduledTimerWithTimeInterval:((rand() % 10)+ 0.5) target:self selector:@selector(duckDown) userInfo:nil repeats:NO]];
}

- (void) duckDown {
	[[self popUpTimer] invalidate];
	[UIView beginAnimations:@"duckdn" context:nil];
	[UIView setAnimationDuration:0.1];
	[self setFrame:CGRectMake([self position].x, [self position].y, 0, 50)];
	[UIView commitAnimations];
	[self setPopUpTimer:[NSTimer scheduledTimerWithTimeInterval:((rand() % 10)+ 0.5) target:self selector:@selector(duckUp) userInfo:nil repeats:NO]];
	
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

	if (isDuck) {
		if (bonusPoints > 0) {
			[self.delegate commitHitPoints:(20+30)];
		}else{
			[self.delegate commitHitPoints:20];
		}
	}else{
		[self.delegate commitHitPoints:-60];
	}

	[self duckDown];	
}

-(void) bonusCount {
	bonusPoints--;
	if(bonusPoints == 0) [self.bonusTimer invalidate];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
