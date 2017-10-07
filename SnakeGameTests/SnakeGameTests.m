//
//  SnakeGameTests.m
//  SnakeGameTests
//
//  Created by Syngmaster on 20/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SMGameModel.h"
#import "SMPlayViewController.h"
#import "SMSnakeEngineModel.h"

@interface SnakeGameTests : XCTestCase

@property (strong, nonatomic) SMGameModel *gameModel;
@property (strong, nonatomic) SMPlayViewController *playVC;
@property (strong, nonatomic) SMSnakeEngineModel *engineModel;
@property (assign, nonatomic) CGFloat mainWidth;

@end

@implementation SnakeGameTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    SMPlayViewController *vc = [mainSB instantiateViewControllerWithIdentifier:@"SMPlayViewController"];
    self.gameModel = [[SMGameModel alloc] initWithView:vc.playgroundView andGameSettings:nil];
    self.playVC = vc;
    self.engineModel = [[SMSnakeEngineModel alloc] initWithGameModel:self.gameModel];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testGameModelValuesAfterViewDisappeared {
    [self.playVC viewDidDisappear:YES];
    NSInteger numberOfTakenCoordinates = [self.playVC.snakeEngineModel.gameModel.takenCoordinates count];
    NSInteger numberOfSnakeElements = [self.playVC.snakeEngineModel.gameModel.snakeArray count];
    
    XCTAssertEqual(numberOfTakenCoordinates, 0);
    XCTAssertEqual(numberOfSnakeElements, 0);

}

- (void)testGameModelValuesBeforeViewAppeared {
    [self.playVC viewDidAppear:YES];
    
    NSInteger numberOfSnakeElements = [self.playVC.snakeEngineModel.gameModel.snakeArray count];
    NSInteger numberOfMeals = 0;
    for (UIView *view in self.playVC.snakeEngineModel.gameModel.gridView.subviews) {
        if (view.tag == GameElementMeal) {
            numberOfMeals = numberOfMeals + 1;
        }
    }
    
    XCTAssertEqual(numberOfSnakeElements, 2);
    XCTAssertEqual(numberOfMeals, 1);

}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
