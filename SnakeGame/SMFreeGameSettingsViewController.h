//
//  SMFreeGameSettingsViewController.h
//  SnakeGame
//
//  Created by Syngmaster on 28/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMChooseButtonView;
@interface SMFreeGameSettingsViewController : UIViewController

@property (assign, nonatomic) NSInteger gameMode;

@property (strong, nonatomic) IBOutletCollection(SMChooseButtonView) NSArray *chooseMealViews;
@property (strong, nonatomic) IBOutletCollection(SMChooseButtonView) NSArray *chooseHazardViews;

- (IBAction)chooseMealAction:(UIButton *)sender;
- (IBAction)chooseHazardAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
- (IBAction)speedValueChanged:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;

@property (weak, nonatomic) IBOutlet UISlider *levelSlider;
- (IBAction)levelValueChanged:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;

- (IBAction)startGameAction:(UIButton *)sender;

@end
