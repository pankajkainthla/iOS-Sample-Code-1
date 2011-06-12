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

@synthesize scoreBoard;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

 	pointCount = 0;
	
	UIView * funFair = [[UIView alloc] initWithFrame:self.view.frame];

	scoreBoard = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , 30)];
	[scoreBoard setTextColor:[UIColor whiteColor]];
	[scoreBoard setBackgroundColor:[UIColor blackColor]];
	[funFair addSubview:scoreBoard];
	
	CGFloat xPos = self.view.frame.size.width;
	CGFloat yPos = self.view.frame.size.height;
	
	/* First Row Ducks*/ 
	Duck * duck1 = [[Duck alloc] initWithPosition:CGPointMake(xPos * 0.1, yPos * 0.1)];
	[duck1 setDelegate:self];
	[funFair addSubview:duck1];
	
	Duck * duck2 = [[Duck alloc] initWithPosition:CGPointMake(xPos * 0.1, yPos * 0.3)];
	[duck2 setDelegate:self];
	[funFair addSubview:duck2];
	
	Duck * duck3 = [[Duck alloc] initWithPosition:CGPointMake(xPos * 0.1, yPos * 0.5)];
	[duck3 setDelegate:self];
	[funFair addSubview:duck3];

	Duck * duck4 = [[Duck alloc] initWithPosition:CGPointMake(xPos * 0.1, yPos * 0.7)];
	[duck4 setDelegate:self];
	[funFair addSubview:duck4];
	
	Duck * duck5 = [[Duck alloc] initWithPosition:CGPointMake(xPos * 0.1, yPos * 0.9)];
	[duck5 setDelegate:self];
	[funFair addSubview:duck5];

	/* Second Row Ducks*/ 
	Duck * duck6 = [[Duck alloc] initWithPosition:CGPointMake(xPos * 0.4, yPos * 0.2)];
	[duck6 setDelegate:self];
	[funFair addSubview:duck6];

	Duck * duck7 = [[Duck alloc] initWithPosition:CGPointMake(xPos * 0.4, yPos * 0.4)];
	[duck7 setDelegate:self];
	[funFair addSubview:duck7];
	
	Duck * duck8 = [[Duck alloc] initWithPosition:CGPointMake(xPos * 0.4, yPos * 0.6)];
	[duck8 setDelegate:self];
	[funFair addSubview:duck8];
	
	Duck * duck9 = [[Duck alloc] initWithPosition:CGPointMake(xPos * 0.4, yPos * 0.8)];
	[duck9 setDelegate:self];
	[funFair addSubview:duck9];
		
	/* Third Row Ducks*/ 
	Duck * duck10 = [[Duck alloc] initWithPosition:CGPointMake(xPos * 0.7, yPos * 0.3)];
	[duck10 setDelegate:self];
	[funFair addSubview:duck10];

	Duck * duck11 = [[Duck alloc] initWithPosition:CGPointMake(xPos * 0.7, yPos * 0.5)];
	[duck11 setDelegate:self];
	[funFair addSubview:duck11];
	
	Duck * duck12 = [[Duck alloc] initWithPosition:CGPointMake(xPos * 0.7, yPos * 0.7)];
	[duck12 setDelegate:self];
	[funFair addSubview:duck12];
	
	[self setView:funFair];
}

- (void) commitHitPoints:(int) points{
	pointCount += points;
	[scoreBoard setText:[NSString stringWithFormat:@"total:%d  last-hit:%d", pointCount, points ]];
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
