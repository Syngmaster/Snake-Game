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
    
    if (sender.value >= 0 && sender.value < 0.25) {
        self.speedLabel.text = @"easy";
    } else if (sender.value >= 0.25 && sender.value < 0.5) {
        self.speedLabel.text = @"medium";
    } else if (sender.value >= 0.5 && sender.value < 0.75) {
        self.speedLabel.text = @"hard";
    } else {
        self.speedLabel.text = @"extreme";
    }
    
}

- (IBAction)levelValueChanged:(UISlider *)sender {
    self.gameSettings.levelValue = sender.value;
    
    if (sender.value >= 0 && sender.value < 0.25) {
        self.levelLabel.text = @"easy";
    } else if (sender.value >= 0.25 && sender.value < 0.5) {
        self.levelLabel.text = @"medium";
    } else if (sender.value >= 0.5 && sender.value < 0.75) {
        self.levelLabel.text = @"hard";
    } else {
        self.levelLabel.text = @"extreme";
    }
}

- (IBAction)startGameAction:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"startGame" sender:nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"startGame"]) {
        SMPlayViewController *dvc = segue.destinationViewController;
        dvc.freeGameSettings = self.gameSettings;
        dvc.gameMode = self.gameMode;
    }
}


@end
