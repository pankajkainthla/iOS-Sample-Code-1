//
//  GridViewController.m
//  Pink
//
//  Created by Sergio Botero on 12/2/10.
//  Copyright 2010 Sergiobuj. All rights reserved.
//
#import "GridViewController.h"
NSString *const host = @"http://coleccionropa.net";

@implementation GridViewController
@synthesize gridView = _gridView;
@synthesize categoryId;
@synthesize genreSection = _genreSection;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */

- (id)initWithCategory:(int) category andSection:(NSString *) section {
	self = [super init];
	if (self) {
		
		self.categoryId = category;
		self.genreSection = section;
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		itemsFilename = [[NSString alloc] initWithString:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@CATEG%ddat", self.genreSection, self.categoryId]]];
		
		thumbsFilename = [[NSString alloc] initWithString:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@CATEG%dthumbs", self.genreSection, self.categoryId]]];
		
		largeImgFilename = [[NSString alloc] initWithString:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@CATEG%dlarge", self.genreSection, self.categoryId]]];
		
		
		
		_itemsNames = [[NSMutableArray alloc] initWithContentsOfFile:itemsFilename];		
		images = [[NSMutableDictionary alloc] initWithContentsOfFile:thumbsFilename];
		modalImages = [[NSMutableDictionary alloc] initWithContentsOfFile:largeImgFilename];

		imagesOperations = [[NSOperationQueue alloc] init];
		[imagesOperations setMaxConcurrentOperationCount:1];
//		xmlParser = [[SBXMLParserCat alloc] init];
//		[xmlParser setDelegate:self];
		
		[self.gridView setIndicatorStyle:UIScrollViewIndicatorStyleBlack];
		[self.gridView setSeparatorStyle:AQGridViewCellSeparatorStyleSingleLine];
		self.gridView = [[AQGridView alloc] initWithFrame:self.view.frame];
		[self.gridView setDataSource:self];
		[self.gridView setDelegate:self];
		[self.gridView setBackgroundColor: [UIColor darkGrayColor]];
		
		[self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
		
		[self setView:self.gridView];
		[self.gridView reloadData];
	}

	return self;
}


/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */
 
- (void) viewWillDisappear:(BOOL)animated {

	[imagesOperations cancelAllOperations];
	
	/*
	for (NSString * key in [images allKeys]) {
		NSLog(@"\n\n>%@< >%@<\n", key ,[images objectForKey:key]);
	}*/
	
//	NSLog(@"will write %d elements to %@\n\n\n", [images count], thumbsFilename);
//	if([images writeToFile:thumbsFilename atomically:YES]) NSLog(@"se puede escribir");
	
	
//	NSLog(@"will write %d elements to %@", [modalImages count], largeImgFilename);
//	[modalImages writeToFile:largeImgFilename atomically:YES];
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	if (_itemsNames == nil) {
		_itemsNames = [[NSMutableArray alloc] init];
		[NSThread detachNewThreadSelector:@selector(loadData) toTarget:self withObject:nil];
		spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		UIBarButtonItem * spinnerBar = [[UIBarButtonItem alloc] initWithCustomView:spinner];
		[self.navigationItem setRightBarButtonItem:spinnerBar];
		[spinnerBar release];
		[spinner startAnimating];
	}
	
	if (images == nil){
		images = [[NSMutableDictionary alloc] init];
	}
	
	if (modalImages == nil)	{
		modalImages = [[NSMutableDictionary alloc] init ];
	}
	[self.gridView reloadData];
}


- (void) loadData {
//	[xmlParser parseUrl:[NSString stringWithFormat:@"%@/categorias/%d.xml", host, self.categoryId]];
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSError * error = nil;
	NSString * resourceAsString = [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/categorias/%d.json", host, self.categoryId]] encoding:NSUTF8StringEncoding error:&error];

	if (error) {
		NSLog(@"%@", error);
	}else {
		NSData * jsonData = [resourceAsString dataUsingEncoding:NSUTF32BigEndianStringEncoding];
		
		NSDictionary * dictionary = [[[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error] objectForKey:@"category"];
		
		if (error) {
			NSLog(@"%@", error);
		}else{
			/*
			for (NSDictionary * dict in [dictionary objectForKey:@"products"])
				for (NSString * str in [dict allKeys])
					NSLog(@"(%@) (%@)", str,  [dict objectForKey:str]);
			*/
			
			[self performSelectorOnMainThread:@selector(responseArray:) withObject:[dictionary objectForKey:@"products"] waitUntilDone:NO];
		}
	}
	
	[pool drain];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
	//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[images release];
//	[xmlParser release];
	[imagesOperations release];
	[_gridView release];
	[_itemsNames release];
	[spinner release];
	[_genreSection release];
	[thumbsFilename release];
	[itemsFilename release];
	[largeImgFilename release];
    [super dealloc];
}


#pragma mark -
#pragma mark AQGridViewDelegate
// Called before selection occurs. Return a new index, or NSNotFound, to change the proposed selection.
//- (NSUInteger) gridView: (AQGridView *) gridView willSelectItemAtIndex: (NSUInteger) index {return 1;}
//- (NSUInteger) gridView: (AQGridView *) gridView willDeselectItemAtIndex: (NSUInteger) index {return 1;}
// Called after the user changes the selection
- (void) gridView: (AQGridView *) gridView didSelectItemAtIndex: (NSUInteger) index {
	
	
	NSString * imageUrlModal = [NSString stringWithFormat:@"%@%@",host, [[_itemsNames objectAtIndex:index] objectForKey:@"modal_photo"] ];	

	ModalView *viewCont;
	if ([modalImages objectForKey:imageUrlModal]) {
		viewCont = [[ModalView alloc] initWithImage:[UIImage imageWithData:[modalImages objectForKey:imageUrlModal]] ];
	}else {
		viewCont = [[ModalView alloc] initWithImage:imageUrlModal andDelegate:self];		
	}

	[viewCont setTitle:[[_itemsNames objectAtIndex: index] objectForKey:@"name"]];
	UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:viewCont];
	
	[navCon.navigationBar setTintColor:[UIColor blackColor] ];
	[self presentModalViewController:navCon animated:YES];
	[viewCont release];
	[navCon release];
	[self.gridView deselectItemAtIndex:index animated:YES];
}

- (void) gridView: (AQGridView *) gridView didDeselectItemAtIndex: (NSUInteger) index { }



#pragma mark -
#pragma mark AQGridViewDataSourceDelegate


- (NSUInteger) numberOfItemsInGridView: (AQGridView *) gridView { 
	
	return [_itemsNames count];
}

- (AQGridViewCell *) gridView: (AQGridView *) gv cellForItemAtIndex: (NSUInteger) index {
	
	static NSString * CellIdentifier = @"reusableTile";
	
	//  AQGridViewCell * cell = nil;
    /*
	 CellView * plainCell = (CellView *)[gv dequeueReusableCellWithIdentifier: CellIdentifier];
	 if ( plainCell == nil )
	 {
	 plainCell = [[[CellView alloc] initWithFrame: CGRectMake(0.0, 0.0, 200.0, 150.0)
	 reuseIdentifier: CellIdentifier] autorelease];
	 plainCell.selectionGlowColor = [UIColor blueColor];
	 }
	 
	 plainCell.image = [UIImage imageNamed: [_imageNames objectAtIndex: index]];
	 
	 //            cell = plainCell;
	 
	 */
	CellView * filledCell = (CellView *)[gv dequeueReusableCellWithIdentifier: CellIdentifier];
	if ( filledCell == nil )
	{
		filledCell = [[[CellView alloc] initWithFrame: CGRectMake(0.0, 0.0, 200.0, 150.0)
									  reuseIdentifier: CellIdentifier] autorelease];
		filledCell.selectionStyle = AQGridViewCellSelectionStyleRed;
	}
//	NSString * imageUrl = [[NSString alloc] initWithFormat:@"%@%@",host, [[_itemsNames objectAtIndex:index] objectForKey:@"main_photo"]];
	NSString * imageUrl = [NSString stringWithFormat:@"%@%@",host, [[_itemsNames objectAtIndex:index] objectForKey:@"main_photo"] ];
	//NSLog(@"%@", imageUrl);
	[filledCell setImage:[self setImage:imageUrl]];
	[filledCell setTitle:[[_itemsNames objectAtIndex:index] objectForKey:@"name"]];

	//cell = filledCell;
	//	[imageUrl autorelease];	
	return filledCell;
    //return plainCell;
}

// all cells are placed in a logical 'grid cell', all of which are the same size. The default size is 96x128 (portrait).
// The width/height values returned by this function will be rounded UP to the nearest denominator of the screen width.
//- (CGSize) portraitGridCellSizeForGridView: (AQGridView *) gridView { }




#pragma mark -
#pragma mark ImageFetchingMethods


- (UIImage *) setImage:(NSString *)theUrl{
	id userImage = [images objectForKey:theUrl];
	if(userImage == nil){
		[images setObject:[NSNull null] forKey:theUrl];     
		GetImage *op = [[GetImage alloc] initWithTheURL:theUrl target:self action:@selector(getImage:)];
		[imagesOperations addOperation:op];
		[op release];
	}else if ([userImage isKindOfClass:[NSData class]]) {
		return [UIImage imageWithData:userImage];
	}
	return [UIImage imageNamed:@""];
}

//method to fetch one image
//info comes from GetImage.m in the main method
//NSArray * theArray= [NSArray arrayWithObjects:imageUrl,theImage,nil];
- (void) getImage:(NSDictionary *)info{
	NSString* url = [info objectForKey:@"url"];
	id image = [info objectForKey:@"image"];
	
	[images setObject:UIImageJPEGRepresentation(image, 0.5) forKey:url];
	[images writeToFile:thumbsFilename atomically:YES];
	NSMutableSet *filepathsSet = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedFilepaths"];
	[filepathsSet setByAddingObject:thumbsFilename];
	[[NSUserDefaults standardUserDefaults] setObject:filepathsSet forKey:@"savedFilepaths"];
	[self.gridView reloadData];
	
}

- (void) responseArray:(NSMutableArray *)array {
	[_itemsNames setArray:array];

	[self.gridView reloadData];
	[spinner stopAnimating];
	[_itemsNames writeToFile:itemsFilename atomically:YES];
	NSMutableSet *filepathsSet = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedFilepaths"];
	[filepathsSet setByAddingObject:itemsFilename];
	[[NSUserDefaults standardUserDefaults] setObject:filepathsSet forKey:@"savedFilepaths"];

}

- (void) backFromModalWithImage:(UIImage*)image forUrl:(NSString *)url{

	if ([modalImages objectForKey:url] == nil && image){
		[modalImages setObject:UIImageJPEGRepresentation(image, 0.5) forKey:url];
		[modalImages writeToFile:largeImgFilename atomically:YES];
		NSMutableSet *filepathsSet = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedFilepaths"];
		[filepathsSet setByAddingObject:largeImgFilename];
		[[NSUserDefaults standardUserDefaults] setObject:filepathsSet forKey:@"savedFilepaths"];
	}
}


@end