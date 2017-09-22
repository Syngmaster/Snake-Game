//
//  SMSnakeEngineModel.m
//  SnakeGame
//
//  Created by Syngmaster on 21/06/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMSnakeEngineModel.h"
#import "SMViewController.h"
#import "SMMealModel.h"
#import "SMHazardModel.h"
#import "SMSnakeModel.h"

@interface SMSnakeEngineModel ()

@property (assign, nonatomic) CGRect randomViewRect;
@property (assign, nonatomic) CGPoint currentPoint;

@property (strong, nonatomic) NSMutableArray *arrayOfHazards;

@end

@implementation SMSnakeEngineModel

#pragma mark - Generate random game elements

- (void)generateSnakeHeadInView:(UIView *)view {
    
    SMSnakeModel *snakeModel = [[SMSnakeModel alloc] init];
    self.snakeModel = snakeModel;

    UIView *snakeView = [snakeModel createSnakeView];
    
    [view addSubview:snakeView];
    
}


- (void)generateRandomMealInView:(UIView *)view {
    
    SMMealModel *mealModel = [[SMMealModel alloc] init];
    
    UIView *mealView = [mealModel createMealView];
    
    self.randomViewRect = mealView.frame;
    [view addSubview:mealView];
    
}

- (void)generateRandomHazardInView:(UIView *)view {
        
    NSUInteger numberOfHazards = 5 + arc4random_uniform(10);
    self.arrayOfHazards = [NSMutableArray array];
    SMHazardModel *hazardModel = [[SMHazardModel alloc] init];

    for (int i = 0; i < numberOfHazards; i++) {

        UIView *hazardView = [hazardModel createHazardView];
        
        [view addSubview:hazardView];
        [self.arrayOfHazards addObject:hazardView];

    }
    

}

- (void)addOneSegmentToSnake:(NSMutableArray *)snake inView:(UIView *)view {
    
    UIView *snakeView = [self.snakeModel createSnakeView];
    [view addSubview:snakeView];
    
}

#pragma mark - Moving method


/************** Method with a timer ******************/

- (void)snakeNewMovement:(NSMutableArray *) snake inView:(UIView *)playgroundView withDirectionX:(int)directionX andDirectionY:(int)directionY {
    
    UIView *snakeHead = snake[0];
    
    if (directionY < 0) {
        snakeHead.layer.affineTransform = CGAffineTransformMakeRotation(0);
    } else if (directionY > 0) {
        snakeHead.layer.affineTransform = CGAffineTransformMakeRotation(M_PI);
    }
    
    if (directionX < 0) {
        snakeHead.layer.affineTransform = CGAffineTransformMakeRotation(-M_PI/2);
    } else if (directionX > 0) {
        snakeHead.layer.affineTransform = CGAffineTransformMakeRotation(M_PI/2);
    }
    
    
    UIView *headView = snake[0];
    
    for (NSInteger i = [snake count]-1; i > 0; i--) {
        
        UIView *view = snake[i-1];
        UIView *nextView = snake[i];
        
        nextView.center = view.center;
    }
    
    headView.center = CGPointMake(headView.center.x + directionX, headView.center.y + directionY );
    
    
    if (CGRectIntersectsRect(headView.frame, self.randomViewRect)) {
        
        [self addOneSegmentToSnake:snake inView:playgroundView];
        [self removeGameElementWithTag:GameElementApple inView:playgroundView];
        [self generateRandomMealInView:playgroundView];
    }
    
    [self gameOverAfterIntersection:snake withHeadView:headView inView:playgroundView];
    
}


