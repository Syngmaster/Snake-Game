//
//  SMCustomAlertViewController.m
//  SnakeGame
//
//  Created by Syngmaster on 30/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMCustomAlertViewController.h"
#import "SMSnakeEngineModel.h"

@interface SMCustomAlertViewController ()

@end

@implementation SMCustomAlertViewController

- (void)loadView {
    [super loadView];
    
    self.alertTitleLabel.text = self.alertTitle;
    self.alertBodyLabel.text = self.alertBody;
    
    if (self.alertType == AlertTypeGameOver) {
        self.facebookButtonContainerView.hidden = YES;
        UIFont *font = [UIFont fontWithName:@"Avenir-Heavy" size:32];
        self.alertBodyLabel.font = font;
    } else {
        UIFont *font = [UIFont fontWithName:@"Avenir-Heavy" size:18];
        self.alertBodyLabel.font = font;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate viewControllerDismissed:self];
    }];
    
}

- (IBAction)facebookShareAction:(UIButton *)sender {
    
    
    
}


@end
