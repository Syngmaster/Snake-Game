//
//  SMSnakeModel.h
//  SnakeGame
//
//  Created by Syngmaster on 21/06/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMSnakeModel : NSObject

@property (strong, nonatomic) NSMutableArray* views;

- (instancetype)initSnakeInView:(UIView *) view;

- (void)generateRandomSnakeBodyInView:(UIView *) view;
- (void)addOneSegmentInView:(UIView *) view;
- (void)snakeMovement:(NSArray *) snake inView:(UIView *)playgroundView withDirectionX:(CGFloat) stepX andY:(CGFloat) stepY;
- (void)removeSnakeViewWithTag:(NSInteger) tag inView:(UIView *) playgroundView;
- (void)removeAnimationFromViews:(NSArray *) views;

@end
