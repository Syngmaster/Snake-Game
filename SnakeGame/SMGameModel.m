//
//  SMGameModel.m
//  SnakeGame
//
//  Created by Syngmaster on 20/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMGameModel.h"

@implementation SMGameModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        switch ((int)[UIScreen mainScreen].bounds.size.width) {
            case 320:
                break;
            case 375:
                break;
            case 414:
                break;

        }
        
        //320 5,5s,5c
        NSLog(@"height - %f", [UIScreen mainScreen].bounds.size.width);

        //375 6,6s,7,7s
        //414 6plus,7plus
        
    }
    return self;
}

@end
