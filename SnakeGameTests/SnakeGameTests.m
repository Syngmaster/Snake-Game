//
//  SnakeGameTests.m
//  SnakeGameTests
//
//  Created by Syngmaster on 20/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SMSnakeModel.h"
#import "SMViewController.h"

@interface SnakeGameTests : XCTestCase

@property (strong, nonatomic) SMSnakeModel *snakeModel;
@property (strong, nonatomic) SMViewController *playVC;

@end

@implementation SnakeGameTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    SMViewController *vc = [mainSB instantiateViewControllerWithIdentifier:@"SMViewController"];
    UIView *view = vc.view;
    self.snakeModel = [[SMSnakeModel alloc] initSnakeInView:view];
    self.playVC = vc;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    XCTAssert(self.snakeModel.startX > 0 && self.snakeModel.startX < CGRectGetMaxX(self.playVC.view.frame)-25);
    XCTAssert(self.snakeModel.startY > 0 && self.snakeModel.startY < CGRectGetMaxY(self.playVC.view.frame)-50);
    
    XCTAssert((int)self.snakeModel.startX % 25 == 0);
    XCTAssert((int)self.snakeModel.startY % 25 == 0);

    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
