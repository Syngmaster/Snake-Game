//
//  SMGameModeViewController.m
//  SnakeGame
//
//  Created by Syngmaster on 26/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMGameModeViewController.h"
#import "SMPlayViewController.h"
#import "SMFreeGameSettingsViewController.h"
#import "SMArcadeGameSettings.h"

@interface SMGameModeViewController ()

@property (assign, nonatomic) NSInteger gameMode;

@end

@implementation SMGameModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem.title=@"";
    self.navigationItem.title = @"Choose your game";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"game"]) {
        
        SMPlayViewController *dvc = segue.destinationViewController;
        dvc.gameMode = self.gameMode;
        
    } else if ([segue.identifier isEqualToString:@"freeGameSettings"]) {
        
        SMFreeGameSettingsViewController *dvc = segue.destinationViewController;
        dvc.gameMode = self.gameMode;
    }
    
}


- (IBAction)gameModeAction:(UIButton *)sender {
    
    if (sender.tag == 1) {
        self.gameMode = sender.tag;
        [self performSegueWithIdentifier:@"game" sender:nil];
    } else {
        self.gameMode = sender.tag;
        [self performSegueWithIdentifier:@"freeGameSettings" sender:nil];
    }

}

@end

