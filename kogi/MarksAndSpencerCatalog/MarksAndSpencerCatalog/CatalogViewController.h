//
//  CatalogViewController.h
//  MarksAndSpencerCatalog
//
//  Created by Sergio Botero on 8/2/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NestedTableView.h"


@interface CatalogViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{	
	NSMutableArray * catalog;
}

- (void) setDataArray:(id) data;

@property (nonatomic, retain) IBOutlet UITableView * tableView;
@property (nonatomic, copy) NSString * infoURL;
@end
