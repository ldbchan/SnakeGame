//
//  SGSnake.h
//  SnakeGame
//
//  Created by chantil on 04/18/2018.
//  Copyright © 2018 ldbchan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SGSnakeDirection) {
    SGSnakeDirectionUp,
    SGSnakeDirectionDown,
    SGSnakeDirectionLeft,
    SGSnakeDirectionRight
};

@interface SGSnake : NSObject

/**
 The only initializer to create a new snake.

 @param length Initial length of the snake.
 @param worldSize World size for the snake to be in.
 @return A new snake whose head shows in the center of the world with the direction SGSnakeDirectionLeft by default.
 */
- (instancetype)initWithLength:(NSUInteger)length worldSize:(SGWorldSize)worldSize;

- (void)move;
- (void)turn:(SGSnakeDirection)direction;
- (void)grow:(NSUInteger)length;
- (BOOL)hasHeadHitBody;
- (BOOL)hasHeadHitWall;
- (BOOL)hasPointInBody:(SGPoint)point;

/**
 An array of the snake's body points. Item types must be @(SGPoint).
 */
@property (nonatomic, strong, readonly) NSArray *bodyPoints;
@property (nonatomic, assign, readonly) SGWorldSize worldSize;

@end
