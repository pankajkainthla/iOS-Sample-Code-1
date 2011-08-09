//
//  PruebaViewController.h
//  Prueba
//
//  Created by Carlos Arenas on 7/29/11.
//  Copyright 2011 Kogi Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VIDEO_FIELDS ([NSArray arrayWithObjects:@"id", @"name", @"shortDescription", @"longDescription", @"creationDate", @"publisheddate", @"lastModifiedDate", @"linkURL", @"linkText", @"tags", @"videoStillURL", @"thumbnailURL", @"referenceId", @"length", @"economics", @"playsTotal", @"playsTrailingWeek", @"startDate", @"FLVURL", nil])


@interface PruebaViewController : UIViewController
- (IBAction)upVideo:(id)sender;
@end
