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
        
        //CGRect frame = CGRectMake(0, 0, CGRectGetWidth(view.bounds)*0.8, CGRectGetHeight(view.bounds)*0.8);
        self.frame = view.frame;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:view.frame];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.image = [UIImage imageNamed:@"shore_background.png"];
        [self addSubview:imageView];
        
    }
    return self;
}

@end
