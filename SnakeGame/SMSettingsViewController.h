//
//  SMSettingsViewController.h
//  SnakeGame
//
//  Created by Syngmaster on 26/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMSettingsViewController;

@protocol SMSettingsViewDelegate <NSObject>

- (void)viewControllerDismissed:(SMSettingsViewController *)viewController;

@end

@interface SMSettingsViewController : UIViewController

@property (weak, nonatomic) id <SMSettingsViewDelegate> delegate;

- (IBAction)resumeGameAction:(UIButton *)sender;
- (IBAction)quitGameAction:(UIButton *)sender;

@end
