//
//  SMGameModeViewController.h
//  SnakeGame
//
//  Created by Syngmaster on 26/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GameMode) {
    
    GameModeFreeGame,
    GameModeArcadeGame
    
};

@interface SMGameModeViewController : UIViewController

- (IBAction)gameModeAction:(UIButton *)sender;

@end
