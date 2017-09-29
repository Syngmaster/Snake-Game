//
//  SMFreeGameSettings.h
//  SnakeGame
//
//  Created by Syngmaster on 29/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ChosenMeal) {
    ChosenMealApple,
    ChosenMealPear
};

typedef NS_ENUM(NSInteger, ChosenHazard) {
    ChosenHazardSpiderNet,
    ChosenHazardSpider,
    ChosenHazardStone,
    ChosenHazardTree
};

@interface SMFreeGameSettings : NSObject

@property (assign, nonatomic) NSInteger chosenMeal;
@property (strong, nonatomic) NSMutableArray *chosenHazards;

@property (assign, nonatomic) float speedValue;
@property (assign, nonatomic) float levelValue;

@end
