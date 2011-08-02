//
//  MarksAndSpencerCatalogAppDelegate.h
//  MarksAndSpencerCatalog
//
//  Created by Sergio Botero on 8/2/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatalogViewController.h"

#import "MessageUI/MFMailComposeViewController.h"

#import "SA_OAuthTwitterEngine.h"
#import "SA_OAuthTwitterController.h"

#import "FBConnect.h"

@interface MarksAndSpencerCatalogAppDelegate : NSObject <UIApplicationDelegate, MFMailComposeViewControllerDelegate, SA_OAuthTwitterControllerDelegate, SA_OAuthTwitterEngineDelegate, FBDialogDelegate, FBSessionDelegate, FBRequestDelegate> {


	UINavigationController * navcont;
	CatalogViewController *cvc;
	UIToolbar * toolbar;

	
	SA_OAuthTwitterEngine * twengine;
    
	Facebook *facebook;
	UIBarButtonItem * facebookShare;
	UIBarButtonItem * twitterShare;
	UIBarButtonItem * mailShare;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) Facebook *facebook;
@end
