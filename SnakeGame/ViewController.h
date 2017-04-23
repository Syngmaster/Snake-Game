//
//  ViewController.h
//  SnakeGame
//
//  Created by Syngmaster on 20/04/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat bodySize;

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *topButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;

- (IBAction)moveLeft:(UIButton *)sender;
- (IBAction)moveRight:(UIButton *)sender;
- (IBAction)moveUp:(UIButton *)sender;
- (IBAction)moveDown:(UIButton *)sender;

@end

