//
//  SMSettingsViewController.m
//  SnakeGame
//
//  Created by Syngmaster on 26/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMSettingsViewController.h"
#import "SMGameModeViewController.h"
#import "SMFreeGameSettings.h"

@interface SMSettingsViewController ()

@end

@implementation SMSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (!self.gameSettings) {
        self.speedSlider.enabled = NO;
    } else {
        self.speedSlider.value = self.gameSettings.speedValue;
        [self updateLabel:self.speedLabel withSliderValue:self.speedSlider];
    }

}

- (void)updateLabel:(UILabel *)label withSliderValue:(UISlider *)slider {
    if (slider.value >= 0 && slider.value < 0.25) {
        label.text = @"easy";
    } else if (slider.value >= 0.25 && slider.value < 0.5) {
        label.text = @"medium";
    } else if (slider.value >= 0.5 && slider.value < 0.75) {
        label.text = @"hard";
    } else {
        label.text = @"extreme";
    }
}

- (IBAction)speedValueChanged:(UISlider *)sender {
    self.gameSettings.speedValue = sender.value;
    [self updateLabel:self.speedLabel withSliderValue:sender];

}


- (IBAction)resumeGameAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [self.delegate viewControllerDismissed:self withData:self.gameSettings];

    }];
    
}

- (IBAction)quitGameAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:NO completion:^{
        
        [self.delegate viewControllerDismissed:self];
        
    }];

    
}


@end
