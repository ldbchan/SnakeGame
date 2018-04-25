//
//  SGGameView.m
//  SnakeGame
//
//  Created by chantil on 04/19/2018.
//  Copyright © 2018 ldbchan. All rights reserved.
//

#import "SGGameView.h"

@implementation SGGameView

- (void)drawRect:(CGRect)rect {
    SGSnake *snake = [self.dataSource snakeInGameView:self];
    SGWorldSize worldSize = snake.worldSize;
    CGSize actualSize = self.bounds.size;
    CGFloat w = actualSize.width / worldSize.width;
    CGFloat h = actualSize.height / worldSize.height;

    CGContextRef context = UIGraphicsGetCurrentContext();

    // draw background
    CGContextSetFillColorWithColor(context, UIColor.whiteColor.CGColor);
    CGContextFillRect(context, rect);

    // draw snake
    CGContextSetFillColorWithColor(context, UIColor.grayColor.CGColor);

    for (NSValue *value in snake.bodyPoints) {
        SGPoint bodyPoint = [value SGPointValue];
        CGContextSetFillColorWithColor(context, UIColor.grayColor.CGColor);
        CGContextFillRect(context, CGRectMake(w * bodyPoint.x, h * bodyPoint.y, w, h));
    }

    // draw fruit
    SGPoint foodPoint = [self.dataSource foodPointInGameView:self];
    CGContextSetFillColorWithColor(context, UIColor.greenColor.CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(w * foodPoint.x, h * foodPoint.y, w, h));

    // add swipe gesture recognizers once
    if (!self.gestureRecognizers.count) {
        NSArray *directions = @[@(UISwipeGestureRecognizerDirectionUp),
                                @(UISwipeGestureRecognizerDirectionDown),
                                @(UISwipeGestureRecognizerDirectionLeft),
                                @(UISwipeGestureRecognizerDirectionRight)];

        for (NSNumber *number in directions) {
            UISwipeGestureRecognizerDirection direction = number.unsignedIntegerValue;
            UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
            swipeRecognizer.direction = direction;
            [self addGestureRecognizer:swipeRecognizer];
        }
    }
}

#pragma mark - Pulic Method

- (void)reload {
    [self setNeedsDisplay];
}

#pragma mark - Recoginzer

- (void)didSwipe:(UISwipeGestureRecognizer *)swipeGestureRecognizer {
    switch (swipeGestureRecognizer.direction) {
        case UISwipeGestureRecognizerDirectionUp:
            [self.delegate gameViewDidSwipeUp:self];
            break;
        case UISwipeGestureRecognizerDirectionDown:
            [self.delegate gameViewDidSwipeDown:self];
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            [self.delegate gameViewDidSwipeLeft:self];
            break;
        case UISwipeGestureRecognizerDirectionRight:
            [self.delegate gameViewDidSwipeRight:self];
            break;
    }
}

@end
