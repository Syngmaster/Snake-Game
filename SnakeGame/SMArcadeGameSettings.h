//
//  SMArcadeGameSettings.h
//  SnakeGame
//
//  Created by Syngmaster on 29/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMArcadeGameSettings : NSObject

@property (assign, nonatomic) NSInteger level;
@property (assign, nonatomic) NSInteger maxMealValue;
@property (assign, nonatomic) NSInteger numberOfHazards;
@property (assign, nonatomic) NSInteger score;
@property (assign, nonatomic) float speed;

- (void)increaseDifficultyWithLevel:(NSInteger)level;

@end
