//
//  SMSnakeModel.m
//  SnakeGame
//
//  Created by Syngmaster on 20/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMSnakeModel.h"

@implementation SMSnakeModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.snakeArray = [NSMutableArray array];
        
    }
    
    return self;
}

- (UIView *)createSnakeView {
    
    if ([self.snakeArray count] == 0) {
        
        CGPoint snakeCoordinates = [self generateRandomCoordinates];
        
        UIView *snakeView = [[UIView alloc] initWithFrame:CGRectMake(snakeCoordinates.x, snakeCoordinates.y, self.snakeStep, self.snakeStep)];
        snakeView.tag = GameElementSnakeBody;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:snakeView.bounds];
        imageView.image = [UIImage imageNamed:@"snake_head.png"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [snakeView addSubview:imageView];
        [self.snakeArray addObject:snakeView];
        
        return snakeView;
        
    } else {
        
        UIView *lastBody = self.snakeArray[[self.snakeArray count]-1];
        
        UIView *snakeView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(lastBody.frame), CGRectGetMinY(lastBody.frame), self.snakeStep, self.snakeStep)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:snakeView.bounds];
        imageView.image = [UIImage imageNamed:@"snake_body2.png"];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        snakeView.tag = GameElementSnakeBody;
        [snakeView addSubview:imageView];
        [self.snakeArray addObject:snakeView];
        
        return snakeView;
    }
    
}


@end
