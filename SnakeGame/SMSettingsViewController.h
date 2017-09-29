//
//  SMSettingsViewController.h
//  SnakeGame
//
//  Created by Syngmaster on 26/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMSettingsViewController, SMFreeGameSettings;

@protocol SMSettingsViewDelegate <NSObject>

- (void)viewControllerDismissed:(SMSettingsViewController *)viewController;
- (void)viewControllerDismissed:(SMSettingsViewController *)viewController withData:(SMFreeGameSettings *)settings;

@end

@interface SMSettingsViewController : UIViewController

@property (weak, nonatomic) id <SMSettingsViewDelegate> delegate;
@property (strong, nonatomic) SMFreeGameSettings *gameSettings;

@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
- (IBAction)speedValueChanged:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;


- (IBAction)resumeGameAction:(UIButton *)sender;
- (IBAction)quitGameAction:(UIButton *)sender;

@end
