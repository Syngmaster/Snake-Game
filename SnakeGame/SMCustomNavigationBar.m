//
//  SMCustomNavigationBar.m
//  SnakeGame
//
//  Created by Syngmaster on 28/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMCustomNavigationBar.h"

@implementation SMCustomNavigationBar

- (void)layoutSubviews {
    [super layoutSubviews];

    self.titleTextAttributes = @{ NSFontAttributeName : [UIFont fontWithName:@"Avenir-Heavy" size:20], NSForegroundColorAttributeName : [UIColor colorWithRed:35.0/255.0 green:115.0/255.0 blue:0/255.0 alpha:1.0] };
}

@end
