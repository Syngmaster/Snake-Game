//
//  SMPlayViewController.h
//  SnakeGame
//
//  Created by Syngmaster on 20/04/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMSnakeEngineModel;

@interface SMPlayViewController : UIViewController

@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) SMSnakeEngineModel *snakeEngineModel;

@end

