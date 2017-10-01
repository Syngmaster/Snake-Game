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

@import GoogleMobileAds;

@interface SMCustomAlertViewController () <GADInterstitialDelegate>

@property(nonatomic, strong) GADInterstitial *interstitial;

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
    
    if (self.alertType == AlertTypeNextLevel) {
        if (self.level % 2 == 0) {
            self.interstitial = [self createAndLoadInterstitial];
        }
    }
}

- (GADInterstitial *)createAndLoadInterstitial {
    
    GADInterstitial *interstitial =
    [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-3940256099942544/4411468910"];
    interstitial.delegate = self;
    GADRequest *request = [GADRequest request];
    request.testDevices = @[kGADSimulatorID, @"FNMRT1H6G5MT"];
    [interstitial loadRequest:request];
    
    return interstitial;
}


- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    NSLog(@"interstitialDidReceiveAd");
    
    [ad presentFromRootViewController:self];
    
}

- (void)interstitial:(GADInterstitial *)ad
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"interstitial:didFailToReceiveAdWithError: %@", [error localizedDescription]);
    
    
}

- (IBAction)buttonAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate viewControllerDismissed:self];
    }];
    
}

- (IBAction)facebookShareAction:(UIButton *)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *facebookVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [facebookVC addImage:[UIImage imageNamed:@"main_logo_share_facebook.png"]];
        //[facebookVC addURL:[NSURL URLWithString:@"https://www.google.ie/"]];

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
