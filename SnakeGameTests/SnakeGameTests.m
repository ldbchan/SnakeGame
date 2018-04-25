//
//  SnakeGameTests.m
//  SnakeGameTests
//
//  Created by chantil on 04/18/2018.
//  Copyright © 2018 ldbchan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SGBase.h"
#import "SGSnake.h"

@interface SnakeGameTests : XCTestCase

@end

@implementation SnakeGameTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testInit {
    SGSnake *snake = [[SGSnake alloc] initWithLength:10 worldSize:SGWorldSizeMake(20, 25)];
    XCTAssertEqual(snake.worldSize.width, 20);
    XCTAssertEqual(snake.worldSize.height, 25);

    SGPoint headPoint = [snake.bodyPoints.firstObject SGPointValue];
    XCTAssertTrue(SGPointEqualToPoint(headPoint, SGPointMake(10, 12)));

    XCTAssertEqual(snake.bodyPoints.count, 10);
}

- (void)testMove {
    SGSnake *snake = [[SGSnake alloc] initWithLength:10 worldSize:SGWorldSizeMake(20, 20)];
    SGPoint headPoint = [snake.bodyPoints.firstObject SGPointValue];
    SGPoint tailPoint = [snake.bodyPoints.lastObject SGPointValue];
    XCTAssertTrue(SGPointEqualToPoint(headPoint, SGPointMake(10, 10)));
    XCTAssertTrue(SGPointEqualToPoint(tailPoint, SGPointMake(19, 10)));

    [snake move];
    headPoint = [snake.bodyPoints.firstObject SGPointValue];
    tailPoint = [snake.bodyPoints.lastObject SGPointValue];
    XCTAssertTrue(SGPointEqualToPoint(headPoint, SGPointMake(9, 10)));
    XCTAssertTrue(SGPointEqualToPoint(tailPoint, SGPointMake(18, 10)));
}

- (void)testTurn {
    SGSnake *snake = [[SGSnake alloc] initWithLength:4 worldSize:SGWorldSizeMake(20, 20)];
    SGPoint headPoint = [snake.bodyPoints.firstObject SGPointValue];
    SGPoint tailPoint = [snake.bodyPoints.lastObject SGPointValue];
    XCTAssertTrue(SGPointEqualToPoint(headPoint, SGPointMake(10, 10)));
    XCTAssertTrue(SGPointEqualToPoint(tailPoint, SGPointMake(13, 10)));

    [snake turn:SGSnakeDirectionUp];
    [snake move];
    headPoint = [snake.bodyPoints.firstObject SGPointValue];
    tailPoint = [snake.bodyPoints.lastObject SGPointValue];
    XCTAssertTrue(SGPointEqualToPoint(headPoint, SGPointMake(10, 9)));
    XCTAssertTrue(SGPointEqualToPoint(tailPoint, SGPointMake(12, 10)));

    [snake turn:SGSnakeDirectionLeft];
    [snake move];
    headPoint = [snake.bodyPoints.firstObject SGPointValue];
    tailPoint = [snake.bodyPoints.lastObject SGPointValue];
    XCTAssertTrue(SGPointEqualToPoint(headPoint, SGPointMake(9, 9)));
    XCTAssertTrue(SGPointEqualToPoint(tailPoint, SGPointMake(11, 10)));

    [snake turn:SGSnakeDirectionDown];
    [snake move];
    headPoint = [snake.bodyPoints.firstObject SGPointValue];
    tailPoint = [snake.bodyPoints.lastObject SGPointValue];
    XCTAssertTrue(SGPointEqualToPoint(headPoint, SGPointMake(9, 10)));
    XCTAssertTrue(SGPointEqualToPoint(tailPoint, SGPointMake(10, 10)));

    [snake turn:SGSnakeDirectionRight];
    [snake move];
    headPoint = [snake.bodyPoints.firstObject SGPointValue];
    tailPoint = [snake.bodyPoints.lastObject SGPointValue];
    XCTAssertTrue(SGPointEqualToPoint(headPoint, SGPointMake(10, 10)));
    XCTAssertTrue(SGPointEqualToPoint(tailPoint, SGPointMake(10, 9)));
}

- (void)testGrow {
    SGSnake *snake = [[SGSnake alloc] initWithLength:4 worldSize:SGWorldSizeMake(20, 20)];
    SGPoint headPoint = [snake.bodyPoints.firstObject SGPointValue];
    SGPoint tailPoint = [snake.bodyPoints.lastObject SGPointValue];
    XCTAssertTrue(SGPointEqualToPoint(headPoint, SGPointMake(10, 10)));
    XCTAssertTrue(SGPointEqualToPoint(tailPoint, SGPointMake(13, 10)));

    [snake grow:1];
    headPoint = [snake.bodyPoints.firstObject SGPointValue];
    tailPoint = [snake.bodyPoints.lastObject SGPointValue];
    XCTAssertTrue(SGPointEqualToPoint(headPoint, SGPointMake(10, 10)));
    XCTAssertTrue(SGPointEqualToPoint(tailPoint, SGPointMake(14, 10)));

    [snake grow:2];
    headPoint = [snake.bodyPoints.firstObject SGPointValue];
    tailPoint = [snake.bodyPoints.lastObject SGPointValue];
    XCTAssertTrue(SGPointEqualToPoint(headPoint, SGPointMake(10, 10)));
    XCTAssertTrue(SGPointEqualToPoint(tailPoint, SGPointMake(16, 10)));
}

- (void)testHitBody {
    SGSnake *snake = [[SGSnake alloc] initWithLength:10 worldSize:SGWorldSizeMake(20, 20)];

    [snake turn:SGSnakeDirectionUp];
    [snake move];
    XCTAssertFalse([snake hasHeadHitBody]);

    [snake turn:SGSnakeDirectionRight];
    [snake move];
    XCTAssertFalse([snake hasHeadHitBody]);

    [snake turn:SGSnakeDirectionDown];
    [snake move];
    XCTAssertTrue([snake hasHeadHitBody]);
}

- (void)testHitWall {
    SGSnake *snake = [[SGSnake alloc] initWithLength:5 worldSize:SGWorldSizeMake(10, 10)];

    [snake move];
    XCTAssertFalse([snake hasHeadHitWall]);

    [snake move];
    XCTAssertFalse([snake hasHeadHitWall]);

    [snake move];
    XCTAssertFalse([snake hasHeadHitWall]);

    [snake move];
    XCTAssertFalse([snake hasHeadHitWall]);

    [snake move];
    XCTAssertFalse([snake hasHeadHitWall]);

    [snake move];
    XCTAssertTrue([snake hasHeadHitWall]);
}

- (void)testHasPointInBody {
    SGSnake *snake = [[SGSnake alloc] initWithLength:4 worldSize:SGWorldSizeMake(20, 20)];

    XCTAssertTrue([snake hasPointInBody:SGPointMake(10, 10)]);
    XCTAssertTrue([snake hasPointInBody:SGPointMake(11, 10)]);
    XCTAssertTrue([snake hasPointInBody:SGPointMake(12, 10)]);
    XCTAssertTrue([snake hasPointInBody:SGPointMake(13, 10)]);

    XCTAssertFalse([snake hasPointInBody:SGPointMake(11, 11)]);
    XCTAssertFalse([snake hasPointInBody:SGPointMake(12, 12)]);
    XCTAssertFalse([snake hasPointInBody:SGPointMake(13, 13)]);
}

@end
