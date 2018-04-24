//
//  SGBase.h
//  SnakeGame
//
//  Created by chantil on 04/20/2018.
//  Copyright © 2018 ldbchan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

#pragma mark - SGPoint

struct SGPoint {
    NSUInteger x;
    NSUInteger y;
};
typedef struct CG_BOXABLE SGPoint SGPoint;

SGPoint SGPointMake(NSUInteger x, NSUInteger y);

BOOL SGPointEqualToPoint(SGPoint point1, SGPoint point2);

NSString *NSStringFromSGPoint(SGPoint);

#pragma mark - SGWorldSize

struct SGWorldSize {
    NSUInteger width;
    NSUInteger height;
};
typedef struct SGWorldSize SGWorldSize;

SGWorldSize SGWorldSizeMake(NSUInteger width, NSUInteger height);

SGWorldSize SGWorldSizeFromCGSize(CGSize size);

NSString *NSStringFromSGWorldSize(SGWorldSize);

#pragma mark - NSValue Catagory

@interface NSValue (SnakeGame)

- (SGPoint)SGPointValue;

@end
