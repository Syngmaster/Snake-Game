//
//  SMFreeGameSettingsViewController.m
//  SnakeGame
//
//  Created by Syngmaster on 28/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMFreeGameSettingsViewController.h"

@interface SMFreeGameSettingsViewController ()

@end

@implementation SMFreeGameSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Free game settings";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)startGameAction:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"startGame" sender:nil];
    
}


@end
