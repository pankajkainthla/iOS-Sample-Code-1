//
//  PresenceAppDelegate.m
//  Presence
//
//  Created by Sergio on 6/18/09.
//  Copyright sergiobuj@gmail.com 2009. All rights reserved.
//

#import "PresenceAppDelegate.h"

@implementation PresenceAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	mainTabBar = [[UITabBarController alloc] init];

	//First tab
	UINavigationController *navController = [[UINavigationController alloc] init];
	navController.tabBarItem.image = [UIImage imageNamed:@"faves.png"];
	theTableView *tableView = [[theTableView alloc] initTheTableView:YES style:UITableViewStylePlain];
	tableView.view.frame = [UIScreen mainScreen].applicationFrame;
	[navController pushViewController:tableView animated:NO];
	[tableView release];

	UINavigationController *navController2 = [[UINavigationController alloc] init];
	navController2.tabBarItem.image = [UIImage imageNamed:@"all.png"];
	theTableView *tableView2 = [[theTableView alloc] initTheTableView:NO style:UITableViewStylePlain];
	tableView2.view.frame = [UIScreen mainScreen].applicationFrame;
	[navController2 pushViewController:tableView2 animated:NO];
	[tableView2 release];
	
	UINavigationController *navController3 =[[UINavigationController alloc ] init];
	navController3.tabBarItem.image = [UIImage imageNamed:@"search.png"];
	SearchTableView *search = [[SearchTableView alloc] initWithStyle:UITableViewStyleGrouped];
	search.view.frame = [UIScreen mainScreen].applicationFrame;
	[navController3 pushViewController:search animated:NO];
	[search release];

	[mainTabBar setViewControllers:[NSArray arrayWithObjects:navController,navController2,navController3,nil] animated:YES];
	[window addSubview:mainTabBar.view];
	

	[navController release];
	[navController2 release];
	[navController3 release];	
	[window makeKeyAndVisible];
}

- (void)dealloc {
//	NSLog(@"presence delegate dealloc");
	[mainTabBar release];
    [window release];
    [super dealloc];
}

@end
