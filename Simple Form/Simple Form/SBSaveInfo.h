//
//  SBSaveInfo.h
//  Simple Form
//
//  Created by Sergio Botero on 4/5/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBSaveInfo : NSObject {
    
}
+ (void)setObject:(id)value forKey:(NSString *)key;
+ (id) objectForKey:(NSString *) key;
@end
