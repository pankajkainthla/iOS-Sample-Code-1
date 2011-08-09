//
//  PruebaAppDelegate.h
//  Prueba
//
//  Created by Carlos Arenas on 7/29/11.
//  Copyright 2011 Kogi Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PruebaViewController;

@interface PruebaAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PruebaViewController *viewController;

@end
