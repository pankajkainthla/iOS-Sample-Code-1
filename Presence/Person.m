//
//  Person.m
//  Presence
//
//  Created by Sergio on 6/19/09.
//  Copyright 2009 sergiobuj@gmail.com. All rights reserved.
//

#import "Person.h"


@implementation Person

@synthesize realName;
@synthesize displayPicture;
@synthesize username;

-(id)init{
	if(self == [super init]){
		[self setRealName:nil];
		[self setDisplayPicture:nil];
		[self setUsername:nil];

	}
	return self;
}

-(id)newPerson:(NSString *)theUsername imageURL:(NSURL *)imageUrl theRealName:(NSString *)name{
	if(self == [super init]){
		[self setRealName:name];
		[self setDisplayPicture:imageUrl];
		[self setUsername:theUsername];

	}
	return self;
}

-(void)dealloc{
//	NSLog(@"person dealloc");
	[realName release];
	[displayPicture release];
	[username release];
	[super dealloc];
}


@end
