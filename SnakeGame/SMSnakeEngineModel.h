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

typedef NS_ENUM(NSInteger, AlertType) {
    
    AlertTypeGameOver,
    AlertTypeNextLevel
    
};

@interface SMSnakeEngineModel : NSObject

@property (strong, nonatomic) SMGameModel *gameModel;
@property (assign, nonatomic) NSInteger gameMode;

- (instancetype)initWithGameModel:(SMGameModel *)gameModel;

- (void)generateSnakeInView:(UIView *)view;
- (void)generateRandomMealInView:(UIView *)view;
- (void)generateRandomHazardInView:(UIView *)view;

- (void)snakeNewMovement:(NSMutableArray *)snake inView:(UIView *)playgroundView withDirectionX:(int)directionX andDirectionY:(int)directionY;

@end
