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

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                             forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem.title=@"";
    
    UIImage *backBtn = [UIImage imageNamed:@"back_button.png"];
    backBtn = [backBtn imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationController.navigationBar.backIndicatorImage = backBtn;
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = backBtn;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showGameAction:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"gameMode" sender:nil];
    
}

@end
