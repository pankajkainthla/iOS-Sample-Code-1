//
//  Status.h
//  Presence
//
//  Created by Sergio on 6/20/09.
//  Copyright 2009 sergiobuj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "TwitterHelper.h"

@interface Status : UITableViewController {
	NSMutableArray *statusArray; //the whole statuses array
	NSMutableArray *timeStampsArray; //the time stamp for every status
	NSMutableDictionary *urlDictionary; //dictionary with urls for status key
	UIProgressView *progressBar; // progress bar to indicate loading process
	Person *person; //the statuses owner
}

- (id) initWithPerson:(Person *)initPerson;// initializer
- (NSString*) parseURL:(NSString *)text; //method to find the first web reference on the satus
- (void) startLoadingAnimation; //begin the progressBar animation
- (void) stopLoadingAnimation; //stop the loading bar animation
- (void) finishLoading:(id)object; //stop the animation and load the table view
- (void) heavyWork:(id)object; // the dirty job fetch the statuses from the JSON file
- (void) increaseIt:(id)object; // increase the progress bar

@property (retain)Person *person; //property, retain because is an nsobject
@end
