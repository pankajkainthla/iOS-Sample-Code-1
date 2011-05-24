//
//  rss_readerAppDelegate.m
//  rss reader
//
//  Created by Sergio Botero on 7/26/10.
//  Copyright (c) 2010 Sergiobuj. All rights reserved.
//


#import "rss_readerAppDelegate.h"
#define randColor ((float) rand() / 1)
@implementation rss_readerAppDelegate


@synthesize window;

@synthesize navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // Add the navigation controller's view to the window and display.

    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {

    // Save data if appropriate.
}

- (void)dealloc {

    [window release];
    [navigationController release];
    [super dealloc];
}

@end

@implementation UINavigationBar (UINavigationBarCategory)

- (void) drawRect:(CGRect)rect{
	UIColor * myColor = [UIColor darkGrayColor];
	UIImage *myImage = [UIImage imageNamed:@"topnav.png"];
	[myImage drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	self.tintColor = myColor;
}

@end

