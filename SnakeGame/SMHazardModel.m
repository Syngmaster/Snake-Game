//
//  SMHazardModel.m
//  SnakeGame
//
//  Created by Syngmaster on 20/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMHazardModel.h"

@implementation SMHazardModel

- (UIView *)createHazardView {
    
    CGPoint newCoordinates = [self generateRandomCoordinates];
    
    UIView *newHazardView = [[UIView alloc] initWithFrame:CGRectMake(newCoordinates.x, newCoordinates.y, self.snakeStep, self.snakeStep)];
    
    newHazardView.tag = GameElementHazard;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:newHazardView.bounds];
    
    UIImage *tree1 = [UIImage imageNamed:@"spider2.png"];
    UIImage *tree2 = [UIImage imageNamed:@"stone.png"];
    
    NSInteger num = (arc4random_uniform(1000)/500);
    imageView.image = (num == 0) ? tree1 : tree2;
    
    [newHazardView addSubview:imageView];
    
    return newHazardView;
}

@end
