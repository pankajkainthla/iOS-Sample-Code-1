//
//  WhatsNextGen.m
//  WhatsNext
//
//  Created by Sergio on 3/30/10.
//  Copyright 2010 sergiobuj. All rights reserved.
//

#import "WhatsNextGen.h"


@implementation WhatsNextGen



+(NSString *)
nextString:(int) category
{
	NSString * newString = [NSString stringWithFormat:@"%d \n esta\n nueva línea" ,category];

	return newString;

}
@end
