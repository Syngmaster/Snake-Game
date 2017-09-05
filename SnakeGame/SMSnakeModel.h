//
//  SMSnakeModel.h
//  SnakeGame
//
//  Created by Syngmaster on 21/06/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SnakeDirectionOption) {
    
    SnakeDirectionOptionUp = -1,
    SnakeDirectionOptionDown = 1,
    SnakeDirectionOptionLeft = -1,
    SnakeDirectionOptionRight = 1
    
};

typedef NS_ENUM(NSInteger, SnakePartsOption) {
    
    SnakePartsOptionBody = 1,
    SnakePartsOptionApple
    
};

@interface SMSnakeModel : NSObject

@property (strong, nonatomic) NSMutableArray* views;
@property (assign, nonatomic) CGRect playingGround;

- (instancetype)initSnakeInView:(UIView *) view;

- (void)generateRandomSnakeBodyInView:(UIView *) view;

/************** Method with a timer ******************/

- (void)snakeNewMovement:(NSArray *)snake inView:(UIView *)playgroundView withDirectionX:(int)directionX andDirectionY:(int)directionY;

/************** Method using animations ******************/

- (void)snakeMovement:(NSArray *) snake inView:(UIView *)playgroundView withDirectionX:(NSInteger) stepX andY:(NSInteger) stepY;


@end
