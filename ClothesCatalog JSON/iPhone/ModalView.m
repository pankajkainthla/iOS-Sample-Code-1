//
//  ModalView.m
//  ClothesCatalog
//
//  Created by Sergio Botero on 12/4/10.
//  Copyright 2010 Sergiobuj. All rights reserved.
//

#import "ModalView.h"


@implementation ModalView
@synthesize delegate;
@synthesize imageUrl;

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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	
	UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(modalToBeDismissed)];
	
	[self.navigationItem setRightBarButtonItem:button];
	[button release];
	
}

- (id) initWithImage:(NSString *)image andDelegate:(id)sentDelegate {
	
	self = [super init];
	if (self) {
		UIActivityIndicatorView * spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		[spinner startAnimating];
		UIBarButtonItem * spinBut = [[UIBarButtonItem alloc] initWithCustomView:spinner];
		[self.navigationItem setLeftBarButtonItem:spinBut];
		[spinBut release];
		[spinner release];
		[self.view setBackgroundColor:[UIColor darkGrayColor]];
		[self setImageUrl: image];
		
		[self setDelegate:sentDelegate];
		
		opQueue = [[NSOperationQueue alloc] init];
		[opQueue setMaxConcurrentOperationCount:1];
		[opQueue addOperationWithBlock:^{
			
			NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.imageUrl]];
			
			imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:data]];
			[data release];
			[imageView setBackgroundColor:[UIColor darkGrayColor]];
			scroll = [[UIScrollView alloc] init];
			[scroll setScrollEnabled:YES];
			[scroll setDelegate:self];
			[scroll setBackgroundColor:[UIColor darkGrayColor]];
			[scroll setMinimumZoomScale:0.75];
			[scroll setMaximumZoomScale:3.0];
			[scroll setClipsToBounds:YES];
			[scroll setContentSize:[imageView frame].size];
			[scroll addSubview:imageView];
			[scroll setFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height)];
			[scroll setCenter:self.view.center];
			[self.view addSubview:scroll];
			
			[self.navigationItem setLeftBarButtonItem:nil];
			
		}];
		
	}
	return self;
}

- (id) initWithImage:(UIImage *)image {
	self = [super init];
	if (self) {
		[self.view setBackgroundColor:[UIColor darkGrayColor]];
		
		imageView = [[UIImageView alloc] initWithImage:image];
		[imageView setBackgroundColor:[UIColor darkGrayColor]];
		scroll = [[UIScrollView alloc] init];
		[scroll setScrollEnabled:YES];
		[scroll setDelegate:self];
		[scroll setBackgroundColor:[UIColor darkGrayColor]];
		[scroll setMinimumZoomScale:0.75];
		[scroll setMaximumZoomScale:3.0];
		[scroll setClipsToBounds:YES];
		[scroll setContentSize:[imageView frame].size];
		[scroll addSubview:imageView];
		[scroll setFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height)];
		[self.view addSubview:scroll];
		
	}
	return self;
	
}

/*
 - (id) initWithImage:(UIImage *) image {
 self = [super init];
 if (self) {
 imageView = [[UIImageView alloc] initWithImage:image];
 
 scroll = [[UIScrollView alloc] init];
 scroll.scrollEnabled = YES;
 scroll.pagingEnabled = YES;
 scroll.directionalLockEnabled = YES;
 scroll.showsVerticalScrollIndicator = NO;
 scroll.showsHorizontalScrollIndicator = NO;
 scroll.delegate = self;
 scroll.backgroundColor = [UIColor darkGrayColor];
 scroll.autoresizesSubviews = YES;
 scroll.frame = CGRectMake(0, 0, 320, 480);
 scroll.contentSize = CGSizeMake(imageView.frame.size.width, imageView.frame.size.height);
 *scroll.maximumZoomScale = 4.0;
 *scroll.minimumZoomScale = 0.75;
 *scroll.clipsToBounds = YES;
 [self.view addSubview:scroll];
 
 [scroll addSubview:imageView];
 }
 return self;
 }
 */

- (void) modalToBeDismissed {
	
	if ([self.delegate respondsToSelector:@selector(backFromModalWithImage:forUrl:)]) {
		[self.delegate backFromModalWithImage:[imageView image] forUrl:imageUrl];
		
	}
	[self dismissModalViewControllerAnimated:YES];	
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	[super viewDidUnload];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[scroll release];
	[imageUrl release];
	[opQueue release];
	[imageView release];
	[self.delegate release];
	[super dealloc];
}


- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return imageView;
}

@end
