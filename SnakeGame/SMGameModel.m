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

        }
        self.mainViewRect = [UIScreen mainScreen].bounds;
        
    }
    return self;
}


- (CGPoint)generateRandomCoordinates {
    
    NSUInteger newX = self.snakeStep + self.snakeStep * arc4random_uniform((CGRectGetMaxX(self.mainViewRect) - self.snakeStep*2)/self.snakeStep);
    NSUInteger newY = self.snakeStep + self.snakeStep * arc4random_uniform((CGRectGetMaxY(self.mainViewRect) - self.snakeStep)/self.snakeStep);
    
    CGPoint newPoint = CGPointMake(newX, newY);
    
    return newPoint;
    
}

@end
