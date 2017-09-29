//
//  SMPlayground.m
//  SnakeGame
//
//  Created by Syngmaster on 21/06/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMPlayground.h"

@interface SMPlayground ()

@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;


@end

@implementation SMPlayground

- (instancetype)initWithView:(UIView *) view
{
    self = [super init];
    if (self) {
        
        switch ((int)[UIScreen mainScreen].bounds.size.width) {
         
            case 320:
                self.height = 462; //step = 22
                self.width = 264;
                self.step = 22;
                break;
                
            case 375:
                self.height = 552; // step = 24
                self.width = 312;
                self.step = 24;
                break;
         
            case 414:
                self.height = 625; //step = 25
                self.width = 350;
                self.step = 25;
                break;
                
            case 768:
                self.height = 884; //step = 26
                self.width = 650;
                self.step = 26;
                break;
                
            case 834:
                self.height = 960; //step = 32
                self.width = 704;
                self.step = 32;
                break;
                
            case 1024:
                self.height = 1200; //step = 40
                self.width = 880;
                self.step = 40;
                break;
         
         }

        UIView *playView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        CGPoint centerView = CGPointMake(view.center.x, view.center.y);
        playView.center = centerView;
        playView.backgroundColor = [UIColor clearColor];
        [view addSubview:playView];
        self.gridView = playView;
    }
    
    return self;
}

@end
