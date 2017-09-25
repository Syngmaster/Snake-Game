//
//  SMGameModel.h
//  SnakeGame
//
//  Created by Syngmaster on 20/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SNAKE_STEP_IPHONE_5_5S 21;
#define SNAKE_STEP_IPHONE 25;
#define SNAKE_STEP_IPHONE_PLUS 27;
#define SNAKE_STEP_IPAD_9_7 45;
#define SNAKE_STEP_IPAD_10_5 49;
#define SNAKE_STEP_IPAD_12_9 60;

typedef NS_ENUM(NSInteger, GameElement) {
    
    GameElementSnakeBody = 1,
    GameElementApple,
    GameElementHazard,
    GameElementSnakeTail
    
};

@interface SMGameModel : NSObject

@property (assign, nonatomic) CGFloat snakeStep;
@property (strong, nonatomic) NSMutableArray *takenCoordinates;

- (CGPoint)generateRandomCoordinates;


// snake model

@property (strong, nonatomic) NSMutableArray *snakeArray;

- (UIView *)createSnakeView;

// hazard model

- (UIView *)createHazardView;

// meal model

- (UIView *)createMealView;


@end
