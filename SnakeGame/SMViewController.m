//
//  SMViewController.m
//  SnakeGame
//
//  Created by Syngmaster on 20/04/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMViewController.h"
#import "SMSnakeModel.h"
#import "SMPlayground.h"


@interface SMViewController ()

@property (assign, nonatomic) int step;
@property (strong, nonatomic) SMSnakeModel *snakeModel;
@property (strong, nonatomic) SMPlayground *playground;

@property (assign, nonatomic) NSTimeInterval timeInterval;

@end

@implementation SMViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    SMPlayground *playground = [[SMPlayground alloc] initWithView:self.view];
    [self.view addSubview:playground];
    self.playground = playground;
    self.step = 30;
    self.timeInterval = 0.25;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.timer invalidate];

    SMSnakeModel *snake = [[SMSnakeModel alloc] initSnakeInView:self.playground];
    
    [snake generateRandomSnakeBodyInView:self.playground];

    self.snakeModel = snake;
    //self.snakeModel.playingGround = self.playground.frame;
    
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

#pragma mark - Direction control buttons

- (void)swipeAction:(UISwipeGestureRecognizer *) direction {
    
    switch (direction.direction) {
            
        case UISwipeGestureRecognizerDirectionRight:
            
            [self.timer invalidate];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(moveSnakeRight) userInfo:nil repeats:true];
            break;
            
        case UISwipeGestureRecognizerDirectionLeft:
            
            [self.timer invalidate];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(moveSnakeLeft) userInfo:nil repeats:true];
            break;
            
        case UISwipeGestureRecognizerDirectionUp:
            
            [self.timer invalidate];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(moveSnakeUp) userInfo:nil repeats:true];
            break;
            
        case UISwipeGestureRecognizerDirectionDown:
            
            [self.timer invalidate];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(moveSnakeDown) userInfo:nil repeats:true];
            break;

    }
    
}

- (void)moveSnakeRight {
    [self.snakeModel snakeNewMovement:self.snakeModel.views inView:self.playground withDirectionX:SnakeDirectionOptionRight*self.step andDirectionY:0];
}

- (void)moveSnakeLeft {
    [self.snakeModel snakeNewMovement:self.snakeModel.views inView:self.playground withDirectionX:SnakeDirectionOptionLeft*self.step andDirectionY:0];
}

- (void)moveSnakeUp {
    [self.snakeModel snakeNewMovement:self.snakeModel.views inView:self.playground withDirectionX:0 andDirectionY:SnakeDirectionOptionUp*self.step];

}

- (void)moveSnakeDown {
    [self.snakeModel snakeNewMovement:self.snakeModel.views inView:self.playground withDirectionX:0 andDirectionY:SnakeDirectionOptionDown*self.step];
}

@end
