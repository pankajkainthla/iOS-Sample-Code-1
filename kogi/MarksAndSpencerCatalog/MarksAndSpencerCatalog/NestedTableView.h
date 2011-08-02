//
//  NestedTableView.h
//  MarksAndSpencerCatalog
//
//  Created by Sergio Botero on 8/2/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBInfoFetcher.h"


@interface NestedTableView : UITableViewController
@property (nonatomic, copy) NSString * infoURL;
@property (nonatomic, retain) NSMutableArray * contents;

- (id) initWithUrlContent:(NSString *) url;
- (void) populateData;
- (void) setDataArray:(id) data;

@end
