//
//  PruebaViewController.m
//  Prueba
//
//  Created by Carlos Arenas on 7/29/11.
//  Copyright 2011 Kogi Mobile. All rights reserved.
//

#import "PruebaViewController.h"

#import "VideoViewController.h"


@implementation PruebaViewController

#pragma mark - View lifecycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
    
	//NSDate *date = [NSDate date];
	//	BCItemCollection *bic = [bc findModifiedVideos:date filters:nil pageSize:50 pageNumber:0 sortBy:BCSortByTypeCreationDate sortOrder:BCSortOrderTypeDESC getItemCount:YES videoFields:nil customFields:nil error:nil];
	
	//	    NSError *errx;
	//	BCItemCollection *videoCollection = [bc findAllVideos:60 pageNumber:0 sortBy:BCSortByTypePlaysTrailingWeek sortOrder:BCSortOrderTypeDESC getItemCount:NO videoFields:[NSArray arrayWithObjects:@"FLVURL", @"thumbnailURL", @"name", @"shortDescription", @"renditions", nil] customFields:nil error:&errx];
	
	//	BCItemCollection *playlists = [bc findPlaylistsByIds:[NSArray arrayWithObjects:@"000000000",@"0000000000",@"000000000", nil]videoFields:[NSArray arrayWithObjects:@"id", @"FLVURL", @"thumbnailURL", @"name", @"shortDescription", @"renditions", nil] playlistFields:[NSArray arrayWithObjects:@"id", @"name", @"videos", nil] customFields:nil error:&errx];

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (IBAction)upVideo:(id)sender {

	
	VideoViewController * vvc = [[VideoViewController alloc] init];
	vvc.videoID = 1093226789001;
	[self presentModalViewController:vvc animated:YES];
	[vvc release];

}


@end
