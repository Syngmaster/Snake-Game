//
//  SMPlayground.h
//  SnakeGame
//
//  Created by Syngmaster on 21/06/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SMPlayground : UIView

@property (strong, nonatomic) UIView *gridView;
@property (assign, nonatomic) CGFloat snakeStep;

- (instancetype)initWithView:(UIView *) view;

@end
