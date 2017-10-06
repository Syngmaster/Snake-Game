//
//  SMSnakeEngineModel.m
//  SnakeGame
//
//  Created by Syngmaster on 21/06/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMSnakeEngineModel.h"
#import "SMPlayViewController.h"
#import "SMGameModel.h"
#import "SMFreeGameSettings.h"
#import "SMArcadeGameSettings.h"
#import "SMCustomAlertViewController.h"

@interface SMSnakeEngineModel ()

@property (assign, nonatomic) CGRect randomViewRect;
@property (assign, nonatomic) CGPoint currentPoint;
@property (strong, nonatomic) NSMutableArray *arrayOfHazards;
@property (assign, nonatomic) NSInteger numberOfHazards;

@end

@implementation SMSnakeEngineModel

#pragma mark - Generate random game elements

- (instancetype)initWithGameModel:(SMGameModel *)gameModel {
    
    self = [super init];
    if (self) {
        
        if (gameModel.freeGameSettings) {
            
            self.arrayOfHazards = [NSMutableArray array];
            self.numberOfHazards = gameModel.freeGameSettings.levelValue * 30;

        } else if (gameModel.arcadeGameSettings) {
            
            self.arrayOfHazards = [NSMutableArray array];
            self.numberOfHazards = gameModel.arcadeGameSettings.numberOfHazards;
        
        }
        
        self.gameModel = gameModel;
        
    }
    return self;
}

- (void)generateSnakeInView:(UIView *)view {
    
    UIView *snakeView = [self.gameModel createSnakeView];
    UIView *snakeTailView = [self.gameModel createSnakeView];

    [view addSubview:snakeView];
    [view addSubview:snakeTailView];
    
}


- (void)generateRandomMealInView:(UIView *)view {
    
    UIView *mealView = [self.gameModel createMealView];
    
    self.randomViewRect = mealView.frame;
    [view addSubview:mealView];
    
}

- (void)generateRandomHazardInView:(UIView *)view {
        
    NSInteger numberOfHazards = self.numberOfHazards;

    for (int i = 0; i < numberOfHazards; i++) {

        UIView *hazardView = [self.gameModel createHazardView];
        
        [view addSubview:hazardView];
        [self.arrayOfHazards addObject:hazardView];

    }

}


- (void)addOneSegmentToSnake:(NSMutableArray *)snake inView:(UIView *)view {
    
    UIView *snakeView = [self.gameModel createSnakeView];
    [view addSubview:snakeView];
    
    if (self.gameMode == 0) {
        self.gameModel.freeGameSettings.score++;
    } else {
        self.gameModel.arcadeGameSettings.score++;
    }
}

#pragma mark - Moving method

/************** Method with a timer ******************/

- (void)snakeNewMovement:(NSMutableArray *) snake inView:(UIView *)playgroundView withDirectionX:(int)directionX andDirectionY:(int)directionY {
    UIView *snakeHead = snake[0];
    CGAffineTransform currentPosition = snakeHead.layer.affineTransform;

    if (directionY < 0) {
        snakeHead.layer.affineTransform = CGAffineTransformMakeRotation(0);
    } else if (directionY > 0) {
        snakeHead.layer.affineTransform = CGAffineTransformMakeRotation(M_PI);
    } else if (directionX < 0) {
        snakeHead.layer.affineTransform = CGAffineTransformMakeRotation(-M_PI/2);
    } else if (directionX > 0) {
        snakeHead.layer.affineTransform = CGAffineTransformMakeRotation(M_PI/2);
    }
    
    
    for (NSUInteger i = [snake count]-1; i > 0; i--) {
        
        UIView *view = snake[i-1];
        UIView *nextView = snake[i];
        
        nextView.center = view.center;
        nextView.layer.affineTransform = view.layer.affineTransform;
        
    }

    snakeHead.center = CGPointMake(snakeHead.center.x + directionX, snakeHead.center.y + directionY);
    
    if (!CGAffineTransformEqualToTransform(currentPosition, snakeHead.layer.affineTransform)) {
        
        UIView *nextView = snake[1];
        nextView.layer.affineTransform = snakeHead.layer.affineTransform;
        
    }
    
    [self gameOverAfterIntersection:snake withHeadView:snakeHead inView:playgroundView];
    
    if (CGRectIntersectsRect(snakeHead.frame, self.randomViewRect)) {
        
        [self addOneSegmentToSnake:snake inView:playgroundView];
        [self removeGameElementWithTag:GameElementMeal inView:playgroundView];
        [self generateRandomMealInView:playgroundView];
    }
    
    if (self.gameMode == 1) {
        if (self.gameModel.arcadeGameSettings.score == self.gameModel.arcadeGameSettings.maxMealValue) {
            [self gameOverAlertController:AlertTypeNextLevel inView:playgroundView];
        }
    }
}


