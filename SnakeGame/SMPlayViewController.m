//
//  SMPlayViewController.m
//  SnakeGame
//
//  Created by Syngmaster on 20/04/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMPlayViewController.h"
#import "SMSettingsViewController.h"
#import "SMSnakeEngineModel.h"
#import "SMPlayground.h"
#import "SMGameModel.h"

#import "SMFreeGameSettings.h"
#import "SMArcadeGameSettings.h"


@interface SMPlayViewController () <SMSettingsViewDelegate>

@property (assign, nonatomic) CGFloat step;
@property (assign, nonatomic) NSTimeInterval timeInterval;
@property (strong, nonatomic) SMPlayground *playground;
@end

@implementation SMPlayViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gameIsStarted = NO;
    [self createSwipes];

    if (self.gameMode == 0) {
        
        self.scoreLabel.text = @"0";
        
        (self.freeGameSettings.chosenMeal == ChosenMealApple) ?
        (self.scoreImage.image = [UIImage imageNamed:@"apple.png"]):
        (self.scoreImage.image = [UIImage imageNamed:@"pear.png"]);
        
        self.levelLabel.text = @"Level : ";
        self.timeInterval = (1 - self.freeGameSettings.speedValue) / 2;

    } else {
        
        self.timeInterval = self.arcadeGameSettings.speed;
        
        self.scoreLabel.text = [NSString stringWithFormat:@"0/%i",(int)self.arcadeGameSettings.maxMealValue];
        self.scoreImage.image = [UIImage imageNamed:@"apple.png"];
    }

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!self.gameIsStarted) {
        
        SMPlayground *playground = [[SMPlayground alloc] initWithView:self.playgroundView];
        self.playground = playground;
        
        if (self.gameMode == 0) {
            
            SMSnakeEngineModel *snake = [[SMSnakeEngineModel alloc] initWithGridView:self.playground andGameSettings:self.freeGameSettings];
            self.snakeEngineModel = snake;
            
        } else {
            
            SMSnakeEngineModel *snake = [[SMSnakeEngineModel alloc] initWithGridView:self.playground andGameSettings:self.arcadeGameSettings];
            self.snakeEngineModel = snake;

            self.levelLabel.text = [NSString stringWithFormat:@"Level : %i",(int)self.arcadeGameSettings.level];

        }
        
        self.snakeEngineModel.gameMode = self.gameMode;
        self.step = self.playground.snakeStep;
        [self.timer invalidate];
        //self.timer = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(testAction) userInfo:nil repeats:true];
        self.gameIsStarted = YES;
        
        [self.snakeEngineModel generateRandomHazardInView:self.playground.gridView];
        [self.snakeEngineModel generateRandomMealInView:self.playground.gridView];
        [self.snakeEngineModel generateSnakeInView:self.playground.gridView];

    }
    
    [self updateScoreLabel:self.scoreLabel];

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

- (void)updateScoreLabel:(UILabel *)scoreLabel {
    
    if (self.gameMode == 0) {
        scoreLabel.text = [NSString stringWithFormat:@"%i", (int)[self.snakeEngineModel.gameModel.snakeArray count] - 2];
    } else {
        scoreLabel.text = [NSString stringWithFormat:@"%i/%i", (int)[self.snakeEngineModel.gameModel.snakeArray count] - 2, (int)self.arcadeGameSettings.maxMealValue];
    }

}


- (void)moveSnakeRight {
    [self updateScoreLabel:self.scoreLabel];

    [self.snakeEngineModel snakeNewMovement:self.snakeEngineModel.gameModel.snakeArray inView:self.playground.gridView withDirectionX:SnakeDirectionOptionRight*self.step andDirectionY:0];
}

- (void)moveSnakeLeft {
    [self updateScoreLabel:self.scoreLabel];

    [self.snakeEngineModel snakeNewMovement:self.snakeEngineModel.gameModel.snakeArray inView:self.playground.gridView withDirectionX:SnakeDirectionOptionLeft*self.step andDirectionY:0];
}

- (void)moveSnakeUp {
    [self updateScoreLabel:self.scoreLabel];
    [self.snakeEngineModel snakeNewMovement:self.snakeEngineModel.gameModel.snakeArray inView:self.playground.gridView withDirectionX:0 andDirectionY:SnakeDirectionOptionUp*self.step];

}

- (void)moveSnakeDown {
    [self updateScoreLabel:self.scoreLabel];
    [self.snakeEngineModel snakeNewMovement:self.snakeEngineModel.gameModel.snakeArray inView:self.playground.gridView withDirectionX:0 andDirectionY:SnakeDirectionOptionDown*self.step];
}

- (void)testAction {
    [self.snakeEngineModel generateRandomMealInView:self.playground.gridView];
}

#pragma mark - Action

- (IBAction)settingAction:(UIButton *)sender {
    
    SMSettingsViewController *settingsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMSettingsViewController"];
    settingsVC.delegate = self;
    settingsVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    settingsVC.gameSettings = self.freeGameSettings;
    [self.timer invalidate];
    [self presentViewController:settingsVC animated:YES completion:nil];

}

#pragma mark - SMSettingsViewDelegate

- (void)viewControllerDismissed:(SMSettingsViewController *)viewController withData:(SMFreeGameSettings *)settings {
    
    if (self.gameMode == 0) {
        self.timeInterval = (1 - settings.speedValue) / 2;
    }

}

- (void)viewControllerDismissed:(SMSettingsViewController *)viewController {
    [self dismissViewControllerAnimated:NO completion:nil];
}



@end
