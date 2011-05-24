//
//  CommonChooser.m
//  ClothesCatalog
//
//  Created by Sergio Botero on 12/3/10.
//  Copyright 2010 Sergiobuj. All rights reserved.
//

#import "CommonChooser.h"


@implementation CommonChooser


#pragma mark -
#pragma mark Initialization


- (id)initWithStyle:(UITableViewStyle)style andReource:(NSString*) xmlResource andTitle:(NSString *)tableTitle{
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
	
	
    self = [super initWithStyle:style];
    if (self) {
		[self setTitle:tableTitle];
		resource = [[NSString alloc] initWithString:xmlResource];

		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		categoryFilename = [[NSString alloc] initWithString:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.dat", self.title]]];
		items = [[NSMutableArray alloc] initWithContentsOfFile:categoryFilename];	
		
	}
    return self;
}

- (void) loadData {
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	NSError * error = nil;
	NSString * resourceAsString = [NSString stringWithContentsOfURL:[NSURL URLWithString:resource] encoding:NSUTF8StringEncoding error:&error];

	if (error) {
		NSLog(@"%@", error);
	}else {
		NSData * jsonData = [resourceAsString dataUsingEncoding:NSUTF32BigEndianStringEncoding];
		
		NSArray * array = [[CJSONDeserializer deserializer] deserializeAsArray:jsonData error:&error];
		
		if (error) {
			NSLog(@"%@", error);
		}else{
			
			NSMutableArray * categ = [[NSMutableArray alloc] init];
			for(NSDictionary * dict in array){
				[categ addObject:[dict objectForKey:@"category"] ];
				
			}

			[self performSelectorOnMainThread:@selector(responseArray:) withObject:[categ autorelease] waitUntilDone:NO];
		}
	}
	
	[pool drain];
}

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	if(items == nil){
//		xmlParser = [[SBXMLParser alloc] init];
//		[xmlParser setDelegate:self];
		spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		UIBarButtonItem *rightSpinnerView = [[UIBarButtonItem alloc] initWithCustomView:spinner];
		[spinner startAnimating];
		[self.navigationItem setRightBarButtonItem:rightSpinnerView];
		[rightSpinnerView release];
		items = [[NSMutableArray alloc] init];
		[NSThread detachNewThreadSelector:@selector(loadData) toTarget:self withObject:nil];
//		[self loadData];		
	}
	[self.tableView reloadData];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


#pragma mark -
#pragma mark Table view data source

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"";
}

- (NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	return @"Powered by Zinergia";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [items count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    

	NSString * text = [[items objectAtIndex:[indexPath row]] objectForKey:@"name_with_products"];
	
	[cell.textLabel setText:[text stringByTrimmingCharactersInSet:[[NSCharacterSet letterCharacterSet] invertedSet]]];
	[cell.detailTextLabel setText:[text stringByTrimmingCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]]];

    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	GridViewController * grid = [[GridViewController alloc] initWithCategory:[[[items objectAtIndex:indexPath.row] objectForKey:@"id"]intValue] andSection:self.title];
	[grid setTitle:[[items objectAtIndex:indexPath.row] objectForKey:@"name"]];
	
	[self.navigationController pushViewController:grid animated:YES];
	[grid release];
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	
}

- (void)viewDidUnload {
}


- (void)dealloc {
	[resource release];
	[items release];
	[spinner release];
    [super dealloc];
}

- (void) responseArray:(NSMutableArray *)array{
	[items setArray:array];
	[self.tableView reloadData];
	[spinner stopAnimating];
	[items writeToFile:categoryFilename atomically:YES];
	
	NSMutableSet *filepathsSet = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedFilepaths"];
	[filepathsSet setByAddingObject:categoryFilename];
	[[NSUserDefaults standardUserDefaults] setObject:filepathsSet forKey:@"savedFilepaths"];
	
	[categoryFilename release];
}
@end

