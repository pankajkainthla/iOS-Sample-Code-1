//
//  CommonChooser.h
//  ClothesCatalog
//
//  Created by Sergio Botero on 12/3/10.
//  Copyright 2010 Sergiobuj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridViewController.h"

@interface CommonChooser : UITableViewController {
	NSMutableArray * items;
	NSString *resource;
	UIActivityIndicatorView *spinner;
	NSString * categoryFilename;

}
- (id)initWithStyle:(UITableViewStyle)style andReource:(NSString*) xmlResource andTitle:(NSString *)tableTitle;
@end
