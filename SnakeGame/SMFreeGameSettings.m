//
//  SMFreeGameSettings.m
//  SnakeGame
//
//  Created by Syngmaster on 29/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMFreeGameSettings.h"

@implementation SMFreeGameSettings

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.chosenHazards = [NSMutableArray array];
        self.score = 0;
        self.chosenMeal = ChosenMealApple;
    }
    return self;
}

@end
