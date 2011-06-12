//
//  theTableView.m
//  Presence
//
//  Created by Sergio on 6/19/09.
//  Copyright 2009 sergiobuj@gmail.com. All rights reserved.
//	
//NSBundle *thisBundle = [NSBundle bundleForClass:[self class]];
//NSString *path = [thisBundle pathForResource:@"TwitterUsers" ofType:@"plist"];
//NSString *errorDesc;
//NSMutableArray *a = [[NSMutableArray alloc] init];
//NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:a format:NSPropertyListXMLFormat_v1_0 errorDescription:&errorDesc];
//[plistData writeToFile:path atomically:NO];

#import "theTableView.h"

@implementation theTableView


- (id)initWithStyle:(UITableViewStyle)style {
	if ((self = [super initWithStyle:style])) {
		self.title = @"Following";
		
		images = [[NSMutableDictionary alloc] init];
		theOperationQ = [[NSOperationQueue alloc] init];
        [theOperationQ setMaxConcurrentOperationCount:1];
		
		imagesOperations = [[NSOperationQueue alloc] init];
		[imagesOperations setMaxConcurrentOperationCount:1];
		self.tableView.delegate = self;
	}
	return self;
}


- (void)dealloc {
	//	NSLog(@"table view dealloc");
	[addBookPeople release];
	[images release];
	[fromPlist release];
	[peopleArray release];
	[theOperationQ release];
	[imagesOperations release];
	[super dealloc];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	if(isTheMainTableView){
		UIBarButtonItem *updateStatus = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(showUpdater)];
		self.navigationItem.rightBarButtonItem = updateStatus;
		[updateStatus release];
	}
	[self theOperation];
	[self startLoadingAnimation];
}

/* I'm not allowing this anymore
 //saves the current twitter users list on plist
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 NSBundle *thisBundle = [NSBundle bundleForClass:[self class]];
 NSString *path = [thisBundle pathForResource:@"TwitterUsers" ofType:@"plist"];
 [fromPlist writeToFile:path atomically:YES];
 }*/


#pragma mark Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1; //just one set of friends
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [peopleArray count];	//number of rows equal to number of friends...we all get the same
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	Person *current = [peopleArray objectAtIndex:indexPath.row];	
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	
	// Set up the cell...
	cell.textLabel.adjustsFontSizeToFitWidth = YES;
	cell.indentationLevel = 1;
	cell.imageView.frame = CGRectMake(0, 0, 40, 40);
	cell.imageView.image = [self setImage:current.displayPicture];
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	if(current.realName == nil || current.realName == @"")
		cell.textLabel.text = current.username;
	else
		cell.textLabel.text = current.realName;
	
	
	return cell;
}

//method called everytime the cell is going to be created
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 60.0;
} 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	self.navigationItem.prompt = nil;
	
	
	ABRecordRef dummy = (ABRecordRef)[addBookPeople objectAtIndex:indexPath.row];
	CFTypeRef theName = ABRecordCopyValue(dummy,kABPersonLastNameProperty);
	NSString *name = (NSString *)theName;
	NSLog(@"%@",name);
	Status *st  = [[Status alloc] initWithPerson:[peopleArray objectAtIndex:indexPath.row]];
	st.view.frame = [UIScreen mainScreen].applicationFrame;
	[self.navigationController pushViewController:st animated:YES];
	[st release];
}

// Override to support editing the table view.
//when deleting not allowed now
/*
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 [fromPlist removeObjectAtIndex:indexPath.row];
 [peopleArray removeObjectAtIndex:indexPath.row];
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation: (indexPath.row%5)];//to get a diff animation every time
 }*/

//I'm not allowing this anymore... but is good to have it... somewhere
/*/ Override to support rearranging the table view... basically get the one i'm moving, delete and insert
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 NSString *mover = [fromPlist objectAtIndex:fromIndexPath.row];
 [fromPlist removeObjectAtIndex:fromIndexPath.row];
 [fromPlist insertObject:mover atIndex:toIndexPath.row];
 }*/

