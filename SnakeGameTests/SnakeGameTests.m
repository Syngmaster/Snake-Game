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
@property (assign, nonatomic) CGFloat mainWidth;

@end

@implementation SnakeGameTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    SMPlayViewController *vc = [mainSB instantiateViewControllerWithIdentifier:@"SMPlayViewController"];
    self.gameModel = [[SMGameModel alloc] init];
    self.playVC = vc;
    CGFloat mainWidth = [UIScreen mainScreen].bounds.size.width;
    self.mainWidth = mainWidth;

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testMaximumHazardImages {
    
    XCTAssertTrue([self.playVC.snakeEngineModel.gameModel.hazardImages count] <= 4);
    
}

- (void)testMaximumQuantityOfElements {
    
    switch ((int)[UIScreen mainScreen].bounds.size.width) {
            
        case 320:
            
            XCTAssert([self.gameModel.takenCoordinates count] <= (21*12));
            break;
            
        case 375:
            
            XCTAssert([self.gameModel.takenCoordinates count] <= (23*13));
            break;
            
        case 414:

            XCTAssert([self.gameModel.takenCoordinates count] <= (25*14));
            break;
            
        case 768:

            XCTAssert([self.gameModel.takenCoordinates count] <= (34*25));
            break;
            
        case 834:

            XCTAssert([self.gameModel.takenCoordinates count] <= (30*22));
            break;
            
        case 1024:

            XCTAssert([self.gameModel.takenCoordinates count] <= (30*22));
            break;
            
    }
    
}




- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
