//
//  SMPlayViewController.m
//  SnakeGame
//
//  Created by Syngmaster on 20/04/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMPlayViewController.h"
#import "SMSnakeEngineModel.h"
#import "SMPlayground.h"
#import "SMGameModel.h"


@interface SMPlayViewController ()

@property (assign, nonatomic) float step;
@property (assign, nonatomic) NSTimeInterval timeInterval;

@end

@implementation SMPlayViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.step = 25;
    self.timeInterval = 0.3;
    
    if (self.gameMode == 0) {
        self.scoreLabel.text = @"-/-";
        self.scoreImage.image = [UIImage imageNamed:@"apple.png"];
        self.levelLabel.text = @"Level : ";
        
    } else {
        
        self.scoreLabel.text = @"0/20";
        self.scoreImage.image = [UIImage imageNamed:@"apple.png"];
        self.levelLabel.text = @"Level : 1";
    }

}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.timer invalidate];
    //self.timer = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(testAction) userInfo:nil repeats:true];
    
    SMSnakeEngineModel *snake = [[SMSnakeEngineModel alloc] init];
    
    [snake generateRandomHazardInView:self.playgroundView];
    [snake generateRandomMealInView:self.playgroundView];
    [snake generateSnakeInView:self.playgroundView];
    
    self.snakeEngineModel = snake;

    [self createSwipes];

}

- (void)createSwipes {
    
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
    [self.snakeEngineModel snakeNewMovement:self.snakeEngineModel.gameModel.snakeArray inView:self.playgroundView withDirectionX:SnakeDirectionOptionRight*self.step andDirectionY:0];
}

- (void)moveSnakeLeft {
    [self.snakeEngineModel snakeNewMovement:self.snakeEngineModel.gameModel.snakeArray inView:self.playgroundView withDirectionX:SnakeDirectionOptionLeft*self.step andDirectionY:0];
}

- (void)moveSnakeUp {
    [self.snakeEngineModel snakeNewMovement:self.snakeEngineModel.gameModel.snakeArray inView:self.playgroundView withDirectionX:0 andDirectionY:SnakeDirectionOptionUp*self.step];

}

- (void)moveSnakeDown {
    [self.snakeEngineModel snakeNewMovement:self.snakeEngineModel.gameModel.snakeArray inView:self.playgroundView withDirectionX:0 andDirectionY:SnakeDirectionOptionDown*self.step];
}

- (void)testAction {
    [self.snakeEngineModel generateRandomMealInView:self.playgroundView];
}

#pragma mark - Action

- (IBAction)settingAction:(UIButton *)sender {
    
    [self.timer invalidate];

    
    
}



@end