#pragma mark -
#pragma mark My implementations

//custom initialization
-(id) initTheTableView:(BOOL)isMain style:(UITableViewStyle)style{
	if ((self = [super initWithStyle:style])) {
		isTheMainTableView = isMain;
		self.title = isTheMainTableView? @"Following": @"Public";
		images = [[NSMutableDictionary alloc] init];
		theOperationQ = [[NSOperationQueue alloc] init];
        [theOperationQ setMaxConcurrentOperationCount:1];
		
		imagesOperations = [[NSOperationQueue alloc] init];
		[imagesOperations setMaxConcurrentOperationCount:1];
	}
	return self;
}


//enqueues operations
- (void)theOperation{
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(getTheList) object:nil];
    [theOperationQ addOperation:operation];
    [operation release];
}

/*
 *  to future Sergio: dear Sergio... this bug is driving me crazy right now.. 
 *  please in some near future come back and clean up this mess... 7/07/09
 */


//Get the list of people
- (void) getTheList{
	if(!peopleArray){
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
		peopleArray = [[NSMutableArray alloc]init];
		addBookPeople = [[NSMutableArray alloc]init];
		if(isTheMainTableView){
			fromPlist = [[NSMutableArray alloc] initWithArray:[self readPlist]];
		}else{
			NSArray *a = [TwitterHelper fetchPublicTimeline];		
			NSDictionary *un = [a valueForKey:@"user"];
			fromPlist = [[NSMutableArray alloc] init];
			for(id usn in un){
				[fromPlist addObject:[usn valueForKey:@"screen_name"]];
			}
		} 
		
		if(fromPlist == nil){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"MyApp" message:@"Couldn't load the file" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:@"chao", nil];
			[alert show];
			[alert release];
		}
		
		for(NSString *value in fromPlist){
			//			ABRecordRef person = NULL;
			ABRecordRef person = ABPersonCreate();
			//			person = ABPersonCreate();
			Person *ape = [[Person alloc] init];
			NSDictionary *info = [TwitterHelper fetchInfoForUsername:value];
			//			for(NSString *a in info){
			//				NSLog(@"%@ con %@", a, [info objectForKey:a]);
			//			}
			
			[ape setDisplayPicture:[NSURL URLWithString:[info valueForKey:@"profile_image_url"]]];
			[ape setUsername:[info valueForKey:@"screen_name"]];
			[ape setRealName:[info objectForKey:@"name"]];
			
			
			
			ABRecordSetValue(person, kABPersonFirstNameProperty, [info objectForKey:@"name"], NULL);
			//ABRecordSetValue(person, kABPersonLastNameProperty, [webPerson lastName], NULL);
			//			ABRecordSetValue(person, kABPerson);
			ABMutableMultiValueRef urls = ABMultiValueCreateMutable(kABMultiStringPropertyType);
			ABMultiValueAddValueAndLabel(urls,  [NSString stringWithFormat:@"http://twitter.com/%@",[info valueForKey:@"screen_name"]], CFSTR("Twitter"), NULL);
			ABRecordSetValue(person, kABPersonURLProperty,urls, NULL);
			//CFRelease(urls);
			//			[person setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[info valueForKey:@"profile_image_url"]]]]];
			//ABPersonSetImageData(ABRecordRef person, CFDataRef imageData, CFErrorRef* error);
			//		ABPersonSetImageData()
			ABPersonSetImageData(person , (CFDataRef)[NSData dataWithContentsOfURL:[NSURL URLWithString:[info valueForKey:@"profile_image_url"]]],nil);
			//			ABPersonSetImageData(person,);
			[addBookPeople addObject:(id)person];
			CFRelease(person);
			CFRelease(urls);
			[peopleArray addObject:ape];
			[ape release];
			ape=nil;
		}
		
		
		[self performSelectorOnMainThread:@selector(finishLoading:) withObject:nil waitUntilDone:NO];	
		[pool release];	
	}//fi
}//getTheList


