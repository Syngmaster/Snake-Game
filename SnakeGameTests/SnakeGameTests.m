//
//  SnakeGameTests.m
//  SnakeGameTests
//
//  Created by Syngmaster on 20/09/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SMGameModel.h"
#import "SMViewController.h"

@interface SnakeGameTests : XCTestCase

@property (strong, nonatomic) SMGameModel *gameModel;
@property (strong, nonatomic) SMViewController *playVC;
@property (assign, nonatomic) CGFloat mainWidth;
@end

@implementation SnakeGameTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    SMViewController *vc = [mainSB instantiateViewControllerWithIdentifier:@"SMViewController"];
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

- (void)testRandomCoordinatesGenerator {
    
    CGPoint coordinates = [self.gameModel generateRandomCoordinates];
    
    XCTAssert(coordinates.x > 0 && coordinates.x < CGRectGetMaxX(self.playVC.view.frame)-25);
    XCTAssert(coordinates.y > 0 && coordinates.y < CGRectGetMaxY(self.playVC.view.frame)-50);
    
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
