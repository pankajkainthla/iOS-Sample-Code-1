//
//  CatalogViewController.m
//  MarksAndSpencerCatalog
//
//  Created by Sergio Botero on 8/2/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import "CatalogViewController.h"

#import "SBInfoFetcher.h"



@implementation CatalogViewController

@synthesize tableView, infoURL;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.infoURL = @"http://www.marksandspencer.com/api/browse/42966030";
		catalog = [[NSMutableArray alloc] init];
		self.title = self.infoURL;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) dealloc
{
	[catalog release];
	[super dealloc];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	[SBInfoFetcher fetchAndParse:self.infoURL withDelegate:self andTarget:@selector(setDataArray:)];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [catalog count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	cell.textLabel.text = [[catalog objectAtIndex:indexPath.row] objectForKey:@"name"];
	
    return cell;
	
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NestedTableView * tableView2 = [[NestedTableView alloc] initWithUrlContent:[[catalog objectAtIndex:indexPath.row] objectForKey:@"id"]];

	[self.navigationController pushViewController:tableView2 animated:YES];
	
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void) setDataArray:(id) data {
	
	[catalog setArray:(NSArray *)data];
	[self.tableView reloadData];
}


@end
