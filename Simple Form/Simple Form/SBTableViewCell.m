//
//  SBTableViewCell.m
//  Simple Form
//
//  Created by Sergio Botero on 4/5/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import "SBTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation SBTableViewCell
@synthesize value;
@synthesize name;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier name:(NSString *) givenName neededKeyboard:(UIKeyboardType) kbtype andColor:(UIColor *) color {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		[self setName:givenName];
       self.selectionStyle = UITableViewCellSelectionStyleNone;
       
       UILabel * label;
       UITextField * text;
       
       CGFloat cellWidth = self.contentView.frame.size.width;
       CGFloat spacing = 4;
       CGFloat fontSize = 15;
       CGFloat fixedPadding = 8;

       CGRect labelFrame = self.contentView.frame;

       label = [[UILabel alloc] initWithFrame:labelFrame];
       [label setText:NSLocalizedString(givenName, @"")];
       [label setFont:[UIFont systemFontOfSize:fontSize]];
       [label setTextAlignment:UITextAlignmentRight];

       labelFrame.size.width = [givenName sizeWithFont:[UIFont systemFontOfSize:fontSize]].width + spacing;
       labelFrame.size.height -= spacing;
       labelFrame.origin.y += (spacing / 2.0);
       [label setFrame:labelFrame];
       [self.contentView addSubview:label];

       
		CGSize textSize = CGSizeMake(cellWidth - 3.0*fixedPadding - labelFrame.size.width , self.contentView.frame.size.height -spacing);
		CGRect textFrame = CGRectMake(cellWidth - textSize.width - fixedPadding, spacing / 2.0, textSize.width, textSize.height);
		text = [[UITextField alloc] initWithFrame:textFrame];
		
		NSString * savedRecord = [SBSaveInfo objectForKey:givenName];
		
		if (![savedRecord isEqual:[NSNull null]]) {
			[text setText:savedRecord];
		}
		
		[text addTarget:self action:@selector(saveValue:) forControlEvents:UIControlEventEditingChanged];
		[text setDelegate:self];
		[text setFont:[UIFont systemFontOfSize:fontSize]];
		[text setBackgroundColor:[UIColor whiteColor]];
		[text setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
		[text setKeyboardType:kbtype];
		[text setAutocorrectionType:UITextAutocorrectionTypeDefault];
		[text setAutocapitalizationType:UITextAutocapitalizationTypeNone];
		[self.contentView addSubview:text];
		
       
       UIView * vertical = [[UIView alloc] initWithFrame:CGRectMake(labelFrame.origin.x + labelFrame.size.width + (spacing / 2.0), 0, 1 , self.contentView.frame.size.height)];
       [vertical setBackgroundColor:[UIColor lightGrayColor]];

       [self.contentView addSubview:vertical];
       
       
       [vertical release];
       [text release];
       [label release];
    
    }
    return self;
}


- (void) saveValue:(id) textF {
	[SBSaveInfo setObject:[textF text] forKey:self.name];
}

- (void)dealloc
{
	[value release];
	[name release];
	[super dealloc];
}

@end
