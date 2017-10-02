//
//  SMSettingsButton.m
//  SnakeGame
//
//  Created by Syngmaster on 26/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMSettingsButton.h"

@implementation SMSettingsButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = [UIColor colorWithRed:35/255.0 green:115/255.0 blue:0/255.0 alpha:1.0].CGColor;
    self.backgroundColor = [UIColor colorWithRed:241/255.0 green:255/255.0 blue:197/255.0 alpha:1.0];
    
    [UIView setAnimationsEnabled:NO];
    
    CGFloat fontSize = CGRectGetHeight(self.frame)*0.4;
    UIFont *font = [UIFont fontWithName:@"Avenir-Heavy" size:fontSize];
    UIColor *textColor = [UIColor colorWithRed:35.0/255.0 green:115.0/255.0 blue:0/255.0 alpha:1.0];
    NSDictionary *attributes = @{NSForegroundColorAttributeName : textColor, NSFontAttributeName : font};
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.titleLabel.text attributes:attributes];
    
    [self setAttributedTitle:attrString forState:UIControlStateNormal];
    
    [self layoutIfNeeded];
    [UIView setAnimationsEnabled:YES];
    
}

@end
