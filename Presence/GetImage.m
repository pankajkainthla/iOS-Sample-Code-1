//
//  GetImage.m
//  Presence
//
//  Created by Sergio on 6/29/09.
//  Copyright 2009 sergiobuj@gmail.com. All rights reserved.
//

#import "GetImage.h"
NSString *const ImageResultKey = @"image";
NSString *const URLResultKey = @"url";

@implementation GetImage

//init method
- (id) initWithTheURL:(NSURL *)imageURL target:(id)target action:(SEL)action{
	self = [super init];
	if(self){
		imageUrl  = imageURL;
		actionToCall = action;
		threadToReturnTo = target;
	}
	return self;
}

//the main for the NSOperation to work
- (void) main{
	
	// Synchronously oad the data from the specified URL.
    NSData *data = [[NSData alloc] initWithContentsOfURL:imageUrl];
    UIImage *image = [[UIImage alloc] initWithData:data];
	
	NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:image, ImageResultKey, imageUrl, URLResultKey, nil];
	[threadToReturnTo performSelectorOnMainThread:actionToCall withObject:result waitUntilDone:NO];
	
    [data release];
    [image release];
}


-(void)dealloc{
//	NSLog(@"get image dealloc");
	[imageUrl release];
	[super dealloc];
}

@end