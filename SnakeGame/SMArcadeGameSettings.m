//
//  SMArcadeGameSettings.m
//  SnakeGame
//
//  Created by Syngmaster on 29/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMArcadeGameSettings.h"

@implementation SMArcadeGameSettings

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.level = 1;
        self.maxMealValue = 5;
        self.numberOfHazards = 0;
        self.speed = 0.3;
        self.score = 0;

    }
    return self;
}

- (void)increaseDifficultyWithLevel:(NSInteger)level {
    
    self.speed = self.speed - 0.01;
    self.numberOfHazards = self.numberOfHazards + level;
    self.maxMealValue = self.maxMealValue + 1;
    
}

@end
