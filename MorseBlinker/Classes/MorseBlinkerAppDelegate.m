//
//  MorseBlinkerAppDelegate.m
//  MorseBlinker
//
//  Created by Sergio on 3/25/10.
//  Copyright sergiobuj 2010. All rights reserved.
//

#import "MorseBlinkerAppDelegate.h"

@implementation MorseBlinkerAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	sbview = [[textCreationView alloc] init];
	[window addSubview:sbview.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[sbview release];
    [window release];
    [super dealloc];
}


@end
