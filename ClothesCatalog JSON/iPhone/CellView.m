//
//  CellView.m
//  Pink
//
//  Created by Sergio Botero on 12/3/10.
//  Copyright 2010 Sergiobuj. All rights reserved.
//

#import "CellView.h"


@implementation CellView


- (id) initWithFrame: (CGRect) frame reuseIdentifier: (NSString *) reuse
{
    self = [super initWithFrame: frame reuseIdentifier: reuse];
    if ( self == nil )
        return nil;

    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    imageView = [[UIImageView alloc] initWithFrame: CGRectZero];
    titleLabel = [[UILabel alloc] initWithFrame: CGRectZero];
	[titleLabel setTextColor:[UIColor lightGrayColor]];
//    _title.highlightedTextColor = [UIColor darkgraColor];
    titleLabel.font = [UIFont boldSystemFontOfSize: 12.0];
    titleLabel.adjustsFontSizeToFitWidth = YES;
	//    _title.minimumFontSize = 10.0;
    
	//    self.backgroundColor = [UIColor colorWithWhite: 0.95 alpha: 1.0];
	self.backgroundColor = [UIColor darkGrayColor];
	self.contentView.backgroundColor = self.backgroundColor;
	imageView.backgroundColor = self.backgroundColor;
	titleLabel.backgroundColor =  self.backgroundColor;

	[spinner setCenter:CGPointMake(50, 50)];
    [self.contentView addSubview:spinner];

	[spinner startAnimating];
    [self.contentView addSubview: imageView];
    [self.contentView addSubview: titleLabel];
    
    return self;
}

- (void) dealloc
{
	[spinner release];
    [imageView release];
    [titleLabel release];
    [super dealloc];
}

- (UIImage *) image {
    return [imageView image];
}

- (void) setImage: (UIImage *) newImage {

	if ([spinner isHidden] && [spinner isAnimating]) {
		[spinner stopAnimating];
	}
	[imageView setImage:newImage];
	[self setNeedsLayout];
    
}

- (NSString *) title {
    return [titleLabel text];
}

- (void) setTitle: (NSString *) newTitle {
    [titleLabel setText:newTitle];
    [self setNeedsLayout];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
 //   CGSize imageSize = imageView.image.size;
    CGRect bounds = CGRectInset( self.contentView.bounds, 10.0, 10.0 );
//
//	
    [titleLabel sizeToFit];
    CGRect frame = titleLabel.frame;
    frame.size.width = MIN(frame.size.width, bounds.size.width);
    frame.origin.y = CGRectGetMaxY(bounds) - frame.size.height;
    frame.origin.x = floorf((bounds.size.width - frame.size.width) * 0.5)+10;
    titleLabel.frame = frame;
//    
//    // adjust the frame down for the image layout calculation
//    bounds.size.height = frame.origin.y - bounds.origin.y;
//    
//    if ( (imageSize.width <= bounds.size.width) &&
//        (imageSize.height <= bounds.size.height) )
//    {
//        return;
//    }
//    
//    // scale it down to fit
//    CGFloat hRatio = bounds.size.width / imageSize.width;
//    CGFloat vRatio = bounds.size.height / imageSize.height;
//    CGFloat ratio = MIN(hRatio, vRatio);
//    
	[imageView sizeToFit];
    frame = imageView.frame;
//    frame.size.width = floorf(imageSize.width * ratio);
//	frame.size.height = floorf(imageSize.height * ratio);
    frame.origin.x = floorf((bounds.size.width - frame.size.width) * 0.5) +10;
    frame.origin.y = floorf((bounds.size.height - frame.size.height) * 0.5);
    imageView.frame = frame;

}

@end