#pragma mark - GameOver methods

- (void)gameOverAfterIntersection:(NSArray *) views withHeadView:(UIView *) head inView:(UIView *) playgroundView {
    
    CGRect intersectionFrame = CGRectMake(playgroundView.bounds.origin.x-5, playgroundView.bounds.origin.y-5, playgroundView.bounds.size.width+10, playgroundView.bounds.size.height+10);
    
    //game stops if the head view goes beyond the playground
    if (!(CGRectContainsRect(intersectionFrame, head.frame))) {
        [self gameOverAlertController:AlertTypeGameOver inView:playgroundView];
        return;
    }
    
    //game stops if head view intersects with a body view
    for (int i = 1; i < [views count]-1; i++) {
        
        UIView *bodyView = views[i+1];
        
        CGRect headFrame = CGRectMake(head.frame.origin.x+1, head.frame.origin.y+1, head.frame.size.width-2, head.frame.size.height-2);
        
        if ([views count] > 1) {
            
            if (CGRectIntersectsRect(headFrame, bodyView.frame)) {
                [self gameOverAlertController:AlertTypeGameOver inView:playgroundView];
                return;
            }
        }
    }
    
    for (UIView *hazardView in self.arrayOfHazards) {
        
        CGRect headFrame = CGRectMake(head.frame.origin.x+1, head.frame.origin.y+1, head.frame.size.width-2, head.frame.size.height-2);
        
        if (CGRectIntersectsRect(hazardView.frame, headFrame)) {
            [self gameOverAlertController:AlertTypeGameOver inView:playgroundView];
            return;
        }
    }
}


- (void)removeGameElementWithTag:(NSInteger)tag inView:(UIView *)playgroundView {
    
    NSArray *viewsToRemove = [playgroundView subviews];
    for (UIView *view in viewsToRemove) {
        
        if ([view viewWithTag:tag]) {
            [view removeFromSuperview];
        }
    }
}

- (void)gameOverAlertController:(NSInteger)alertType inView:(UIView *)playgroundView {
    
    UINavigationController *rootVC = (UINavigationController *)[UIApplication sharedApplication].windows.firstObject.rootViewController;
    UIViewController *gameModeVC = rootVC.topViewController;
    SMPlayViewController *mainVC = (SMPlayViewController *)gameModeVC.presentedViewController;
    [mainVC.timer invalidate];
    mainVC.gameIsStarted = NO;
    
    [self removeGameElementWithTag:GameElementSnakeBody inView:playgroundView];
    [self removeGameElementWithTag:GameElementMeal inView:playgroundView];
    [self removeGameElementWithTag:GameElementHazard inView:playgroundView];
    [self removeGameElementWithTag:GameElementSnakeTail inView:playgroundView];
    [self.arrayOfHazards removeAllObjects];
    [self.gameModel.takenCoordinates removeAllObjects];
    [self.gameModel.snakeArray removeAllObjects];
    self.gameModel.arcadeGameSettings.score = 0;


    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    SMCustomAlertViewController *alertVC = [mainSB instantiateViewControllerWithIdentifier:@"SMCustomAlertViewController"];
    
    if (alertType == AlertTypeGameOver) {
        
        alertVC.alertTitle = @"Oops... :(";
        alertVC.alertBody = @"Game over";
        alertVC.alertType = AlertTypeGameOver;

    } else {
        
        alertVC.alertTitle = @"Congratulations!";
        alertVC.alertBody = @"The level is completed! \nTime to go to the next level!";
        alertVC.alertType = AlertTypeNextLevel;
        alertVC.level = self.gameModel.arcadeGameSettings.level;
        
        self.gameModel.arcadeGameSettings.level++;
        [self.gameModel.arcadeGameSettings increaseDifficultyWithLevel:self.gameModel.arcadeGameSettings.level];
    }
    
    [mainVC presentViewController:alertVC animated:YES completion:nil];
    
}


@end
