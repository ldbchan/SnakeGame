//
//  SGGameView.h
//  SnakeGame
//
//  Created by chantil on 04/19/2018.
//  Copyright © 2018 ldbchan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGSnake.h"

@class SGGameView;

#pragma mark - SGGameViewDataSource

@protocol SGGameViewDataSource <NSObject>

@required
- (SGSnake *)snakeInGameView:(SGGameView *)gameView;
- (SGPoint)foodPointInGameView:(SGGameView *)gameView;

@end

#pragma mark - SGGameViewDelegate

@protocol SGGameViewDelegate <NSObject>

@required
- (void)gameViewDidSwipeLeft:(SGGameView *)gameView;
- (void)gameViewDidSwipeRight:(SGGameView *)gameView;
- (void)gameViewDidSwipeUp:(SGGameView *)gameView;
- (void)gameViewDidSwipeDown:(SGGameView *)gameView;

@end

#pragma mark - SGGameView

@interface SGGameView : UIView

@property (nonatomic, weak) id<SGGameViewDataSource> dataSource;
@property (nonatomic, weak) id<SGGameViewDelegate> delegate;
@property (nonatomic, strong) SGSnake *snake;

- (void)reload;

@end
