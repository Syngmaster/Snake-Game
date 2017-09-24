//
//  SMGameModel.m
//  SnakeGame
//
//  Created by Syngmaster on 20/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMGameModel.h"

@interface SMGameModel ()

@property (assign, nonatomic) CGRect mainViewRect;

@end

@implementation SMGameModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        switch ((int)[UIScreen mainScreen].bounds.size.width) {
                
            case 320: self.snakeStep = 20;
                break;
            case 375: self.snakeStep = SNAKE_STEP_IPHONE;
                break;
            case 414: self.snakeStep = SNAKE_STEP_IPHONE_PLUS;
                break;
            case 768: self.snakeStep = SNAKE_STEP_IPAD_9_7;
                break;
            case 834: self.snakeStep = SNAKE_STEP_IPAD_10_5;
                break;
            case 1024: self.snakeStep = SNAKE_STEP_IPAD_12_9;
                break;

        }
        self.mainViewRect = [UIScreen mainScreen].bounds;
        self.takenCoordinates = [NSMutableArray array];
        self.snakeArray = [NSMutableArray array];
        
        
    }
    return self;
}


- (CGPoint)generateRandomCoordinates {
    
    NSUInteger newX = self.snakeStep + self.snakeStep * arc4random_uniform((CGRectGetMaxX(self.mainViewRect) - self.snakeStep*2)/self.snakeStep);
    NSUInteger newY = self.snakeStep + self.snakeStep * arc4random_uniform((CGRectGetMaxY(self.mainViewRect) - self.snakeStep)/self.snakeStep);
    
    CGPoint newPoint = CGPointMake(newX, newY);
    
    /*if ([self.takenCoordinates count] > 0) {
        
        for (NSValue *coord in self.takenCoordinates) {
            
            if (CGPointEqualToPoint(coord.CGPointValue, newPoint)) {
                
                return [self generateRandomCoordinates];
            }
        }
    }*/

    
    [self.takenCoordinates addObject:[NSValue valueWithCGPoint:newPoint]];
    
    return newPoint;
    
}


- (UIView *)createSnakeView {
    
    if ([self.snakeArray count] == 0) {
        
        CGPoint snakeCoordinates = [self generateRandomCoordinates];
        
        UIView *snakeView = [[UIView alloc] initWithFrame:CGRectMake(snakeCoordinates.x, snakeCoordinates.y, self.snakeStep, self.snakeStep)];
        snakeView.tag = GameElementSnakeBody;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:snakeView.bounds];
        imageView.image = [UIImage imageNamed:@"snake_head_new.png"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [snakeView addSubview:imageView];
        [self.snakeArray addObject:snakeView];
        
        return snakeView;
        
    } else if ([self.snakeArray count] == 1) {
        
        UIView *lastBody = self.snakeArray[[self.snakeArray count]-1];
        
        UIView *snakeView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(lastBody.frame), CGRectGetMinY(lastBody.frame) + self.snakeStep, self.snakeStep, self.snakeStep)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:snakeView.bounds];
        imageView.image = [UIImage imageNamed:@"snake_tail_new.png"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        snakeView.tag = GameElementSnakeTail;
        [snakeView addSubview:imageView];
        [self.snakeArray addObject:snakeView];
        
        return snakeView;
        
    } else {
        
        UIView *lastBody = self.snakeArray[1];
        
        UIView *snakeView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(lastBody.frame), CGRectGetMinY(lastBody.frame), self.snakeStep, self.snakeStep)];
        snakeView.layer.affineTransform = lastBody.layer.affineTransform;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:snakeView.bounds];
        imageView.image = [UIImage imageNamed:@"snake_body_new.png"];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        snakeView.tag = GameElementSnakeBody;
        [snakeView addSubview:imageView];
        [self.snakeArray insertObject:snakeView atIndex:1];
        
        return snakeView;
        
    }
    
}


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


- (UIView *)createMealView {
    
    CGPoint newCoordinates = [self generateRandomCoordinates];
    
    UIView *newMealView = [[UIView alloc] initWithFrame:CGRectMake(newCoordinates.x, newCoordinates.y, self.snakeStep, self.snakeStep)];
    
    newMealView.tag = GameElementApple;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:newMealView.bounds];
    imageView.image = [UIImage imageNamed:@"apple.png"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [newMealView addSubview:imageView];
    
    return newMealView;
}

@end
