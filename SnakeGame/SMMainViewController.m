//
//  SMMainViewController.m
//  SnakeGame
//
//  Created by Syngmaster on 25/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMMainViewController.h"

@interface SMMainViewController ()

@end

@implementation SMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showGameAction:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"show" sender:nil];
    
}

@end