/************** Method using animations ******************/
/*
- (void)snakeMovement:(NSArray *) snake inView:(UIView *)playgroundView withDirectionX:(NSInteger) stepX andY:(NSInteger) stepY {
    
    UIView *snakeHead = snake[0];
    if (stepY == SnakeDirectionOptionUp*40) {
        snakeHead.layer.affineTransform = CGAffineTransformMakeRotation(0);
    } else if (stepY == SnakeDirectionOptionDown*40) {
        snakeHead.layer.affineTransform = CGAffineTransformMakeRotation(M_PI);
    }
    
    if (stepX == SnakeDirectionOptionLeft*40) {
        snakeHead.layer.affineTransform = CGAffineTransformMakeRotation(-M_PI/2);
    } else if (stepX == SnakeDirectionOptionRight*40) {
        snakeHead.layer.affineTransform = CGAffineTransformMakeRotation(M_PI/2);
    }
    
    
    UIView *headView = snake[0];
    //[self removeAnimationFromViews:snake];
    

    
    [UIView animateWithDuration:0.3 delay:0
                        options:  UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         for (NSInteger i = [snake count]-1; i > 0; i--) {
                             
                             UIView *view = snake[i-1];
                             UIView *nextView = snake[i];
                             
                             nextView.center = view.center;
                         }
                         
                         headView.center = CGPointMake(headView.center.x + stepX, headView.center.y + stepY);
                         
                         if (CGRectIntersectsRect(headView.frame, self.randomViewRect)) {
                             
                             [self addOneSegmentToSnake:snake inView:playgroundView];
                             [self removeSnakeViewWithTag:GameElementApple inView:playgroundView];
                             [self generateRandomSnakeBodyInView:playgroundView];
                         }
                         
                         
                     } completion:^(BOOL finished) {
                         
                         
                         if (finished == YES) {
                             
                             //continue to animate if previous animation wasn't canceled

                             __weak SMSnakeEngineModel* weakSelf = self;
                             [weakSelf snakeMovement:snake inView:playgroundView withDirectionX: stepX andY: stepY];
                             
                             //method checks whether a condition for intersection is satisfied
                             [self gameOverAfterIntersection:snake withHeadView:headView inView:playgroundView];

                         } else {
                             


                         }
                         
                     }];
}
*/

#pragma mark - GameOver methods

- (void)gameOverAfterIntersection:(NSArray *) views withHeadView:(UIView *) head inView:(UIView *) playgroundView {
    
    CGRect intersectionFrame = CGRectMake(15, 15, CGRectGetWidth(playgroundView.bounds) - 30, CGRectGetHeight(playgroundView.bounds) - 30);
    
    //game stops if the head view goes beyond the playground
    if (!(CGRectContainsRect(intersectionFrame, head.frame))) {

        [self gameOverAlertControllerInView:playgroundView];
        //[self removeAnimationFromViews:views];
    }
    
    //game stops if head view intersects with a body view
    for (int i = 1; i < [views count]-1; i++) {
        
        UIView *bodyView = views[i+1];
        
        if ([views count] > 1) {
            
            if (CGRectIntersectsRect(head.frame, bodyView.frame)) {
                
                [self gameOverAlertControllerInView:playgroundView];
                //[self removeAnimationFromViews:views];
            }
            
        }
    }
    
    for (UIView *hazardView in self.arrayOfHazards) {
        
        if (CGRectIntersectsRect(hazardView.frame, head.frame)) {

            [self gameOverAlertControllerInView:playgroundView];
        }
        
    }
    
    
    
}

/*
- (void)removeAnimationFromViews:(NSArray *) views {
    
    for (UIView* view in views) {
        
        [view.layer removeAllAnimations];
    }
}
*/

- (void)removeGameElementWithTag:(NSInteger) tag inView:(UIView *) playgroundView {
    
    NSArray *viewsToRemove = [playgroundView subviews];
    for (UIView *v in viewsToRemove) {
        
        if ([v viewWithTag:tag]) {
            
            [v removeFromSuperview];
        }
    }
}


- (void)gameOverAlertControllerInView:(UIView *) playgroundView {
    
    SMViewController *mainVC = (SMViewController *)[UIApplication sharedApplication].windows.firstObject.rootViewController;
    
    __weak SMViewController* weakMain = mainVC;
    [weakMain.timer invalidate];
    
    UIAlertController *contr = [UIAlertController alertControllerWithTitle:@"Game Over!" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ac = [UIAlertAction actionWithTitle:@"Restart Game" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [self removeGameElementWithTag:GameElementSnakeBody inView:playgroundView];
        [self removeGameElementWithTag:GameElementApple inView:playgroundView];
        [self removeGameElementWithTag:GameElementHazard inView:playgroundView];
        self.arrayOfHazards = nil;
        
        [weakMain viewDidAppear:true];
        
    }];
    [contr addAction:ac];
    
    [mainVC presentViewController:contr animated:true completion:nil];
    
}

@end
