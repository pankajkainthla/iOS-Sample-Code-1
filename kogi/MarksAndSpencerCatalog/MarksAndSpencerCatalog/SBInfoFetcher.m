//
//  SBInfoFetcher.m
//  MarksAndSpencerCatalog
//
//  Created by Sergio Botero on 8/2/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import "SBInfoFetcher.h"
#import "CJSONDeserializer.h"


@implementation SBInfoFetcher


+ (void) fetchAndParse:(NSString *) url withDelegate:(id) delegate andTarget:(SEL) method
{
	NSOperationQueue * queue = [[NSOperationQueue alloc] init];

	[queue addOperationWithBlock:^{

		
		NSError * error = nil;
		
		NSMutableURLRequest * request =[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
		
		[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
		
		NSData * jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
		
		NSDictionary * dataDeserialized = [[NSDictionary alloc] initWithDictionary:[[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error]];
		
		[delegate performSelectorOnMainThread:method withObject:[dataDeserialized objectForKey:@"childNode"] waitUntilDone:NO];
		[dataDeserialized release];
		
	}];
	
	[queue autorelease];
}

@end
