//
//  GetImage.h
//  Presence
//
//  Created by Sergio on 6/29/09.
//  Copyright 2009 sergiobuj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString *const ImageResultKey; // key for the returning dictionary
extern NSString *const URLResultKey;   // key for the returning dictionary

@interface GetImage : NSOperation {
	NSURL * imageUrl; //the image
	SEL actionToCall; //the action to call when going back
	id threadToReturnTo; // who is calling the operation
}

//custom init method
- (id) initWithTheURL:(NSURL *)imageURL target:(id)target action:(SEL)action;

@end
