//
//  SMSnakeModel.m
//  SnakeGame
//
//  Created by Syngmaster on 21/06/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMSnakeModel.h"

typedef NS_ENUM(NSInteger, SnakePartsOption) {
    
    SnakePartsOptionBody = 1,
    SnakePartsOptionNewSegment
    
};

@interface SMSnakeModel ()

@property (assign, nonatomic) CGFloat newX;
@property (assign, nonatomic) CGFloat newY;

@property (assign, nonatomic) CGFloat snakeBodySize;
@property (assign, nonatomic) CGRect playingGround;
@property (assign, nonatomic) CGRect randomViewRect;

@end

@implementation SMSnakeModel


- (instancetype)initSnakeInView:(UIView *) view {
    
    self = [super init];
    if (self) {
        
        self.views = [NSMutableArray array];
        self.playingGround = CGRectMake(0, 0, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
        
        CGFloat body = 20.f;
        self.snakeBodySize = body;

        CGFloat startX = body * arc4random_uniform(CGRectGetMaxX(view.bounds)/body);
        CGFloat startY = body * arc4random_uniform(CGRectGetMaxY(view.bounds)/body);
        
        UIView *snakeView = [[UIView alloc] initWithFrame:CGRectMake(startX, startY, body, body)];
        snakeView.backgroundColor = [UIColor clearColor];
        snakeView.layer.borderColor = [UIColor blackColor].CGColor;
        snakeView.layer.borderWidth = 1.0;
        snakeView.tag = SnakePartsOptionBody;
        
        [view addSubview:snakeView];
        [self.views addObject:snakeView];
        
    }
    return self;
}

#pragma mark - Generate random body views

- (void)generateRandomSnakeBodyInView:(UIView *) view {
    
    // generating random coordinates for a new body view
    CGFloat newX = self.snakeBodySize * arc4random_uniform(CGRectGetMaxX(view.bounds)/self.snakeBodySize);
    CGFloat newY = self.snakeBodySize * arc4random_uniform(CGRectGetMaxY(view.bounds)/self.snakeBodySize);
    
    self.newX = newX;
    self.newY = newY;
    
    UIView *newBodyView = [[UIView alloc] initWithFrame:CGRectMake(self.newX, self.newY, self.snakeBodySize, self.snakeBodySize)];
    newBodyView.backgroundColor = [UIColor grayColor];
    newBodyView.layer.borderColor = [UIColor blackColor].CGColor;
    newBodyView.layer.borderWidth = 1.0;
    newBodyView.tag = SnakePartsOptionNewSegment;
    self.randomViewRect = newBodyView.frame;
    [view addSubview:newBodyView];
    
}

- (void)addOneSegmentInView:(UIView *) view {
    
    UIView *newSegment = [[UIView alloc] initWithFrame:CGRectMake(self.newX, self.newY, self.snakeBodySize, self.snakeBodySize)];
    newSegment.backgroundColor = [UIColor grayColor];
    newSegment.layer.borderColor = [UIColor blackColor].CGColor;
    newSegment.layer.borderWidth = 1.0;
    newSegment.tag = SnakePartsOptionBody;
    [view addSubview:newSegment];
    [self.views addObject:newSegment];
    
}

#pragma mark - Moving method

- (void)snakeMovement:(NSArray *) snake inView:(UIView *)playgroundView withDirectionX:(CGFloat) stepX andY:(CGFloat) stepY {
    
    UIView *headView = snake[0];
    [self removeAnimationFromViews:snake];
    
    [UIView animateWithDuration:0.3 delay:0
                        options: UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         for (NSInteger i = [snake count]-1; i > 0; i--) {
                             
                             UIView *view = snake[i-1];
                             UIView *nextView = snake[i];
                             
                             nextView.center = view.center;
                         }
                         
                         headView.center = CGPointMake(headView.center.x + stepX, headView.center.y + stepY);
                         
                     } completion:^(BOOL finished) {
                         
                         //adding a body view to the snake main view
                         if (CGRectIntersectsRect(headView.frame, self.randomViewRect)) {
                             
                             [self addOneSegmentInView:playgroundView];
                             [self removeSnakeViewWithTag:SnakePartsOptionNewSegment inView:playgroundView];
                             [self generateRandomSnakeBodyInView:playgroundView];
                         }
                         
                         if (finished == YES) {
                             
                             //continue to animate if previous animation wasn't canceled

                             __weak SMSnakeModel* weakSelf = self;
                             //[weakSelf snakeMoving:views withDirectionX:stepX andY:stepY];
                             [weakSelf snakeMovement:snake inView:playgroundView withDirectionX: stepX andY: stepY];
                             
                             //method checks whether a condition for intersection is satisfied
                             [self gameOverAfterIntersection:snake withHeadView:headView inView:playgroundView];
                             
                         }
                         
                     }];
}

#pragma mark - GameOver methods

- (void)gameOverAfterIntersection:(NSArray *) views withHeadView:(UIView *) head inView:(UIView *) playgroundView {
    
    //game stops if the head view goes beyond the playground
    if (!(CGRectContainsRect(self.playingGround, head.frame))) {
        
        [self gameOverAlertControllerInView:playgroundView];
        [self removeAnimationFromViews:views];
    }
    
    //game stops if head view intersects with a body view
    for (int i = 0; i < [views count]-1; i++) {
        
        UIView *bodyView = views[i+1];
        
        if (CGRectIntersectsRect(head.frame, bodyView.frame)) {
            
            [self gameOverAlertControllerInView:playgroundView];
            [self removeAnimationFromViews:views];
        }
    }
}

- (void)removeAnimationFromViews:(NSArray *) views {
    
    for (UIView* view in views) {
        
        [view.layer removeAllAnimations];
    }
}


- (void)removeSnakeViewWithTag:(NSInteger) tag inView:(UIView *) playgroundView {
    
    NSArray *viewsToRemove = [playgroundView subviews];
    for (UIView *v in viewsToRemove) {
        
        if ([v viewWithTag:tag]) {
            
            [v removeFromSuperview];
        }
    }
}


- (void)gameOverAlertControllerInView:(UIView *) playgroundView {
    
    UIViewController *mainVC = [UIApplication sharedApplication].windows.firstObject.rootViewController;
    
    __weak UIViewController* weakMain = mainVC;
    
    UIAlertController *contr = [UIAlertController alertControllerWithTitle:@"Game Over!" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ac = [UIAlertAction actionWithTitle:@"Restart Game" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [self removeSnakeViewWithTag:SnakePartsOptionBody inView:playgroundView];
        [self removeSnakeViewWithTag:SnakePartsOptionNewSegment inView:playgroundView];
        [weakMain viewDidAppear:true];
        //[self dismissViewControllerAnimated:YES completion:NULL];
        
    }];
    [contr addAction:ac];
    
    [mainVC presentViewController:contr animated:true completion:nil];
    
}

@end
