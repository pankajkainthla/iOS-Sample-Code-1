//
//  WNViewController.m
//  WhatsNext
//
//  Created by Sergio on 3/30/10.
//  Copyright 2010 sergiobuj. All rights reserved.
//

#import "WNViewController.h"


@implementation WNViewController

/*
	// The designated initializer.  Override if you create the controller programmatically and want to 
 perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
			// Custom initialization
    }
    return self;
}*/



// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	NSString * labelText = [NSString stringWithString:NSLocalizedString(@"first_string",@"text to instruct the shake")];
	currentCategory = CAT1;
	mainView =[[UIView alloc] initWithFrame:[[UIScreen mainScreen]applicationFrame]];

	mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 1000)];
	mainLabel.center = CGPointMake([[UIScreen mainScreen]applicationFrame].size.width/2.0, [[UIScreen mainScreen]applicationFrame].size.height/2.0);
	mainLabel.textAlignment = UITextAlignmentCenter;
	
	[mainLabel setText:labelText];
	[mainLabel setFont:[UIFont fontWithName:s_font_name size:(CGFloat)s_font_size]];
	[mainLabel setTextColor:[UIColor whiteColor]];
	[mainLabel setBackgroundColor:[UIColor blackColor]];
	[mainView addSubview:mainLabel];
	[mainLabel setAutoresizingMask:(1<<6)-1];
	[mainLabel setNumberOfLines:0];
	
	self.view=mainView;
	[mainView release];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	// return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[mainLabel release];
    [super dealloc];
}



- (void) saySomething
{
	[mainLabel setText:[WhatsNextGen nextString:currentCategory++]];
	if (currentCategory > CAT3) {
		currentCategory = CAT1;
	}

}

@end
