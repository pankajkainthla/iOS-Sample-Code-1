//
//  MyViewController.m
//  Empty
//
//  Created by Sergio Botero on 6/12/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import "MyViewController.h"
#import "Duck.h"

@implementation MyViewController

@synthesize scoreBoard, swapCheck, gameTimer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	duckPond = [[NSMutableArray alloc] init];
 	pointCount = 0;
	
	UIView * funFair = [[UIView alloc] initWithFrame:self.view.frame];

	scoreBoard = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , 30)];
	[scoreBoard setTextColor:[UIColor whiteColor]];
	[scoreBoard setBackgroundColor:[UIColor blackColor]];
	[funFair addSubview:scoreBoard];
	
	CGFloat xPos = self.view.frame.size.width;
	CGFloat yPos = self.view.frame.size.height;
	
	/* First Row Ducks*/ 
	Duck * duck1 = [[Duck alloc] initWithPosition:CGPointMake(xPos * 0.1, yPos * 0.1) andTargetType:SBTTyellowDuck];
	[duck1 setDelegate:self];
	[funFair addSubview:duck1];
	[duckPond addObject:duck1];
	
	Duck * duck2 = [[Duck alloc] initWithPosition:CGPointMake(xPos * 0.1, yPos * 0.3) andTargetType:SBTTblueDuck];
	[duck2 setDelegate:self];
	[funFair addSubview:duck2];
	[duckPond addObject:duck2];
	
	Duck * duck3 = [[Duck alloc] initWithPosition:CGPointMake(xPos * 0.1, yPos * 0.5) andTargetType:SBTTyellowDuck];
	[duck3 setDelegate:self];
	[funFair addSubview:duck3];
	[duckPond addObject:duck3];

	Duck * duck4 = [[Duck alloc] initWithPosition:CGPointMake(xPos * 0.1, yPos * 0.7) andTargetType:SBTTblueDuck];
	[duck4 setDelegate:self];
	[funFair addSubview:duck4];
	[duckPond addObject:duck4];
	
	Duck * duck5 = [[Duck alloc] initWithPosition:CGPointMake(xPos * 0.1, yPos * 0.9) andTargetType:SBTTyellowDuck];
	[duck5 setDelegate:self];
	[funFair addSubview:duck5];
	[duckPond addObject:duck5];
	
	/* Second Row Ducks*/ 
	Duck * duck6 = [[Duck alloc] initWithPosition:CGPointMake(xPos * 0.4, yPos * 0.2) andTargetType:SBTTyellowDuck];
	[duck6 setDelegate:self];
	[funFair addSubview:duck6];
	[duckPond addObject:duck6];
	
	Duck * duck7 = [[Duck alloc] initWithPosition:CGPointMake(xPos * 0.4, yPos * 0.4) andTargetType:SBTTblueDuck];
	[duck7 setDelegate:self];
	[funFair addSubview:duck7];
	[duckPond addObject:duck7];
	
	Duck * duck8 = [[Duck alloc] initWithPosition:CGPointMake(xPos * 0.4, yPos * 0.6) andTargetType:SBTTblueDuck];
	[duck8 setDelegate:self];
	[funFair addSubview:duck8];
	[duckPond addObject:duck8];
	
	Duck * duck9 = [[Duck alloc] initWithPosition:CGPointMake(xPos * 0.4, yPos * 0.8) andTargetType:SBTTyellowDuck];
	[duck9 setDelegate:self];
	[funFair addSubview:duck9];
	[duckPond addObject:duck9];
	
	/* Third Row Ducks*/ 
	Duck * duck10 = [[Duck alloc] initWithPosition:CGPointMake(xPos * 0.7, yPos * 0.3) andTargetType:SBTTyellowDuck];
	[duck10 setDelegate:self];
	[funFair addSubview:duck10];
	[duckPond addObject:duck10];
	
	Duck * duck11 = [[Duck alloc] initWithPosition:CGPointMake(xPos * 0.7, yPos * 0.5) andTargetType:SBTTblueDuck];
	[duck11 setDelegate:self];
	[funFair addSubview:duck11];	
	[duckPond addObject:duck11];
	
	Duck * duck12 = [[Duck alloc] initWithPosition:CGPointMake(xPos * 0.7, yPos * 0.7) andTargetType:SBTTyellowDuck];
	[duck12 setDelegate:self];
	[funFair addSubview:duck12];
	[duckPond addObject:duck12];
	
	[self setView:funFair];
	
	[self setSwapCheck:[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(duckSwap) userInfo:nil repeats:YES]];
	[self setGameTimer:[NSTimer scheduledTimerWithTimeInterval:45.0 target:self selector:@selector(endGame) userInfo:nil repeats:NO]];
}

- (void) commitHitPoints:(int) points{
	pointCount += points;
	[scoreBoard setText:[NSString stringWithFormat:@"total:%d  last-hit:%d", pointCount, points]];
}

- (void) duckSwap {
	for (Duck * target in duckPond) {

		if ( (rand() % 100)/100.0 < .30) {
			if ([target isUp]){
				[target duckDown];	
			} else {
				double random = (rand()%100)/100.0;
				int newDuckType = ( random < .50)? SBTTyellowDuck : (random > .80)? SBTTgoose : SBTTblueDuck ;
				[target duckUpAs: newDuckType];
			}
		}

	}	
}


-(void) endGame {
	[gameTimer invalidate];
	[swapCheck invalidate];
	UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setTextColor:[UIColor purpleColor]];
	[label setFont:[UIFont systemFontOfSize:35]];
	[label setText:[NSString stringWithFormat:@"total:%d", pointCount]];
	[self.view addSubview:label];

}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
