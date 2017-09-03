//
//  SMSnakeModel.m
//  SnakeGame
//
//  Created by Syngmaster on 21/06/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMSnakeModel.h"
#import "SMViewController.h"

@interface SMSnakeModel ()

@property (assign, nonatomic) NSInteger newX;
@property (assign, nonatomic) NSInteger newY;

@property (assign, nonatomic) NSInteger snakeBodySize;
@property (assign, nonatomic) CGRect randomViewRect;

@property (assign, nonatomic) CGPoint currentPoint;

@end

@implementation SMSnakeModel


- (instancetype)initSnakeInView:(UIView *) view {
    
    self = [super init];
    if (self) {
        
        self.views = [NSMutableArray array];
        //self.playingGround = CGRectMake(0, 0, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
        
        NSInteger body = 30;
        self.snakeBodySize = body;

        NSInteger startX = body * arc4random_uniform(CGRectGetMaxX(view.bounds)/body);
        NSInteger startY = body * arc4random_uniform(CGRectGetMaxY(view.bounds)/body);
        
        NSLog(@"headView - %ld %ld", (long)startX, (long)startY);
        
        
        UIView *snakeView = [[UIView alloc] initWithFrame:CGRectMake(startX, startY, body, body)];

        snakeView.tag = SnakePartsOptionBody;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:snakeView.bounds];
        imageView.image = [UIImage imageNamed:@"snake_head.png"];
        [snakeView addSubview:imageView];

        [view addSubview:snakeView];
        [self.views addObject:snakeView];
        
    }
    return self;
}

#pragma mark - Generate random body views

- (void)generateRandomSnakeBodyInView:(UIView *) view {
    
    // generating random coordinates for a new body view
    NSInteger newX = self.snakeBodySize * arc4random_uniform(CGRectGetMaxX(view.bounds)/self.snakeBodySize);
    NSInteger newY = self.snakeBodySize * arc4random_uniform(CGRectGetMaxY(view.bounds)/self.snakeBodySize);
    
    self.newX = newX;
    self.newY = newY;
    
    NSLog(@"newBodyView - %li %li", (long)newX, (long)newY);

    
    UIView *newBodyView = [[UIView alloc] initWithFrame:CGRectMake(self.newX, self.newY, self.snakeBodySize, self.snakeBodySize)];

    newBodyView.tag = SnakePartsOptionNewSegment;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:newBodyView.bounds];
    imageView.image = [UIImage imageNamed:@"snake_body.png"];
    [newBodyView addSubview:imageView];
    
    self.randomViewRect = newBodyView.frame;
    [view addSubview:newBodyView];
    
}

- (void)addOneSegmentToSnake:(NSArray *)snake inView:(UIView *)view {
    
    UIView *lastBody = snake[[snake count]-1];
    
    UIView *newSegment = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(lastBody.frame), CGRectGetMinY(lastBody.frame), self.snakeBodySize, self.snakeBodySize)];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:newSegment.bounds];
    imageView.image = [UIImage imageNamed:@"snake_body.png"];
    
    newSegment.tag = SnakePartsOptionBody;
    [newSegment addSubview:imageView];
    [view addSubview:newSegment];
    [self.views addObject:newSegment];
    
}

#pragma mark - Moving method


/************** Method with a timer ******************/

- (void)snakeNewMovement:(NSArray *) snake inView:(UIView *)playgroundView withDirectionX:(int)directionX andDirectionY:(int)directionY {
    
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
    
    NSLog(@"head frame - %@", NSStringFromCGRect(headView.frame));
    NSLog(@"head center - %@", NSStringFromCGPoint(headView.center));
    
    for (NSInteger i = [snake count]-1; i > 0; i--) {
        
        UIView *view = snake[i-1];
        UIView *nextView = snake[i];
        
        nextView.center = view.center;
    }
    
    headView.center = CGPointMake(headView.center.x + directionX, headView.center.y + directionY );
    
    
    if (CGRectIntersectsRect(headView.frame, self.randomViewRect)) {
        
        [self addOneSegmentToSnake:snake inView:playgroundView];
        [self removeSnakeViewWithTag:SnakePartsOptionNewSegment inView:playgroundView];
        [self generateRandomSnakeBodyInView:playgroundView];
    }
    
    [self gameOverAfterIntersection:snake withHeadView:headView inView:playgroundView];
    
}


/************** Method using animations ******************/

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
                             [self removeSnakeViewWithTag:SnakePartsOptionNewSegment inView:playgroundView];
                             [self generateRandomSnakeBodyInView:playgroundView];
                         }
                         
                         
                     } completion:^(BOOL finished) {
                         
                         //adding a body view to the snake main view
                         /*if (CGRectIntersectsRect(headView.frame, self.randomViewRect)) {
                             
                             [self addOneSegmentToSnake:snake inView:playgroundView];
                             [self removeSnakeViewWithTag:SnakePartsOptionNewSegment inView:playgroundView];
                             [self generateRandomSnakeBodyInView:playgroundView];
                         }*/
                         
                         if (finished == YES) {
                             
                             //continue to animate if previous animation wasn't canceled

                             __weak SMSnakeModel* weakSelf = self;
                             [weakSelf snakeMovement:snake inView:playgroundView withDirectionX: stepX andY: stepY];
                             
                             //method checks whether a condition for intersection is satisfied
                             [self gameOverAfterIntersection:snake withHeadView:headView inView:playgroundView];

                         } else {
                             


                         }
                         
                     }];
}

#pragma mark - GameOver methods

- (void)gameOverAfterIntersection:(NSArray *) views withHeadView:(UIView *) head inView:(UIView *) playgroundView {
    
    //game stops if the head view goes beyond the playground
    if (!(CGRectContainsRect(playgroundView.bounds, head.frame))) {

        //[self gameOverAlertControllerInView:playgroundView];
        //[self removeAnimationFromViews:views];
    }
    
    //game stops if head view intersects with a body view
    for (int i = 0; i < [views count]-1; i++) {
        
        UIView *bodyView = views[i+1];
        
        if ([views count] > 2) {
            
            if (CGRectIntersectsRect(head.frame, bodyView.frame)) {
                
                [self gameOverAlertControllerInView:playgroundView];
                [self removeAnimationFromViews:views];
            }
            
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
    
    SMViewController *mainVC = (SMViewController *)[UIApplication sharedApplication].windows.firstObject.rootViewController;
    
    __weak SMViewController* weakMain = mainVC;
    [weakMain.timer invalidate];
    
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
