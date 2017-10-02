//
//  SMCustomButton.m
//  SnakeGame
//
//  Created by Syngmaster on 26/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMCustomButton.h"

@implementation SMCustomButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [UIView setAnimationsEnabled:NO];
    
    CGFloat fontSize = CGRectGetHeight(self.frame)*0.35;
    UIFont *font = [UIFont fontWithName:@"Avenir-Heavy" size:fontSize];
    UIColor *textColor = [UIColor colorWithRed:35.0/255.0 green:115.0/255.0 blue:0/255.0 alpha:1.0];
    NSDictionary *attributes = @{NSForegroundColorAttributeName : textColor, NSFontAttributeName : font};
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.titleLabel.text attributes:attributes];
    
    [self setAttributedTitle:attrString forState:UIControlStateNormal];
    
    [self layoutIfNeeded];
    [UIView setAnimationsEnabled:YES];
}

@end
