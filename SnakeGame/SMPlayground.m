//
//  SMPlayground.m
//  SnakeGame
//
//  Created by Syngmaster on 21/06/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMPlayground.h"

@implementation SMPlayground

- (instancetype)initWithView:(UIView *) view
{
    self = [super init];
    if (self) {
        
        CGRect frame = CGRectMake(0, 0, CGRectGetWidth(view.bounds)*0.8, CGRectGetHeight(view.bounds)*0.8);
        self.frame = frame;
        self.center = view.center;
        
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 2.0;
        
    }
    return self;
}

@end
