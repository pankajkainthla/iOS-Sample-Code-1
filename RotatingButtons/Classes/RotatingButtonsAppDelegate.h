//
//  RotatingButtonsAppDelegate.h
//  RotatingButtons
//
//  Created by Sergio on 6/9/10.
//  Copyright sergiobuj 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RotatingButtonsViewController;

@interface RotatingButtonsAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    RotatingButtonsViewController *viewController;
}

@property (nonatomic, retain)  UIWindow *window;
@property (nonatomic, retain)  RotatingButtonsViewController *viewController;

@end

