//
//  SBSaveInfo.m
//  Simple Form
//
//  Created by Sergio Botero on 4/5/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import "SBSaveInfo.h"

@implementation SBSaveInfo

+ (void)setObject:(id)value forKey:(NSString *)key
{
	NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
	[userDef setObject:value forKey:key];
	[userDef synchronize];
}

+ (id)objectForKey:(NSString *)key
{
	NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
	return [userDef objectForKey:key];
}

@end