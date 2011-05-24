//
//  rss_readerAppDelegate.h
//  rss reader
//
//  Created by Sergio Botero on 7/26/10.
//  Copyright (c) 2010 Sergiobuj. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface rss_readerAppDelegate : NSObject <UIApplicationDelegate> {

    UIWindow *window;

    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;


@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@end

