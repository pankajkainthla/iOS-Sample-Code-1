//
//  GetEntry.h
//  rss reader
//
//  Created by Sergio Botero on 11/3/10.
//  Copyright 2010 Sergiobuj. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GetEntry : NSOperation {
	NSString * entryTitle;
	NSURL * entryURL;
}

- (id) initWithFeedsFrom:(int) index number:(int) numberOfFeeds;

@end
