//
//  SGBase.m
//  SnakeGame
//
//  Created by chantil on 04/20/2018.
//  Copyright © 2018 ldbchan. All rights reserved.
//

#import "SGBase.h"

#pragma mark - SGPoint

SGPoint SGPointMake(NSUInteger x, NSUInteger y) {
    SGPoint point;
    point.x = x;
    point.y = y;
    return point;
}

BOOL SGPointEqualToPoint(SGPoint point1, SGPoint point2) {
    return point1.x == point2.x && point1.y == point2.y;
}

NSString *NSStringFromSGPoint(SGPoint point) {
    return [NSString stringWithFormat:@"{%lu, %lu}", point.x, point.y];
}

#pragma mark - SGWorldSize

SGWorldSize SGWorldSizeMake(NSUInteger width, NSUInteger height) {
    SGWorldSize worldSize;
    worldSize.width = width;
    worldSize.height = height;
    return worldSize;
}

SGWorldSize SGWorldSizeFromCGSize(CGSize size) {
    SGWorldSize worldSize;
    worldSize.width = (NSUInteger)size.width;
    worldSize.height = (NSUInteger)size.height;
    return worldSize;
}

NSString *NSStringFromSGWorldSize(SGWorldSize worldSize) {
    return [NSString stringWithFormat:@"{%lu, %lu}", worldSize.width, worldSize.height];
}

#pragma mark - NSValue Catagory

@implementation NSValue (SGPoint)

- (SGPoint)SGPointValue {
    SGPoint point = SGPointMake(0, 0);

    if (0 == strcmp(self.objCType, @encode(SGPoint))) {
        [self getValue:&point];
    }
    return point;
}

@end
