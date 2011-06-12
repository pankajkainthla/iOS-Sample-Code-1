//
//  Status.m
//  Presence
//
//  Created by Sergio on 6/20/09.
//  Copyright 2009 sergiobuj@gmail.com. All rights reserved.
//

#import "Status.h"


@implementation Status
@synthesize person;

- (id)initWithStyle:(UITableViewStyle)style {
	if (self = [super initWithStyle:style]);
	return self;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self startLoadingAnimation];
	//begin the fetching statuses thread
	[NSThread detachNewThreadSelector:@selector(heavyWork:) toTarget:self withObject:nil ];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [statusArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *tweet = [[NSString alloc] initWithString:[statusArray objectAtIndex:indexPath.row]];
	NSString *timeStamp = [[NSString alloc] initWithString:[[timeStampsArray objectAtIndex:indexPath.row] substringToIndex:20]];
	NSString *embeddedURL = [[NSString alloc] initWithString:[urlDictionary objectForKey:tweet]];
	
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	
    // Set up the cell...
	[cell.textLabel setText:tweet];
	[cell.textLabel setNumberOfLines:0];	// 0 means that it can take any number of lines to put the string.
	[cell.textLabel setFont:[UIFont systemFontOfSize:15]];
	//label for the time stamp
	UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(cell.bounds.origin.x+10, cell.bounds.origin.y+10, cell.frame.size.width-25, 15)];	
	
	if( embeddedURL == @"NULL"){
		cell.userInteractionEnabled = NO;
		header.text = timeStamp;
	}else{
		cell.userInteractionEnabled = YES;
//		[urlDictionary setObject:embeddedURL forKey:tweet];
		header.text = [@"[WEB LINK]                                       " stringByAppendingString:timeStamp];
	}
	[header setFont:[UIFont systemFontOfSize:10]];
	header.textAlignment = UITextAlignmentRight;
	header.textColor = [UIColor darkGrayColor];
	[cell addSubview:header];	

	[header release];
	[embeddedURL release];
	[timeStamp release];
	[tweet release];
	return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	UIFont *font = [UIFont systemFontOfSize:15];
	// where i have to put the text
	CGSize sz = CGSizeMake(tableView.bounds.size.width , 1000);
	// using the the values from above, take the space filled with the text
	CGSize sz1 = [[statusArray objectAtIndex:indexPath.row] sizeWithFont:font constrainedToSize:sz lineBreakMode:UILineBreakModeWordWrap ];
	// return the height of that space.
	return sz1.height+60;
	return 60;
} 

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return @"Statuses";
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // Navigation logic may go here. Create and push another view controller.
	NSString *tweet = [statusArray objectAtIndex:indexPath.row];
//	NSString *tweet = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
	[[UIApplication sharedApplication] openURL: [NSURL URLWithString:[urlDictionary objectForKey:tweet] ] ];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
}

- (void)dealloc {
//	NSLog(@"status dealloc");
	[person release];
	[statusArray release];	[urlDictionary release];	[timeStampsArray release];
    [super dealloc];
}


#pragma mark -
#pragma mark My implementations
// takes a person and gets the statuses list and creates the aux arrays*/
-(id)initWithPerson:(Person *)initPerson{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		self.title = initPerson.realName;
		self.person = initPerson;
	}
	return self;	
}

//look for URL in status, gets the first one!!!! shame
-(NSString *)parseURL:(NSString *)text{
	int loc=[text rangeOfString:@"http://"].location, len=loc;
	if(loc > [text length]) return @"NULL";
	for(; len<[text length] ;++len){
		if( [text characterAtIndex:len] == ' ') break;
	}
	return [text substringWithRange:NSMakeRange(loc, len-loc)] ;
}

- (void)heavyWork:(id)object{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	UIImage *displayPic = [UIImage imageWithData:[NSData dataWithContentsOfURL:person.displayPicture]];	 
	UIImageView *imageView = [[UIImageView alloc] initWithImage:displayPic];
	imageView.frame = CGRectMake(0, 0, 40, 40);
	//self.navigationItem.titleView = imageView;// works but image is way too big
	UIBarButtonItem *ImageButt = [[UIBarButtonItem alloc] initWithCustomView:imageView];
	self.navigationItem.rightBarButtonItem = ImageButt;
	
	[self performSelectorOnMainThread:@selector(increaseIt:) withObject:nil waitUntilDone:NO];

	NSArray *temp = [TwitterHelper fetchTimelineForUsername:self.person.username];
	statusArray = [[NSMutableArray alloc] init];//all the statuses strings
	timeStampsArray = [[NSMutableArray alloc] init];//the time stamp for each status
	urlDictionary = [[NSMutableDictionary alloc] init];//dictionary to match the urls with status
	for(NSValue *value in temp){
		NSString *tweet=[NSString stringWithString:[value valueForKey:@"text"]];
		[statusArray addObject:tweet];
		[urlDictionary setObject:[self parseURL:tweet] forKey:tweet];
		[timeStampsArray addObject:[value valueForKey:@"created_at"]];
		[self performSelectorOnMainThread:@selector(increaseIt:) withObject:nil waitUntilDone:NO];
	}
	[self performSelectorOnMainThread:@selector(finishLoading:) withObject:nil waitUntilDone:NO];
	[ImageButt release];	[imageView release];	[pool release];
}

//start the loading animation
-(void)startLoadingAnimation{
	if(!progressBar){
		progressBar = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
		CGRect progressBarFrame = progressBar.frame;
		progressBarFrame.origin.x = (self.tableView.bounds.size.width - progressBar.frame.size.width) / 2.0;
		progressBarFrame.origin.y = 10 + (self.tableView.bounds.size.height - progressBar.frame.size.height) / 2.0;
		progressBar.frame = progressBarFrame;
		[self.tableView addSubview:progressBar];
	}
}

//stop the loading animation
-(void)stopLoadingAnimation{
	if(progressBar){
		[progressBar removeFromSuperview];
		[progressBar release];
		progressBar = nil;
	}
}

- (void) increaseIt:(id)object{
	[progressBar setProgress:progressBar.progress+0.05];
}

//after finishing the loading of the list of people, draw it
- (void) finishLoading:(id)object{
	[self stopLoadingAnimation];
	[self.tableView reloadData];
}
@end

