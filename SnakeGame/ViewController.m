//
//  ViewController.m
//  SnakeGame
//
//  Created by Syngmaster on 20/04/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "ViewController.h"
#import "SMSnakeModel.h"

typedef NS_ENUM(NSInteger, SnakeDirectionOption) {
    
    SnakeDirectionOptionUp = -1,
    SnakeDirectionOptionDown = 1,
    SnakeDirectionOptionLeft = -1,
    SnakeDirectionOptionRight = 1
    
};

@interface ViewController ()

@property (assign, nonatomic) CGFloat step;
@property (strong, nonatomic) SMSnakeModel *snakeModel;

@end

@implementation ViewController

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    self.step = 20.f;
    
    SMSnakeModel *snake = [[SMSnakeModel alloc] initSnakeInView:self.view];
    
    [snake generateRandomSnakeBodyInView:self.view];

    self.snakeModel = snake;
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
}

# pragma mark - Direction control buttons

- (void)swipeAction:(UISwipeGestureRecognizer *) direction {
    
    if (direction.direction == UISwipeGestureRecognizerDirectionRight) {
        
        [self.snakeModel snakeMovement:self.snakeModel.views inView:self.view withDirectionX:SnakeDirectionOptionRight*self.step andY:0];
        
    }
    
    if (direction.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        [self.snakeModel snakeMovement:self.snakeModel.views inView:self.view withDirectionX:SnakeDirectionOptionLeft*self.step andY:0];
        
    }
    
    if (direction.direction == UISwipeGestureRecognizerDirectionUp) {
        
        [self.snakeModel snakeMovement:self.snakeModel.views inView:self.view withDirectionX:0 andY:SnakeDirectionOptionUp*self.step];
    }
    
    if (direction.direction == UISwipeGestureRecognizerDirectionDown) {
        
        [self.snakeModel snakeMovement:self.snakeModel.views inView:self.view withDirectionX:0 andY:SnakeDirectionOptionDown*self.step];
    }
    
}

@end
