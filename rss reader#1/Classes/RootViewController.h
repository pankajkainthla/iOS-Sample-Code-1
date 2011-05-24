//
//  RootViewController.h
//  rss reader
//
//  Created by Sergio Botero on 7/26/10.
//  Copyright (c) 2010 Sergiobuj. All rights reserved.
//

#import "PullRefreshTableViewController.h"


@interface RootViewController : PullRefreshTableViewController <NSXMLParserDelegate>{
    IBOutlet UITableView *newsTable;
    UIActivityIndicatorView * activityIndicator;
    CGSize cellSize;
    NSXMLParser *rssParser;
	NSMutableArray *stories;
	NSMutableDictionary *item;
	NSString *currentElement;
	NSMutableString *currentTitle, *currentDate, * currentSummary, *currentLink;
	UIActivityIndicatorView *spin;
}

- (void)parseXMLFileAtURL:(NSString *)URL;
- (void)process;
@end
