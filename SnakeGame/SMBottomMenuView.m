//
//  SMBottomMenuView.m
//  SnakeGame
//
//  Created by Syngmaster on 28/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMBottomMenuView.h"

@implementation SMBottomMenuView


- (void)layoutSubviews {
    [super layoutSubviews];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        self.layer.borderWidth = 1.0;
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.layer.borderWidth = 3.0;
    } else {
        self.layer.borderWidth = 1.0;
    }
    
    self.layer.borderColor = [UIColor colorWithRed:35/255.0 green:115/255.0 blue:0/255.0 alpha:1.0].CGColor;
    self.backgroundColor = [UIColor colorWithRed:189.0/255.0 green:255.0/255.0 blue:147.0/255.0 alpha:1.0];
}

@end
