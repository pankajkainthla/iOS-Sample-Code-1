//
//  RotatingButtonsAppDelegate.m
//  RotatingButtons
//
//  Created by Sergio on 6/9/10.
//  Copyright sergiobuj 2010. All rights reserved.
//

#import "RotatingButtonsAppDelegate.h"
#import "RotatingButtonsViewController.h"

@implementation RotatingButtonsAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	viewController = [[RotatingButtonsViewController alloc] init];
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
//	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 15.)];
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 100.)];

	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application{	
	NSLog(@"will resign");
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
