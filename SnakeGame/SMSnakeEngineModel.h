//
//  SMSnakeEngineModel.h
//  SnakeGame
//
//  Created by Syngmaster on 21/06/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMGameModel;

typedef NS_ENUM(NSInteger, SnakeDirectionOption) {
    
    SnakeDirectionOptionUp = -1,
    SnakeDirectionOptionDown = 1,
    SnakeDirectionOptionLeft = -1,
    SnakeDirectionOptionRight = 1
    
};

@interface SMSnakeEngineModel : NSObject

@property (strong, nonatomic) SMGameModel *gameModel;

- (void)generateSnakeInView:(UIView *)view;
- (void)generateRandomMealInView:(UIView *) view;
- (void)generateRandomHazardInView:(UIView *)view;

/************** Method with a timer ******************/

- (void)snakeNewMovement:(NSMutableArray *)snake inView:(UIView *)playgroundView withDirectionX:(int)directionX andDirectionY:(int)directionY;

/************** Method using animations ******************/

//- (void)snakeMovement:(NSArray *) snake inView:(UIView *)playgroundView withDirectionX:(NSInteger) stepX andY:(NSInteger) stepY;

@end
