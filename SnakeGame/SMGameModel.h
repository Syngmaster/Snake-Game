//
//  SMGameModel.h
//  SnakeGame
//
//  Created by Syngmaster on 20/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GameElement) {
    
    GameElementSnakeBody = 1,
    GameElementMeal,
    GameElementHazard,
    GameElementSnakeTail
    
};

@class SMPlayground, SMFreeGameSettings;

@interface SMGameModel : NSObject

@property (assign, nonatomic) CGFloat snakeStep;
@property (strong, nonatomic) NSMutableArray *takenCoordinates;
@property (strong, nonatomic) NSArray *hazardImages;

- (instancetype)initWithGridView:(SMPlayground *)gridView andGameSettings:(id)gameSettings;

- (CGPoint)generateRandomCoordinates;

// snake model

@property (strong, nonatomic) NSMutableArray *snakeArray;

- (UIView *)createSnakeView;

// hazard model

- (UIView *)createHazardView;

// meal model

- (UIView *)createMealView;


@end
