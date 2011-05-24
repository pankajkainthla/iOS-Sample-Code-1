//
//  AppDelegate_iPhone.h
//  ClothesCatalog
//
//  Created by Sergio Botero on 12/3/10.
//  Copyright 2010 Sergiobuj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonChooser.h"

@interface AppDelegate_iPhone : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITabBarController * tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

