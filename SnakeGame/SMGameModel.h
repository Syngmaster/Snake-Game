//
//  SMGameModel.h
//  SnakeGame
//
//  Created by Syngmaster on 20/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SNAKE_STEP_IPHONE 25;
#define SNAKE_STEP_IPHONE_PLUS 30;

@interface SMGameModel : NSObject

@property (assign, nonatomic) CGFloat snakeStep;

@end
