//
//  SMMealModel.m
//  SnakeGame
//
//  Created by Syngmaster on 20/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMMealModel.h"

@implementation SMMealModel

- (UIView *)createMealView {
    
    CGPoint newCoordinates = CGPointMake(0, 0);
    
    UIView *newMealView = [[UIView alloc] initWithFrame:CGRectMake(newCoordinates.x, newCoordinates.y, self.snakeStep, self.snakeStep)];
    
    newMealView.tag = GameElementApple;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:newMealView.bounds];
    imageView.image = [UIImage imageNamed:@"apple.png"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [newMealView addSubview:imageView];
    
    return newMealView;
}

@end
