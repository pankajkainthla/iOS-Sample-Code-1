//
//  PresenceAppDelegate.h
//  Presence
//
//  Created by Sergio on 6/18/09.
//  Copyright sergiobuj@gmail.com 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "theTableView.h"
#import "SearchTableView.h"

@interface PresenceAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow *window;
	UITabBarController *mainTabBar;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

