//
//  AppDelegate_iPhone.m
//  ClothesCatalog
//
//  Created by Sergio Botero on 12/3/10.
//  Copyright 2010 Sergiobuj. All rights reserved.
//

#import "AppDelegate_iPhone.h"

@implementation AppDelegate_iPhone

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    tabBarController = [[UITabBarController alloc] init];
	
	/* Sección Hombres */
	CommonChooser * tab1 = [[CommonChooser alloc] initWithStyle:UITableViewStyleGrouped andReource:[PlistReader valueForResource:@"men_url" fromPlist:@"xml_resources"] andTitle:@"Hombres"];
	UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:tab1];
	[nav1.tabBarItem setImage:[UIImage imageNamed:@"iconm.png"]];
	[nav1.navigationBar setTintColor:[UIColor blackColor] ];
	[nav1 setTitle:@"Hombres"];
	[tab1 release];
	
	/* Sección Mujeres*/
	CommonChooser * tab2 = [[CommonChooser alloc] initWithStyle:UITableViewStyleGrouped andReource:[PlistReader valueForResource:@"women_url" fromPlist:@"xml_resources"] andTitle:@"Mujeres"];
	UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:tab2];
	[nav2.tabBarItem setImage:[UIImage imageNamed:@"iconf.png"]];
	[nav2.navigationBar setTintColor:[UIColor blackColor] ];
	[nav2 setTitle:@"Mujeres"];
	[tab2 release];

	
	
	
	
	
	

	[tabBarController setViewControllers:[NSArray arrayWithObjects:nav1, nav2, nil]];
	
	[nav1 release];
	[nav2 release];
	
	[self.window addSubview:tabBarController.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[tabBarController release];
    [window release];
    [super dealloc];
}


@end
