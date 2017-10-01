//
//  SMCustomAlertViewController.h
//  SnakeGame
//
//  Created by Syngmaster on 30/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMCustomAlertViewController;

@protocol SMCustomAlertDelegate <NSObject>

- (void)viewControllerDismissed:(SMCustomAlertViewController *)viewController;

@end

@interface SMCustomAlertViewController : UIViewController

@property (assign, nonatomic) NSInteger alertType;
@property (strong, nonatomic) NSString *alertTitle;
@property (strong, nonatomic) NSString *alertBody;

@property (assign, nonatomic) NSInteger level;

@property (weak, nonatomic) id <SMCustomAlertDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *alertTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *alertBodyLabel;
@property (weak, nonatomic) IBOutlet UIView *facebookButtonContainerView;

- (IBAction)buttonAction:(UIButton *)sender;
- (IBAction)facebookShareAction:(UIButton *)sender;

@end
