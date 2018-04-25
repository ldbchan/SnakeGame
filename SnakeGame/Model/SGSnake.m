//
//  SGSnake.m
//  SnakeGame
//
//  Created by chantil on 04/18/2018.
//  Copyright © 2018 ldbchan. All rights reserved.
//

#import "SGSnake.h"

@interface SGSnake ()

@property (nonatomic, strong) NSMutableArray *mutableBodyPoints;
@property (nonatomic, assign, readwrite) SGWorldSize worldSize;
@property (nonatomic, assign) SGSnakeDirection direction;

@end

@implementation SGSnake

#pragma mark - Initializer

- (instancetype)initWithLength:(NSUInteger)length worldSize:(SGWorldSize)worldSize {
    self = [self init];

    if (self) {
        self.worldSize = worldSize;
        self.direction = SGSnakeDirectionLeft;

        self.mutableBodyPoints = [[NSMutableArray alloc] init];
        NSUInteger x = worldSize.width / 2;
        NSUInteger y = worldSize.height / 2;

        for (NSInteger i = 0; i < length; i++) {
            [self.mutableBodyPoints addObject:@(SGPointMake(x + i, y))];
        }
    }
    return self;
}

#pragma mark - Public Method

- (void)move {
    SGPoint firstPoint = [[self.bodyPoints firstObject] SGPointValue];
    NSUInteger x = firstPoint.x;
    NSUInteger y = firstPoint.y;

    switch (self.direction) {
        case SGSnakeDirectionUp:
            y--;
            break;
        case SGSnakeDirectionDown:
            y++;
            break;
        case SGSnakeDirectionLeft:
            x--;
            break;
        case SGSnakeDirectionRight:
            x++;
            break;
    }
    [self.mutableBodyPoints insertObject:@(SGPointMake(x, y)) atIndex:0];
    [self.mutableBodyPoints removeLastObject];
}

- (void)turn:(SGSnakeDirection)direction {
    if (SGSnakeDirectionUp == direction || SGSnakeDirectionDown == direction) {
        if (SGSnakeDirectionUp == self.direction || SGSnakeDirectionDown == self.direction) {
            return;
        }
    } else { // direction is left or right
        if (SGSnakeDirectionLeft == self.direction || SGSnakeDirectionRight == self.direction) {
            return;
        }
    }
    self.direction = direction;
}

- (void)grow:(NSUInteger)length {
    SGPoint lastPoint = [[self.bodyPoints lastObject] SGPointValue];
    SGPoint secondLastPoint = [self.bodyPoints[self.bodyPoints.count - 2] SGPointValue];
    NSUInteger deltaX = lastPoint.x - secondLastPoint.x;
    NSUInteger deltaY = lastPoint.y - secondLastPoint.y;

    for (NSInteger i = 1; i <= length; i++) {
        NSUInteger newX = lastPoint.x + deltaX * i;
        NSUInteger newY = lastPoint.y + deltaY * i;
        SGPoint newPoint = SGPointMake(newX, newY);
        [self.mutableBodyPoints addObject:@(newPoint)];
    }
}

- (BOOL)hasHeadHitBody {
    SGPoint firstPoint = [[self.bodyPoints firstObject] SGPointValue];

    for (NSInteger i = 1; i < self.bodyPoints.count; i++) {
        SGPoint bodyPoint = [self.bodyPoints[i] SGPointValue];

        if (SGPointEqualToPoint(bodyPoint, firstPoint)) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)hasHeadHitWall {
    SGPoint firstPoint = [[self.bodyPoints firstObject] SGPointValue];

    if (firstPoint.x == NSUIntegerMax || firstPoint.x == self.worldSize.width ||
        firstPoint.y == NSUIntegerMax || firstPoint.y == self.worldSize.height) {
        return YES;
    }
    return NO;
}

- (BOOL)hasPointInBody:(SGPoint)point {
    for (NSValue *value in self.bodyPoints) {
        SGPoint bodyPoint = [value SGPointValue];

        if (SGPointEqualToPoint(point, bodyPoint)) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - Getter

- (NSArray *)bodyPoints {
    return self.mutableBodyPoints.copy;
}

@end
