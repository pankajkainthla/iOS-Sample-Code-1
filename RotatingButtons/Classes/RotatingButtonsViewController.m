//
//  RotatingButtonsViewController.m
//  RotatingButtons
//
//  Created by Sergio on 6/9/10.
//  Copyright sergiobuj 2010. All rights reserved.
//

#import "RotatingButtonsViewController.h"

#define kRequestTimeout 1.50

//#define ToDeg(rad) ( (180.0 * (rad)) / M_PI )
//#define kRotationInterval 0.00000005
@implementation RotatingButtonsViewController

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[[UIAccelerometer sharedAccelerometer]setDelegate:self];
	
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotateButtons) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
	first = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[first setTitle:@"1st" forState:UIControlStateNormal];
	first.frame = CGRectMake(0, 0 , 80, 30);
	first.center = CGPointMake(160, 120);
	[first setTag:1];
	//[first addTarget:self action:@selector(yeah:) forControlEvents:UIControlEventTouchUpInside];
	
	second = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[second setTitle:@"2nd" forState:UIControlStateNormal];
	second.frame = CGRectMake(0, 0 , 80, 30);
	second.center = CGPointMake(160, 240);
	[second setTag:2];
	//[second addTarget:self action:@selector(yeah:) forControlEvents:UIControlEventTouchUpInside];
	
	third = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[third setTitle:@"3rd" forState:UIControlStateNormal];
	third.frame = CGRectMake(0, 0 , 80, 30);
	third.center = CGPointMake(160, 360);
	[third setTag:3];
	//[third addTarget:self action:@selector(yeah:) forControlEvents:UIControlEventTouchUpInside];
	
	UIView * view=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	[view setBackgroundColor:[UIColor whiteColor]];
	[view addSubview:first];
	[view addSubview:second];
	[view addSubview:third];

	
	labelView = [[UILabel alloc] initWithFrame:CGRectMake(250, 100, 400, 800)];
	[labelView setLineBreakMode:UILineBreakModeWordWrap];
	[labelView setNumberOfLines:0];
	[view addSubview:labelView];
	[labelView release];
	
	
	self.view=view;
	[view release];

	
}

- (void) rotateButtons{
}
/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations	
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

-(void) accelerometer:(UIAccelerometer *)accelerometerb didAccelerate:(UIAcceleration *)acceleration{

	//NSLog(@"%f", ToDeg(atan2(acceleration.y,acceleration.x)));
	//	NSLog(@"x=%f\t\t\ty=%f\t\t\tatan=%f", acceleration.x, acceleration.y ,atan2(acceleration.y,acceleration.x));
	
	CGFloat zRot = (atan2(acceleration.x, acceleration.y) + M_PI);
	
	first.transform = CGAffineTransformMakeRotation(zRot);
	second.transform = CGAffineTransformMakeRotation(zRot);
	third.transform = CGAffineTransformMakeRotation(zRot);
	
//	first.transform = CGAffineTransformMakeRotation(ToDeg(atan2(acceleration.y,acceleration.x))); 
	
	
	/* from oalTouch apple source -- listener rotation and speaker rotates so always faces the listener
	 
	 
	 // layoutContents gets called via KVO whenever properties within our oalPlayback object change
	 
	 // Wrap these layer changes in a transaction and set the animation duration to 0 so we don't get implicit animation
	 [CATransaction begin];
	 [CATransaction setValue:[NSNumber numberWithDouble:0.] forKey:kCATransactionAnimationDuration];
	 
	 // Position and rotate the listener
	 _listenerLayer.position = playback.listenerPos;
	 _listenerLayer.transform = CATransform3DMakeRotation(playback.listenerRotation, 0., 0., 1.);
	 
	 // The speaker gets rotated so that it's always facing the listener
	 CGFloat rot = atan2(-(playback.sourcePos.x - playback.listenerPos.x), playback.sourcePos.y - playback.listenerPos.y);
	 
	 // Rotate and position the speaker
	 _speakerLayer.position = playback.sourcePos;
	 _speakerLayer.transform = CATransform3DMakeRotation(rot, 0., 0., 1.);
	 
	 [CATransaction commit];
	 
	 
	 */
	
	
	
}

- (void)dealloc {
	[first release];
	[second release];
	[third release];
    [super dealloc];
}


- (void) yeah:(id)sender{
	
	NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://high-flower-68.heroku.com/%d", [sender tag] ]];
//	NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:3000/" ]];
	
	NSURLRequest * urlrequest = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kRequestTimeout];
	NSData *dataobject = [NSURLConnection sendSynchronousRequest:urlrequest returningResponse:nil error:nil];
	NSString * randomNum = [[NSString alloc] initWithData:dataobject encoding:NSASCIIStringEncoding];
	NSString *errorString = nil;
	NSPropertyListFormat format;
	NSDictionary  * webPlist = [NSPropertyListSerialization propertyListFromData:dataobject mutabilityOption:NSPropertyListImmutable format:&format errorDescription:&errorString];
	
	
	for (NSString * key in [webPlist allKeys])
		NSLog(@"%@\t--->\t\n%@", key, [webPlist objectForKey:key]);

	[labelView setText:randomNum];	
	
//	NSLog(@"going to the web");
	
	/*
	 switch ([sender tag]) {
	 case 1:
			[first setTitle:randomNum forState:UIControlStateNormal];

			break;
		case 3:
			[third setTitle:randomNum forState:UIControlStateNormal];

			break;
		case 2:
			[second setTitle:randomNum forState:UIControlStateNormal];
			break;

	}*/
}
@end
