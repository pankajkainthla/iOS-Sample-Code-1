//
//  CellView.h
//  Pink
//
//  Created by Sergio Botero on 12/3/10.
//  Copyright 2010 Sergiobuj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AQGridViewCell.h"

@interface CellView : AQGridViewCell {
	UIImageView * imageView;
	UILabel * titleLabel;
	UIActivityIndicatorView *spinner;

}

@property (nonatomic, retain) UIImage * image;
@property (nonatomic, copy) NSString * title;


@end
