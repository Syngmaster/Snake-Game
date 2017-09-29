//
//  SMPlayViewController.h
//  SnakeGame
//
//  Created by Syngmaster on 20/04/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMSnakeEngineModel, SMFreeGameSettings, SMArcadeGameSettings;

@interface SMPlayViewController : UIViewController

@property (assign, nonatomic) NSInteger gameMode;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) SMSnakeEngineModel *snakeEngineModel;
@property (assign, nonatomic) BOOL gameIsStarted;

@property (strong, nonatomic) SMFreeGameSettings *freeGameSettings;
@property (strong, nonatomic) SMArcadeGameSettings *arcadeGameSettings;

@property (weak, nonatomic) IBOutlet UIView *playgroundView;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *scoreImage;


- (IBAction)settingAction:(UIButton *)sender;

@end

