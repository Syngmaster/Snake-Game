//
//  SMPlayground.m
//  SnakeGame
//
//  Created by Syngmaster on 21/06/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMPlayground.h"
#import "SMFreeGameSettings.h"
#import "SMArcadeGameSettings.h"

@interface SMPlayground ()

@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;



@end

@implementation SMPlayground

- (instancetype)initWithView:(UIView *) view andGameSettings:(id)gameSettings {
    
    self = [super init];
    if (self) {
        
        switch ((int)[UIScreen mainScreen].bounds.size.width) {
         
            case 320:
                self.height = 462; //step = 22
                self.width = 264;
                self.snakeStep = 22;
                break;
                
            case 375:
                self.height = 552; // step = 24
                self.width = 312;
                self.snakeStep = 24;
                break;
         
            case 414:
                self.height = 625; //step = 25
                self.width = 350;
                self.snakeStep = 25;
                break;
                
            case 768:
                self.height = 875; //step = 35
                self.width = 665;
                self.snakeStep = 35;
                break;
                
            case 834:
                self.height = 950; //step = 38
                self.width = 722;
                self.snakeStep = 38;
                break;
                
            case 1024:
                self.height = 1188; //step = 44
                self.width = 880;
                self.snakeStep = 44;
                break;
         
         }

        UIView *playView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        CGPoint centerView = CGPointMake(view.center.x, view.center.y);
        playView.center = centerView;
        playView.backgroundColor = [UIColor clearColor];
        [view addSubview:playView];
        self.gridView = playView;
        
        self.takenCoordinates = [NSMutableArray array];
        self.snakeArray = [NSMutableArray array];
        
        if ([gameSettings isMemberOfClass:[SMFreeGameSettings class]]) {
            
            self.freeGameSettings = (SMFreeGameSettings *)gameSettings;
            
            NSMutableArray *arrayOfImages = [NSMutableArray array];
            
            for (NSNumber *num in self.freeGameSettings.chosenHazards) {
                if ([num isEqual:@(ChosenHazardSpiderNet)]) {
                    [arrayOfImages addObject:[UIImage imageNamed:@"spider2"]];
                } else if ([num isEqual:@(ChosenHazardSpider)]) {
                    [arrayOfImages addObject:[UIImage imageNamed:@"spider"]];
                } else if ([num isEqual:@(ChosenHazardStone)]) {
                    [arrayOfImages addObject:[UIImage imageNamed:@"stone2"]];
                } else {
                    [arrayOfImages addObject:[UIImage imageNamed:@"tree2"]];
                }
            }
            
            self.hazardImages = arrayOfImages;
            
        } else {
            self.arcadeGameSettings = (SMArcadeGameSettings *)gameSettings;
        }
        
        
    }
    
    return self;
}

- (CGPoint)generateRandomCoordinates {
    
    CGFloat newX = self.snakeStep * arc4random_uniform((CGRectGetMaxX(self.gridView.bounds))/self.snakeStep);
    CGFloat newY = self.snakeStep * arc4random_uniform((CGRectGetMaxY(self.gridView.bounds))/self.snakeStep);
    
    CGPoint newPoint = CGPointMake(newX, newY);
    
    if ([self.takenCoordinates count] > 0) {
        
        for (NSValue *coord in self.takenCoordinates) {
            
            if (CGPointEqualToPoint(coord.CGPointValue, newPoint)) {
                
                return [self generateRandomCoordinates];
            }
        }
    }
    
    [self.takenCoordinates addObject:[NSValue valueWithCGPoint:newPoint]];
    
    return newPoint;
    
}

- (UIView *)createSnakeView {
    
    if ([self.snakeArray count] == 0) {
        
        CGPoint snakeCoordinates = [self generateRandomCoordinates];
        
        UIView *snakeView = [[UIView alloc] initWithFrame:CGRectMake(snakeCoordinates.x, snakeCoordinates.y, self.snakeStep, self.snakeStep)];
        snakeView.tag = GameElementSnakeBody;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:snakeView.bounds];
        imageView.image = [UIImage imageNamed:@"snake_head_new.png"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [snakeView addSubview:imageView];
        [self.snakeArray addObject:snakeView];
        
        return snakeView;
        
    } else if ([self.snakeArray count] == 1) {
        
        UIView *lastBody = self.snakeArray[[self.snakeArray count]-1];
        
        UIView *snakeView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(lastBody.frame), CGRectGetMinY(lastBody.frame) + self.snakeStep, self.snakeStep, self.snakeStep)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:snakeView.bounds];
        imageView.image = [UIImage imageNamed:@"snake_tail_new.png"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        snakeView.tag = GameElementSnakeTail;
        [snakeView addSubview:imageView];
        [self.snakeArray addObject:snakeView];
        
        return snakeView;
        
    } else {
        
        UIView *lastBody = self.snakeArray[1];
        
        UIView *snakeView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(lastBody.frame), CGRectGetMinY(lastBody.frame), self.snakeStep, self.snakeStep)];
        snakeView.layer.affineTransform = lastBody.layer.affineTransform;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:snakeView.bounds];
        
        UIImage *body1 = [UIImage imageNamed:@"snake_body_new.png"];
        UIImage *body2 = [UIImage imageNamed:@"snake_body_new2.png"];
        UIImage *body3 = [UIImage imageNamed:@"snake_body_new3.png"];
        
        NSUInteger i = 0 + rand()%3;
        
        switch (i) {
            case 0:imageView.image = body1;
                break;
            case 1:imageView.image = body2;
                break;
            case 2:imageView.image = body3;
                break;
        }
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        snakeView.tag = GameElementSnakeBody;
        [snakeView addSubview:imageView];
        [self.snakeArray insertObject:snakeView atIndex:1];
        
        return snakeView;
    }
}

- (UIView *)createHazardView {
    
    CGPoint newCoordinates = [self generateRandomCoordinates];
    
    UIView *newHazardView = [[UIView alloc] initWithFrame:CGRectMake(newCoordinates.x, newCoordinates.y, self.snakeStep, self.snakeStep)];
    
    newHazardView.tag = GameElementHazard;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:newHazardView.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    if (self.freeGameSettings) {
        
        NSInteger num = arc4random_uniform((int)[self.hazardImages count]);
        imageView.image = self.hazardImages[num];
        
    } else {
        
        UIImage *image1 = [UIImage imageNamed:@"spider2.png"];
        UIImage *image2 = [UIImage imageNamed:@"stone2.png"];
        UIImage *image3 = [UIImage imageNamed:@"tree2.png"];
        
        NSInteger i = arc4random_uniform(3);
        
        switch (i) {
            case 0: imageView.image = image1;
                break;
            case 1: imageView.image = image2;
                break;
            case 2: imageView.image = image3;
                break;
            default: imageView.image = image1;
                break;
                
        }
    }
    
    [newHazardView addSubview:imageView];
    
    return newHazardView;
}


- (UIView *)createMealView {
    
    CGPoint newCoordinates = [self generateRandomCoordinates];
    
    UIView *newMealView = [[UIView alloc] initWithFrame:CGRectMake(newCoordinates.x, newCoordinates.y, self.snakeStep, self.snakeStep)];
    
    newMealView.tag = GameElementMeal;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:newMealView.bounds];
    
    (self.freeGameSettings.chosenMeal == 0) ? (imageView.image = [UIImage imageNamed:@"apple.png"]):
    (imageView.image = [UIImage imageNamed:@"pear.png"]);
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [newMealView addSubview:imageView];
    
    return newMealView;
}


@end
