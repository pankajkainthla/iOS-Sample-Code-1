//
//  SBTableViewCell.h
//  Simple Form
//
//  Created by Sergio Botero on 4/5/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBSaveInfo.h"

@interface SBTableViewCell : UITableViewCell <UITextFieldDelegate>{
   NSString * value;
	NSString * name;
}

@property (nonatomic, copy) NSString * value;
@property (nonatomic, copy) NSString * name;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier name:(NSString *) givenName neededKeyboard:(UIKeyboardType) kbtype andColor:(UIColor *) color;
- (void) saveValue:(id)cell;
@end
