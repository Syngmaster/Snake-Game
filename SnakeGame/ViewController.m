//
//  ViewController.m
//  SnakeGame
//
//  Created by Syngmaster on 20/04/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "ViewController.h"

const CGFloat bodySize = 20.f;

typedef NS_ENUM(NSInteger, SnakePartsOption) {
    
    SnakePartsOptionBody = 1,
    SnakePartsOptionNewSegment
    
};

typedef NS_ENUM(NSInteger, SnakeDirectionOption) {
    
    SnakeDirectionOptionUp = -1,
    SnakeDirectionOptionDown = 1,
    SnakeDirectionOptionLeft = -1,
    SnakeDirectionOptionRight = 1
    
};

@interface ViewController ()

@property (assign, nonatomic) CGFloat step;
//@property (assign, nonatomic) CGFloat rectSize;

@property (assign, nonatomic) CGRect randomViewRect;

@property (assign, nonatomic) CGFloat newX;
@property (assign, nonatomic) CGFloat newY;

@property (assign, nonatomic) CGRect playingGround;

@property (strong, nonatomic) NSMutableArray* views;


@end

@implementation ViewController

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    self.views = [NSMutableArray array];
    self.step = bodySize;
    self.playingGround = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    
    // generating random coordinates for a start point
    CGFloat startX = bodySize * arc4random_uniform(CGRectGetMaxX(self.view.bounds)/bodySize);
    CGFloat startY = bodySize * arc4random_uniform(CGRectGetMaxY(self.view.bounds)/bodySize);

    // creating a main view of the snake
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(startX, startY, bodySize, bodySize)];
    view.backgroundColor = [UIColor clearColor];
    view.layer.borderColor = [UIColor blackColor].CGColor;
    view.layer.borderWidth = 1.0;
    view.tag = SnakePartsOptionBody;
    [self.view addSubview:view];
    [self.views addObject:view];
    
    [self generateRandomBodyView];
    [self enableAllButtons];
    
}

#pragma mark - Moving method

- (void)snakeMoving:(NSArray *) views withDirectionX:(CGFloat) stepX andY:(CGFloat) stepY {
    
    UIView *headView = views[0];
    
    [UIView animateWithDuration:0.3 delay:0
                        options: UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         for (NSInteger i = [views count]-1; i > 0; i--) {
                             
                             UIView *view = views[i-1];
                             UIView *nextView = views[i];
                             
                             nextView.center = view.center;
                         }
                         
                        headView.center = CGPointMake(headView.center.x + stepX, headView.center.y + stepY);
                         
                     } completion:^(BOOL finished) {
                         
                         //adding a body view to the snake main view
                         if (CGRectIntersectsRect(headView.frame, self.randomViewRect)) {
                             
                             [self addOneSegment];
                             [self removeSnakeViewWithTag:SnakePartsOptionNewSegment];
                             [self generateRandomBodyView];
                         }
                         
                         if (finished == YES) {
                             
                             //continue to animate if previous animation wasn't canceled
                             __weak ViewController* weakSelf = self;
                            [weakSelf snakeMoving:views withDirectionX:stepX andY:stepY];
                             
                             //method checks whether a condition for intersection is satisfied
                             [self gameOverAfterIntersection:views withHeadView:headView];

                         }
                         
                     }];
}

#pragma mark - Generate random body views

- (void)generateRandomBodyView {
    
    // generating random coordinates for a new body view
    CGFloat newX = bodySize * arc4random_uniform(CGRectGetMaxX(self.view.bounds)/bodySize);
    CGFloat newY = bodySize * arc4random_uniform(CGRectGetMaxY(self.view.bounds)/bodySize);
    
    self.newX = newX;
    self.newY = newY;
    
    UIView *newBodyView = [[UIView alloc] initWithFrame:CGRectMake(self.newX, self.newY, bodySize, bodySize)];
    newBodyView.backgroundColor = [UIColor grayColor];
    newBodyView.layer.borderColor = [UIColor blackColor].CGColor;
    newBodyView.layer.borderWidth = 1.0;
    newBodyView.tag = SnakePartsOptionNewSegment;
    self.randomViewRect = newBodyView.frame;
    [self.view addSubview:newBodyView];
    
}

