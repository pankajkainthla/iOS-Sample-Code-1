//
//  MarksAndSpencerCatalogAppDelegate.m
//  MarksAndSpencerCatalog
//
//  Created by Sergio Botero on 8/2/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import "MarksAndSpencerCatalogAppDelegate.h"
#import "CatalogViewController.h"


@interface MarksAndSpencerCatalogAppDelegate ()
- (void) shareMail:(id) sender;
- (void) shareTW:(id) sender;
- (void) shareFB:(id) sender;
- (void) setButtons;
- (void) setShares;
- (NSString *) messageString;


@end

@implementation MarksAndSpencerCatalogAppDelegate

@synthesize window = _window, facebook;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	CGRect bounds = [UIScreen mainScreen].applicationFrame;
	
	toolbar = [[UIToolbar alloc] init];
	[toolbar sizeToFit];
	toolbar.frame = CGRectMake(0, CGRectGetMaxY(bounds) - toolbar.frame.size.height, bounds.size.width, toolbar.frame.size.height);
	
	[self setButtons];
	[self setShares];
	
	
	cvc = [[CatalogViewController alloc] init];	
	
	navcont = [[UINavigationController alloc] initWithRootViewController:cvc];
	[navcont.view addSubview:toolbar];
	
	[self.window addSubview:navcont.view];
	
	[self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	/*
	 Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	 Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	 */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	/*
	 Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	 If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	 */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	/*
	 Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	 */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	/*
	 Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	 */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	/*
	 Called when the application is about to terminate.
	 Save data if appropriate.
	 See also applicationDidEnterBackground:.
	 */
}


- (void) setButtons {
	UIBarButtonItem *TWButton = [[UIBarButtonItem alloc]
								   initWithTitle:@"TW" style:UIBarButtonItemStyleBordered target:self action:@selector(shareTW:)];

	
	
	UIBarButtonItem *MailButton = [[UIBarButtonItem alloc]
								   initWithTitle:@"Mail" style:UIBarButtonItemStyleBordered target:self action:@selector(shareMail:)];
	
	
	
	UIBarButtonItem *FBButton = [[UIBarButtonItem alloc]
								 initWithTitle:@"FB" style:UIBarButtonItemStyleBordered target:self action:@selector(shareFB:)];
	
	
	[toolbar setItems:[NSArray arrayWithObjects:TWButton, FBButton, MailButton,nil]];
}

- (void) setShares {

	if(!twengine){
		twengine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self];
		twengine.consumerKey = @"0vf8Ef5LRmhsmJRFmrclVw";
		twengine.consumerSecret = @"yKjpPjhOAjj3vQD6PuUH5WklRm4muupqfLRKylw";
	}

	facebook = [[Facebook alloc] initWithAppId:@"156565221086397"];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
	}
}


- (IBAction) shareMail:(id) sender
{
	MFMailComposeViewController * mailComposer = [[MFMailComposeViewController alloc] init];
	mailComposer.mailComposeDelegate = self;
	
	[mailComposer setMessageBody:[self messageString] isHTML:NO];
	
	[navcont presentModalViewController:mailComposer animated:YES];
	[mailComposer release];
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *) error {
	[navcont dismissModalViewControllerAnimated:NO];
}


- (IBAction) shareTW:(id) sender
{
	UIViewController *loginView = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine: twengine delegate: self];
	
	if (loginView) {
		[cvc presentModalViewController:loginView animated:YES];
	}else {
		[twengine sendUpdate:[self messageString]];
	}
	
}


- (NSString *) messageString
{
	id  topTable = [navcont topViewController];
	NSString * returnString = [[[NSString alloc] init] autorelease];
	if ([NSStringFromClass([topTable class]) isEqualToString:@"CatalogViewController"]) {
		CatalogViewController* table = (CatalogViewController*)[navcont topViewController];
		
		returnString = table.infoURL;
	}else if ([NSStringFromClass([topTable class]) isEqualToString:@"NestedTableView"]) {
		
		NestedTableView* table = (NestedTableView*)[navcont topViewController];
		returnString = table.infoURL;
	} 

	return [NSString stringWithFormat:@"resource %@", returnString];
}


- (IBAction) shareFB:(id) sender
{
	if (![facebook isSessionValid]) {
		//NSArray* permissions =  [[NSArray arrayWithObjects: @"publish_stream", nil] retain];
		
		//[facebook authorize:permissions delegate:self];
	}

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:[self messageString], @"message",nil];
    
    [facebook dialog:@"feed" andParams:params andDelegate:self];
	
}

- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username{}
- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller{}
- (void) OAuthTwitterControllerCanceled: (SA_OAuthTwitterController *) controller{}

- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {}
- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username { return @"";}
- (void) twitterOAuthConnectionFailedWithData: (NSData *) data {}


- (void)dealloc
{
	[cvc release];
	[_window release];
    [super dealloc];
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [facebook handleOpenURL:url]; 
}

- (void)fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
	
}

@end
