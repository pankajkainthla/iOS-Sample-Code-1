//
//  SearchTableView.m
//  Presence
//
//  Created by Sergio on 7/6/09.
//  Copyright 2009 sergiobuj@gmail.com. All rights reserved.
//

#import "SearchTableView.h"

@interface SearchTableView (private)
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar;
- (void) showLoading;
- (void) removeLabel;
- (void) keyboardDown:(id)object;
- (void) keyboardUp:(NSNotification *)notification;
- (void)search:(NSString *)query;
@end

@implementation SearchTableView


- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
		resultsArray = [[NSMutableArray alloc] init];
		resultsDetails = [[NSMutableArray alloc] init];
		self.title = @"Search";

	}
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	searchBar = [[UISearchBar alloc] initWithFrame:self.tableView.bounds];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	searchBar.delegate = self;
	[searchBar sizeToFit];
	self.tableView.tableHeaderView = searchBar;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardUp:)   name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDown:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger )section {
    return [resultsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	UIFont *font = [UIFont systemFontOfSize:15];
	// where i have to put the text
	CGSize sz = CGSizeMake(tableView.bounds.size.width , 1000);
	// using the the values from above, take the space filled with the text
	CGSize sz1 = [[resultsArray objectAtIndex:indexPath.row] sizeWithFont:font constrainedToSize:sz lineBreakMode:UILineBreakModeWordWrap ];
	// return the height of that space.
	return sz1.height+60;
	return 60;
} 

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	[cell.textLabel setText:[resultsArray objectAtIndex:indexPath.row]];
	[cell.textLabel setNumberOfLines:0];	// 0 means that it can take any number of lines to put the string.
	[cell.textLabel setFont:[UIFont systemFontOfSize:15]];
	//label for the time stamp
	UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(cell.bounds.origin.x+10, cell.bounds.origin.y+10, cell.frame.size.width-25, 15)];
//	cell.textLabel.text = [resultsArray objectAtIndex:indexPath.row];
    // Set up the cell...
	header.text = [resultsDetails objectAtIndex:indexPath.row] ;
	[header setFont:[UIFont systemFontOfSize:10]];
	header.textAlignment = UITextAlignmentRight;
	header.textColor = [UIColor darkGrayColor];
	[cell addSubview:header];
	
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
	NSString *user = [resultsDetails objectAtIndex:indexPath.row];
	[[UIApplication sharedApplication] openURL: [NSURL URLWithString:[NSString stringWithFormat:@"http://twitter.com/%@",user]]];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[searchBar release];
    [super dealloc];
}

#pragma mark -
#pragma mark MyImplementations

- (void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar{
//- (void)searchBarTextDidEndEditing:(UISearchBar *)theSearchBar{
	[self showLoading];
	[NSThread detachNewThreadSelector:@selector(search:) toTarget:self withObject:theSearchBar.text];
	//	[self search:theSearchBar.text];
	[searchBar endEditing:YES];
}

- (void)search:(NSString *)query{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSArray *receivedResults = [[TwitterHelper fetchSearchResultsForQuery:query] objectForKey:@"results"];
	for(NSDictionary *r in receivedResults){
		[resultsArray addObject:[r objectForKey:@"text"]];
		[resultsDetails addObject:[r objectForKey:@"from_user"]];
//		NSLog(@"%@  ----from---- %@",[r objectForKey:@"text"],[r objectForKey:@"from_user"]);
	}


	[self removeLabel];
	[pool release];
}

- (void) keyboardUp:(NSNotification *)notification {
	CGRect bounds = [[[notification userInfo] objectForKey:UIKeyboardBoundsUserInfoKey] CGRectValue];
    CGPoint center = [[[notification userInfo] objectForKey:UIKeyboardCenterEndUserInfoKey] CGPointValue];
    
    // We need to compute the keyboard and table view frames in window-relative coordinates
    CGRect keyboardFrame = CGRectMake(round(center.x - bounds.size.width/2.0), round(center.y - bounds.size.height/2.0), bounds.size.width, bounds.size.height);
    CGRect tableViewFrame = [self.tableView.window convertRect:self.tableView.frame fromView:self.tableView.superview];
    
    // And then figure out where they overlap
    CGRect intersectionFrame = CGRectIntersection(tableViewFrame, keyboardFrame);
    
    // This assumes that no one else cares about the table view's insets...
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, intersectionFrame.size.height, 0);
    [self.tableView setContentInset:insets];
    [self.tableView setScrollIndicatorInsets:insets];
}



- (void) keyboardDown:(id)object{
	[self.tableView setContentInset:UIEdgeInsetsZero];
	[self.tableView setScrollIndicatorInsets:UIEdgeInsetsZero];
}

-(void) showLoading{
	label = [[UILabel alloc]initWithFrame:CGRectZero];
	label.font = [UIFont systemFontOfSize:25];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor grayColor];
	label.text = @"Searching...";
	[label sizeToFit];
	CGRect myFrame = label.frame;
	myFrame.origin.x = (self.tableView.bounds.size.width - myFrame.size.width) / 2.0;
	myFrame.origin.y = (self.tableView.bounds.size.height - myFrame.size.height)-50 / 2.0;
	label.frame = myFrame;
	[self.tableView addSubview:label];
}

- (void) removeLabel{
	[label removeFromSuperview];
	[label release];
	[self.tableView reloadData];
}


@end