- (void)addOneSegment {
    
    UIView *newSegment = [[UIView alloc] initWithFrame:CGRectMake(self.newX, self.newY, bodySize, bodySize)];
    newSegment.backgroundColor = [UIColor grayColor];
    newSegment.layer.borderColor = [UIColor blackColor].CGColor;
    newSegment.layer.borderWidth = 1.0;
    newSegment.tag = SnakePartsOptionBody;
    [self.view addSubview:newSegment];
    [self.views addObject:newSegment];

}


#pragma mark - GameOver methods

- (void)gameOverAfterIntersection:(NSArray *) views withHeadView:(UIView *) head {
    
    //game stops if the head view goes beyond the playground
    if (!(CGRectContainsRect(self.playingGround, head.frame))) {
        
        [self gameOverAlertController];
        [self removeAnimationFromViews:views];
    }
    
    //game stops if head view intersects with a body view
    for (int i = 0; i < [views count]-1; i++) {
        
        UIView *bodyView = views[i+1];
        
        if (CGRectIntersectsRect(head.frame, bodyView.frame)) {
            
            [self gameOverAlertController];
            [self removeAnimationFromViews:views];
        }
    }
}


- (void)removeAnimationFromViews:(NSArray *) views {
    
    for (UIView* view in views) {
        
        [view.layer removeAllAnimations];
    }
}


- (void)removeSnakeViewWithTag:(NSInteger) tag {
    
    NSArray *viewsToRemove = [self.view subviews];
    for (UIView *v in viewsToRemove) {
        
        if ([v viewWithTag:tag]) {
            
            [v removeFromSuperview];
        }
    }
}


- (void)gameOverAlertController {
    
    UIAlertController *contr = [UIAlertController alertControllerWithTitle:@"Game Over!" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ac = [UIAlertAction actionWithTitle:@"Restart Game" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [self removeSnakeViewWithTag:SnakePartsOptionBody];
        [self removeSnakeViewWithTag:SnakePartsOptionNewSegment];
        [self viewDidAppear:true];
        //[self dismissViewControllerAnimated:YES completion:NULL];
        
    }];
    [contr addAction:ac];
    
    [self presentViewController:contr animated:true completion:nil];
    
}


# pragma mark - Direction control buttons


- (void)enableAllButtons {
    
    self.leftButton.enabled = YES;
    self.rightButton.enabled = YES;
    self.topButton.enabled = YES;
    self.bottomButton.enabled = YES;
    
}


- (IBAction)moveLeft:(UIButton *)sender {
    
    self.leftButton.enabled = NO;
    self.rightButton.enabled = NO;
    self.topButton.enabled = YES;
    self.bottomButton.enabled = YES;

    [self removeAnimationFromViews:self.views];
    [self snakeMoving:self.views withDirectionX:SnakeDirectionOptionLeft*self.step andY:0];
    
}

- (IBAction)moveRight:(UIButton *)sender {

    self.rightButton.enabled = NO;
    self.leftButton.enabled = NO;
    self.topButton.enabled = YES;
    self.bottomButton.enabled = YES;


    [self removeAnimationFromViews:self.views];
    [self snakeMoving:self.views withDirectionX:SnakeDirectionOptionRight*self.step andY:0];

}

- (IBAction)moveUp:(UIButton *)sender {
    
    self.topButton.enabled = NO;
    self.bottomButton.enabled = NO;
    self.leftButton.enabled = YES;
    self.rightButton.enabled = YES;


    [self removeAnimationFromViews:self.views];
    [self snakeMoving:self.views withDirectionX:0 andY:SnakeDirectionOptionUp*self.step];

}

- (IBAction)moveDown:(UIButton *)sender {
    
    self.bottomButton.enabled = NO;
    self.topButton.enabled = NO;
    self.leftButton.enabled = YES;
    self.rightButton.enabled = YES;
    
    
    [self removeAnimationFromViews:self.views];
    [self snakeMoving:self.views withDirectionX:0 andY:SnakeDirectionOptionDown*self.step];

}


@end
