//
//  SMChooseButton.m
//  SnakeGame
//
//  Created by Syngmaster on 28/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMChooseButtonView.h"

@implementation SMChooseButtonView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = [UIColor colorWithRed:35/255.0 green:115/255.0 blue:0/255.0 alpha:1.0].CGColor;
    self.backgroundColor = [UIColor colorWithRed:189/255.0 green:255/255.0 blue:147/255.0 alpha:1.0];
    
}

- (void)selectView {
    
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.backgroundColor = [UIColor colorWithRed:35/255.0 green:115/255.0 blue:0/255.0 alpha:1.0];
}

- (void)resetView {
    
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = [UIColor colorWithRed:35/255.0 green:115/255.0 blue:0/255.0 alpha:1.0].CGColor;
    self.backgroundColor = [UIColor colorWithRed:189/255.0 green:255/255.0 blue:147/255.0 alpha:1.0];
}

@end
