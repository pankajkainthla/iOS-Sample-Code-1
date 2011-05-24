//
//  WhatsNext.m
//  WhatsNext
//
//  Created by Sergio on 3/30/10.
//  Copyright sergiobuj 2010. All rights reserved.
//

#import "WhatsNext.h"
#import "WNViewController.h"

@implementation WhatsNext

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(validShake) name:@"shake" object:nil ];
	[UIApplication sharedApplication ].statusBarStyle = UIStatusBarStyleBlackOpaque;
	viewController = [[WNViewController alloc] init];
	[window addSubview:viewController.view];
	// Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {

	[viewController release];
    [window release];
    [super dealloc];
}

- (void)
validShake
{
	NSAutoreleasePool * autoPool = [[NSAutoreleasePool alloc]init];
	if(CFAbsoluteTimeGetCurrent() > lastShake + sMinShakeInterval) {
		lastShake = CFAbsoluteTimeGetCurrent();
		[viewController saySomething];
	}
	[autoPool release];
}

@end
