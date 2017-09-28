//
//  SMBottomMenuView.m
//  SnakeGame
//
//  Created by Syngmaster on 28/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMBottomMenuView.h"

@implementation SMBottomMenuView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [UIColor colorWithRed:35/255.0 green:115/255.0 blue:0/255.0 alpha:1.0].CGColor;
    self.backgroundColor = [UIColor colorWithRed:189.0/255.0 green:255.0/255.0 blue:147.0/255.0 alpha:1.0];
    
}

@end
