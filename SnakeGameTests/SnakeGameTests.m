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
    SMPlayViewController *vc = [mainSB instantiateViewControllerWithIdentifier:@"SMViewController"];
    self.gameModel = [[SMGameModel alloc] init];
    self.playVC = vc;
    CGFloat mainWidth = [UIScreen mainScreen].bounds.size.width;
    self.mainWidth = mainWidth;

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testValidDeviceWidth {
    
    XCTAssert((self.mainWidth == 320) || (self.mainWidth == 375) || (self.mainWidth == 414));
    
}

/*- (void)testMaximumQuantityOfGameElements {
    
    int maximumGameElements = 0;
    int maximumGameElementsX = (int)((CGRectGetMaxX(self.playVC.view.frame) - self.gameModel.snakeStep * 2) / self.gameModel.snakeStep);
    int maximumGameElementsY = (int)((CGRectGetMaxY(self.playVC.view.frame) - self.gameModel.snakeStep) / self.gameModel.snakeStep);
    maximumGameElements = maximumGameElementsX * maximumGameElementsY;

    XCTAssert([self.playVC.snakeEngineModel.gameModel.takenCoordinates count] <= maximumGameElements * 0.6);
}*/

- (void)testRandomCoordinatesGenerator {
    
    CGPoint coordinates = [self.gameModel generateRandomCoordinates];
    
    XCTAssert(coordinates.x > 0 && coordinates.x < CGRectGetMaxX(self.playVC.view.frame)-self.gameModel.snakeStep);
    XCTAssert(coordinates.y > 0 && coordinates.y < CGRectGetMaxY(self.playVC.view.frame)-self.gameModel.snakeStep*2);
    
    XCTAssert((int)coordinates.x % 25 == 0);
    XCTAssert((int)coordinates.y % 25 == 0);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
