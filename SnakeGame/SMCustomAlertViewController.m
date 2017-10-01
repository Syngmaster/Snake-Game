//
//  SMCustomAlertViewController.m
//  SnakeGame
//
//  Created by Syngmaster on 30/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMCustomAlertViewController.h"
#import "SMSnakeEngineModel.h"
#import <Social/Social.h>

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
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *facebookVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [facebookVC setInitialText:@"I'm playing Advanture of Snake!"];
        [facebookVC addImage:[UIImage imageNamed:@"main_logo.png"]];
        
        [self presentViewController:facebookVC animated:YES completion:nil];
        
    } else {
        
        [self showAlertMessage:@"Please sign in Facebook"];
    }
    
}


- (void)showAlertMessage:(NSString *)myMessage{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"SocialShare" message:myMessage preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
