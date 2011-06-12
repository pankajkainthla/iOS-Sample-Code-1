//
//  Person.h
//  Presence
//
//  Created by Sergio on 6/19/09.
//  Copyright 2009 sergiobuj@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Person : NSObject {
	NSString *username;
	NSString *realName;
	NSURL *displayPicture;
}


@property (retain,nonatomic) NSString *username;
@property (retain,nonatomic) NSURL *displayPicture;
@property (retain,nonatomic) NSString *realName;

-(id)init;
-(id)newPerson:(NSString *)theUsername imageURL:(NSURL *)imageUrl theRealName:(NSString *)name;

@end
