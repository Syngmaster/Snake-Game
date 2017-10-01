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
        self.maxMealValue = 2;
        self.numberOfHazards = 0;
        self.speed = 0.4;
        self.score = 0;

    }
    return self;
}

- (void)increaseDifficultyWithLevel:(NSInteger)level {
    
    self.speed = self.speed - 0.01;
    self.numberOfHazards = self.numberOfHazards + 2*level/3;
    self.maxMealValue = self.maxMealValue + 1;
    
}

@end
