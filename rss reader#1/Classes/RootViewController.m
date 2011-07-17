//
//  RootViewController.m
//  rss reader
//
//  Created by Sergio Botero on 7/26/10.
//  Copyright (c) 2010 Sergiobuj. All rights reserved.
//


#import "RootViewController.h"

@implementation RootViewController

- (void) refresh{
	if ([stories count] != 0){
		
		[stories removeAllObjects];
		[newsTable reloadData];

	}
	self.refreshLabel.text = @"Cargando...";
	[self performSelector:@selector(process) withObject:nil afterDelay:2.0];
}

- (void)viewDidLoad {

	self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
	//self.tableView.separatorColor = [UIColor clearColor];
	self.tableView.backgroundColor = [UIColor clearColor];
	
	//[self setTitle:@"Zinergia RSS Reader"];
    [super viewDidLoad];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
 */

- (void) process {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	if ([stories count] == 0) {
		//NSString *path1 = @"http://feeds2.feedburner.com/TheMdnShow";
		NSString *path = @"http://feeds.feedburner.com/TheAppleBlog";
		path = @"http://docentes.eafit.edu.co/noticias.rss";
		[self parseXMLFileAtURL:path];
	}	
	cellSize = CGSizeMake([newsTable bounds].size.width, 60);
	[spin stopAnimating];
    [self stopLoading];
	[pool drain];
}

- (void)viewDidAppear:(BOOL)animated {
	
	[super viewDidAppear:animated];
	spin = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	CGRect spinFrame = spin.frame;
	spinFrame.origin.x = (self.tableView.bounds.size.width - spinFrame.size.width)/2.0;
	spinFrame.origin.y = (self.tableView.bounds.size.height)/2.0;
	spin.frame = spinFrame;
	[spin startAnimating];
	[self.tableView addSubview:spin];

	[NSThread detachNewThreadSelector:@selector(process) toTarget:self withObject:nil];

}

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [stories count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }

    // Configure the cell.
	cell.imageView.image = [UIImage imageNamed:@"icon.png"];
	[cell.detailTextLabel setText: @"Proyecto 50 EAFIT"];
	
	int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	[cell.textLabel setText:[[stories objectAtIndex:storyIndex] objectForKey:@"title"]];
	
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here -- for example, create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     NSManagedObject *selectedObject = [[self fetchedResultsController] objectAtIndexPath:indexPath];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
	
	
	
	// Navigation logic 
	int storyIndex = [indexPath indexAtPosition:[indexPath length] - 1];
	NSString * storyLink = [[stories objectAtIndex: storyIndex] objectForKey: @"link"];
	// clean up the link - get rid of spaces, returns, and tabs... 
	storyLink = [storyLink stringByReplacingOccurrencesOfString:@" " withString:@""];
	storyLink = [storyLink stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	storyLink = [storyLink stringByReplacingOccurrencesOfString:@"	" withString:@""];
	NSLog(@"link: %@", storyLink);
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:storyLink]]; 

	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc {
	[currentElement release];
	[rssParser release];
	[stories release];
	[item release];
	[currentTitle release];
	[currentDate release];
	[currentSummary release];
	[currentLink release]; 
    [super dealloc];
}


- (void)parseXMLFileAtURL:(NSString *)URL {
	stories = [[NSMutableArray alloc] init];
	//you must then convert the path to a proper NSURL or it won't work 
	NSURL *xmlURL = [NSURL URLWithString:URL]; 
	// here, for some reason you have to use NSClassFromString when trying to alloc NSXMLParser, otherwise you will get an object not found error
	// this may be necessary only for the toolchain
	rssParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL]; // Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
	[rssParser setDelegate:self]; // Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
	[rssParser setShouldProcessNamespaces:NO];
	[rssParser setShouldReportNamespacePrefixes:NO];
	[rssParser setShouldResolveExternalEntities:NO];
	[rssParser parse];
}



- (void)parserDidStartDocument:(NSXMLParser *)parser {
	NSLog(@"found file and started parsing");
}
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"Unable to download story feed from web site (Error code %i )", [parseError code]];
	NSLog(@"error parsing XML: %@", errorString);
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
	[errorAlert release];
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	//
	NSLog(@"found this element: %@", elementName);
	currentElement = [elementName copy];
	if ([elementName isEqualToString:@"item"]) {
		// clear out our story item caches... 
		item = [[NSMutableDictionary alloc] init];
		currentTitle = [[NSMutableString alloc] init];
		currentDate = [[NSMutableString alloc] init];
		currentSummary = [[NSMutableString alloc] init];
		currentLink = [[NSMutableString alloc] init];
	}
} 
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{ //
	NSLog(@"ended element: %@", elementName);
	if ([elementName isEqualToString:@"item"]) { // save values to an item, then store that item into the array... 
		[item setObject:currentTitle forKey:@"title"];
		[item setObject:currentLink forKey:@"link"];
		[item setObject:currentSummary forKey:@"summary"];
		[item setObject:currentDate forKey:@"date"];
		[stories addObject:[item copy]];
		NSLog(@"adding story: %@", currentTitle);
	}
} 
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{ //
	NSLog(@"found characters: %@", string);
	// save the characters for the current item... 
	if ([currentElement isEqualToString:@"title"]) {
		[currentTitle appendString:string];
	} else if ([currentElement isEqualToString:@"link"]) {
		[currentLink appendString:string];
	} else if ([currentElement isEqualToString:@"description"]) {
		[currentSummary appendString:string];
	} else if ([currentElement isEqualToString:@"pubDate"]) {
		[currentDate appendString:string];
	}
} 
- (void)parserDidEndDocument:(NSXMLParser *)parser {
	[activityIndicator stopAnimating];
	[activityIndicator removeFromSuperview];
	NSLog(@"all done!");
	NSLog(@"stories array has %d items", [stories count]);
	[newsTable reloadData];
}





@end

