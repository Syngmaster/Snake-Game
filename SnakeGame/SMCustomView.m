//
//  SMCustomView.m
//  SnakeGame
//
//  Created by Syngmaster on 26/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMCustomView.h"

@implementation SMCustomView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        self.layer.borderWidth = 1.0;
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.layer.borderWidth = 3.0;
    } else {
        self.layer.borderWidth = 1.0;
    }
    
    self.layer.borderColor = [UIColor colorWithRed:35/255.0 green:115/255.0 blue:0/255.0 alpha:1.0].CGColor;
    self.layer.cornerRadius = self.bounds.size.width*0.05;
    self.backgroundColor = [UIColor colorWithRed:189.0/255.0 green:255.0/255.0 blue:147.0/255.0 alpha:1.0];
    
    self.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowOpacity = 0.7;
    self.layer.shadowRadius = 1.0;
}

@end
