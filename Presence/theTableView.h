//
//  theTableView.h
//  Presence
//
//  Created by Sergio on 6/19/09.
//  Copyright 2009 sergiobuj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterHelper.h"
#import "Person.h"
#import "Status.h"
#import "GetImage.h"
#import "StatusComposeViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface theTableView : UITableViewController <StatusComposeViewControllerDelegate , UINavigationControllerDelegate> {
	NSMutableArray *peopleArray; //the array of friends main array for the app
	NSMutableDictionary *images; //the array of friends avatars or images
	NSMutableArray *fromPlist; //the list of people read from the TwitterList.plist
	NSOperationQueue *theOperationQ; // the Q for the concurrency
	NSOperationQueue *imagesOperations; //the Q to manage image fetching
	UIActivityIndicatorView *spinner; //spinner for the loading animation
	BOOL isTheMainTableView;
	NSMutableArray *addBookPeople;
}

//custom init method
-(id) initTheTableView:(BOOL)isMain style:(UITableViewStyle)style;
- (NSArray *) readPlist; //read the preferences list with the default friends list
- (void) startLoadingAnimation; //start the spinner animation
- (void) stopLoadingAnimation; //stop the spinner animation
- (void) getTheList; //gets the list of friends
- (void) finishLoading:(id)object; //stops the spinner animation and reloads the table view data
- (void) theOperation; // creates one NSOperation and puts it on the Q
- (UIImage *) setImage:(NSURL *)theUrl; //fetches the friend's image
- (void) getImage:(NSDictionary *)info; //keeps the images
- (void) showUpdater; //display modally a controller to update sergiobuj's tweeter account
-(void) sendNewStatus:(NSString *)text;
@end