// method to read the list of people that are being followed
- (NSArray *) readPlist{
	NSBundle *thisBundle = [NSBundle bundleForClass:[self class]];
	NSString *path = [thisBundle pathForResource:@"TwitterUsers" ofType:@"plist"];
	return [[[NSArray alloc]initWithContentsOfFile:path] autorelease];
	}


//start the loading animation
-(void)startLoadingAnimation{
	if(!spinner){
		spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		[spinner startAnimating];
		static CGFloat bufferWidth = 8.0;
		CGFloat totalWidth = spinner.frame.size.width + bufferWidth;
		CGRect spinnerFrame = spinner.frame;
		spinnerFrame.origin.x = (self.tableView.bounds.size.width - totalWidth) / 2.0;
		spinnerFrame.origin.y = (self.tableView.bounds.size.height - spinnerFrame.size.height) / 2.0;
		spinner.frame = spinnerFrame;
		[self.tableView addSubview:spinner];
	}
}

//stop the loading animation
-(void)stopLoadingAnimation{
	if(spinner){
		[spinner removeFromSuperview];
		[spinner stopAnimating];
		[spinner release];
		spinner = nil;
	}
}

- (UIImage *) setImage:(NSURL *)theUrl{
	id userImage = [images objectForKey:theUrl];
	if(userImage == nil){
		[images setObject:@"NO_IMAGE_FOR_URL" forKey:theUrl];     
		GetImage *op = [[GetImage alloc] initWithTheURL:theUrl target:self action:@selector(getImage:)];
		[imagesOperations addOperation:op];
		[op release];
	} else if (![userImage isKindOfClass:[UIImage class]]) {
		userImage = nil;
	}
	return userImage;
}

//method to fetch one image
// info comes from GetImage.m in the main method
//NSArray * theArray= [NSArray arrayWithObjects:imageUrl,theImage,nil];
- (void) getImage:(NSDictionary *)info{
	NSURL *url = [info objectForKey:@"url"];
	id image = [info objectForKey:@"image"];
	[images setObject:image forKey:url];
	
	[self.tableView reloadData];
}

//after finishing the loading of the list of people, draw it
- (void) finishLoading:(id)object{
	[self stopLoadingAnimation];
	[self.tableView reloadData];
}


//show status `updater'
- (void) showUpdater{
	StatusComposeViewController *stc  = [[StatusComposeViewController alloc] init];
	stc.delegate = self;
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:stc];
	[self.navigationController presentModalViewController:navController animated:YES];
	self.navigationItem.prompt = nil;
	[navController release];	
	[stc release];
}

- (void) typed:(StatusComposeViewController *)controller somethingTyped:(NSString *)text{
	if(text != nil){
		self.navigationItem.prompt = @"Sending status...";
		[NSThread detachNewThreadSelector:@selector(sendNewStatus:) toTarget:self withObject:text];
	}
	[self.navigationController dismissModalViewControllerAnimated:YES];
}

-(void) sendNewStatus:(NSString *)text{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
	
	NSString *username = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
	NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
	
	if(username != nil && password != nil){
		[TwitterHelper updateStatus:text forUsername:username withPassword:@"dont"];
		self.navigationItem.prompt = @"Status updated...";
	}	
	[self performSelectorOnMainThread:@selector(finishLoading:) withObject:nil waitUntilDone:NO];
	[pool release];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    ABRecordRef person = (ABRecordRef)[addBookPeople objectAtIndex:[indexPath row]];
	ABUnknownPersonViewController *personViewController = [[ABUnknownPersonViewController alloc] init];
	personViewController.displayedPerson = person;
	personViewController.allowsAddingToAddressBook = YES;
	[self.navigationController pushViewController:personViewController animated:YES];
	[personViewController release];
	
}


@end


