//
//  KGAuditudeView.m
//  Prueba
//
//  Created by Sergio Botero on 8/8/11.
//  Copyright 2011 Kogi Mobile. All rights reserved.
//

#import "KGAuditudeView.h"

@implementation KGAuditudeView

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"KGAuditiveVideoTouch" object:nil];
}

@end
