//
//  SearchTableView.h
//  Presence
//
//  Created by Sergio on 7/6/09.
//  Copyright 2009 sergiobuj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterHelper.h"

@interface SearchTableView : UITableViewController <UISearchBarDelegate> {
    UISearchBar *searchBar;
	NSMutableArray *resultsArray;
	NSMutableArray *resultsDetails;
	UILabel * label;
}

@end
