//
//  GridViewController.h
//  Pink
//
//  Created by Sergio Botero on 12/2/10.
//  Copyright 2010 Sergiobuj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AQGridView.h"
#import "AQGridViewCell.h"
#import "CellView.h"
#import "GetImage.h"
//#import "SBXMLParserCat.h"
#import "ModalView.h"
#import "CJSONDeserializer.h"

@interface GridViewController : UIViewController <SBModalViewDelegate, AQGridViewDelegate, AQGridViewDataSource /*, SBParserDelegateCat*/> {
	AQGridView * _gridView;
	NSMutableArray * _itemsNames;
	NSOperationQueue * imagesOperations;
//	SBXMLParserCat * xmlParser;
	
	int categoryId;
	NSString * _genreSection;
	NSMutableDictionary * images;
	NSMutableDictionary * modalImages;
	UIActivityIndicatorView *spinner;
	
	NSString * itemsFilename;
	NSString * thumbsFilename;
	NSString * largeImgFilename;
	
}

- (UIImage *) setImage:(NSString *)theUrl;
- (id)initWithCategory:(int) category andSection:(NSString *) section;

@property (nonatomic, retain) AQGridView * gridView;
@property (nonatomic) int categoryId;
@property (nonatomic, copy) NSString * genreSection;
@end