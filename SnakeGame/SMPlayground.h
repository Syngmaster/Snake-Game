//
//  SMPlayground.h
//  SnakeGame
//
//  Created by Syngmaster on 21/06/2017.
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

@class SMFreeGameSettings, SMArcadeGameSettings;

@interface SMPlayground : UIView

@property (strong, nonatomic) UIView *gridView;
@property (assign, nonatomic) CGFloat snakeStep;

@property (strong, nonatomic) NSMutableArray *takenCoordinates;
@property (strong, nonatomic) NSArray *hazardImages;

@property (strong, nonatomic) SMFreeGameSettings *freeGameSettings;
@property (strong, nonatomic) SMArcadeGameSettings *arcadeGameSettings;

- (instancetype)initWithView:(UIView *) view andGameSettings:(id)gameSettings;

- (CGPoint)generateRandomCoordinates;

// snake model

@property (strong, nonatomic) NSMutableArray *snakeArray;

- (UIView *)createSnakeView;

// hazard model

- (UIView *)createHazardView;

// meal model

- (UIView *)createMealView;


@end
