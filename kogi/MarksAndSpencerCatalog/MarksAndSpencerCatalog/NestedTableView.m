//
//  NestedTableView.m
//  MarksAndSpencerCatalog
//
//  Created by Sergio Botero on 8/2/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import "NestedTableView.h"


@implementation NestedTableView

@synthesize contents, infoURL;


- (id) initWithUrlContent:(NSString *) url {
	self = [super initWithStyle:UITableViewStylePlain];
	if(self){
		self.infoURL = url;
		contents = [[NSMutableArray alloc] init ];
		self.tableView.frame = CGRectMake(0, 0, 320, 416);
		[self populateData];
		self.title = url;
	}
	return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [contents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	cell.textLabel.text = [[contents objectAtIndex:indexPath.row] objectForKey:@"name"];
	
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

	NestedTableView * tableView2 = [[NestedTableView alloc] initWithUrlContent:[[contents objectAtIndex:indexPath.row] objectForKey:@"id"]];
	
	[self.navigationController pushViewController:tableView2 animated:YES];
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (void) populateData {
	
	NSString * reqUrl = [[NSString alloc] initWithFormat:@"%@%@", @"http://www.marksandspencer.com/api/browse/", infoURL];
	
	[SBInfoFetcher fetchAndParse:reqUrl withDelegate:self andTarget:@selector(setDataArray:)];
}



- (void) setDataArray:(id) data {	
	[contents setArray:(NSArray *)data];
	[self.tableView reloadData];
}

@end
