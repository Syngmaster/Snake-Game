//
//  SMSnakeModel.h
//  SnakeGame
//
//  Created by Syngmaster on 20/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMGameModel.h"

@interface SMSnakeModel : SMGameModel

@property (strong, nonatomic) NSMutableArray *snakeArray;

- (UIView *)createSnakeView;

@end
