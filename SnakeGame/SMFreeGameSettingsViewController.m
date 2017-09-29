//
//  SMFreeGameSettingsViewController.m
//  SnakeGame
//
//  Created by Syngmaster on 28/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMFreeGameSettingsViewController.h"
#import "SMFreeGameSettings.h"
#import "SMChooseButtonView.h"
#import "SMPlayViewController.h"

@interface SMFreeGameSettingsViewController ()

@property (strong, nonatomic) SMFreeGameSettings *gameSettings;

@end

@implementation SMFreeGameSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Free game settings";
    
    SMFreeGameSettings *gameSettings = [[SMFreeGameSettings alloc] init];
    self.gameSettings = gameSettings;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.gameSettings.chosenMeal == ChosenMealApple) {
        [self.chooseMealViews[0] selectView];
        [self.chooseMealViews[1] resetView];
    } else {
        [self.chooseMealViews[1] selectView];
        [self.chooseMealViews[0] resetView];
    }
    
    self.gameSettings.speedValue = self.speedSlider.value;
    self.gameSettings.levelValue = self.levelSlider.value;
}


#pragma mark - Actions


- (IBAction)chooseMealAction:(UIButton *)sender {
    
    if (sender.tag == 0) {
        
        self.gameSettings.chosenMeal = ChosenMealApple;
        [self.chooseMealViews[0] selectView];
        [self.chooseMealViews[1] resetView];

        
    } else {
        
        self.gameSettings.chosenMeal = ChosenMealPear;
        [self.chooseMealViews[1] selectView];
        [self.chooseMealViews[0] resetView];

    }
    
}

- (IBAction)chooseHazardAction:(UIButton *)sender {
    
    switch (sender.tag) {
        case 0:
            
            [self updateView:self.chooseHazardViews[0] andGameSettings:self.gameSettings withHazard:@(ChosenHazardSpiderNet)];
            break;
            
        case 1:
            
            [self updateView:self.chooseHazardViews[1] andGameSettings:self.gameSettings withHazard:@(ChosenHazardSpider)];
            break;
            
        case 2:
            
            [self updateView:self.chooseHazardViews[2] andGameSettings:self.gameSettings withHazard:@(ChosenHazardStone)];
            break;
            
        case 3:
            
            [self updateView:self.chooseHazardViews[3] andGameSettings:self.gameSettings withHazard:@(ChosenHazardTree)];
            break;
    }
}

- (void)updateView:(SMChooseButtonView *)view andGameSettings:(SMFreeGameSettings *)gameSettings withHazard:(NSNumber *)hazard {
    BOOL inArray = NO;

    for (NSNumber *num in gameSettings.chosenHazards) {
        if ([num isEqual:hazard]) {
            [gameSettings.chosenHazards removeObject:hazard];
            [view resetView];
            inArray = YES;
            break;
        }
    }
    
    if (!inArray) {
        [gameSettings.chosenHazards addObject:hazard];
        [view selectView];
    }
    
}

- (IBAction)speedValueChanged:(UISlider *)sender {
    
    self.gameSettings.speedValue = sender.value;
    [self updateLabel:self.speedLabel withSliderValue:sender];
    
}

- (IBAction)levelValueChanged:(UISlider *)sender {
    
    self.gameSettings.levelValue = sender.value;
    [self updateLabel:self.levelLabel withSliderValue:sender];

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

- (IBAction)startGameAction:(UIButton *)sender {
    
    if ([self.gameSettings.chosenHazards count] == 0) {
        [self showAlert];
    } else {
        [self performSegueWithIdentifier:@"startGame" sender:nil];
    }
    
    
}

- (void)showAlert {
    
    UIAlertController *contr = [UIAlertController alertControllerWithTitle:@"Warning!" message:@"Please choose at least one hazard!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ac = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    [contr addAction:ac];
    
    [self presentViewController:contr animated:YES completion:nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"startGame"]) {
        SMPlayViewController *dvc = segue.destinationViewController;
        dvc.freeGameSettings = self.gameSettings;
        dvc.gameMode = self.gameMode;
    }
}


@end
