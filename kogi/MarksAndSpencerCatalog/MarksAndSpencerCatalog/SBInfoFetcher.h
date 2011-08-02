//
//  SBInfoFetcher.h
//  MarksAndSpencerCatalog
//
//  Created by Sergio Botero on 8/2/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBInfoFetcher : NSObject

+ (void) fetchAndParse:(NSString *) url withDelegate:(id) delegate andTarget:(SEL) method;

@end
