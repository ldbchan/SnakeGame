//
//  SGViewController.m
//  SnakeGame
//
//  Created by chantil on 04/18/2018.
//  Copyright © 2018 ldbchan. All rights reserved.
//

#import "SGViewController.h"
#import "SGGameView.h"

static const NSUInteger kSnakeInitialLength = 10;
static const NSUInteger kSnakeGrowLength = 2;
static const NSUInteger kWorldSizeScale = 20;

@interface SGViewController () <SGGameViewDataSource, SGGameViewDelegate>

@property (nonatomic, assign) SGPoint foodPoint;
@property (nonatomic, strong) SGSnake *snake;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, weak) IBOutlet SGGameView *gameView;
@property (nonatomic, weak) IBOutlet UIButton *startButton;

@end

@implementation SGViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.gameView.dataSource = self;
    self.gameView.delegate = self;
}

- (void)startGame {
    self.startButton.hidden = YES;

    NSUInteger width = CGRectGetWidth(self.gameView.bounds) / kWorldSizeScale;
    NSUInteger height = CGRectGetHeight(self.gameView.bounds) / kWorldSizeScale;
    SGWorldSize worldSize = SGWorldSizeMake(width, height);
    self.snake = [[SGSnake alloc] initWithLength:kSnakeInitialLength worldSize:worldSize];
    [self generateRandomFood];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                  target:self
                                                selector:@selector(ticktock)
                                                userInfo:nil
                                                 repeats:YES];

    // set startButton's title to "Try Again" after first game
    [self.startButton setTitle:@"Try Again" forState:UIControlStateNormal];
}

- (void)endGame {
    [self.timer invalidate];
    self.startButton.hidden = NO;
}

- (void)ticktock {
    [self.snake move];
    [self.gameView reload];

    if (self.snake.hasHeadHitBody || self.snake.hasHeadHitWall) {
        [self endGame];
        return;
    }

    SGPoint headPoint = [self.snake.bodyPoints.firstObject SGPointValue];

    if (SGPointEqualToPoint(self.foodPoint, headPoint)) {
        [self.snake grow:kSnakeGrowLength];
        [self generateRandomFood];
    }
}

- (void)generateRandomFood {
    SGPoint foodPoint;

    do {
        NSUInteger x = arc4random() % self.snake.worldSize.width;
        NSUInteger y = arc4random() % self.snake.worldSize.height;
        foodPoint = SGPointMake(x, y);
    } while ([self.snake hasPointInBody:foodPoint]);

    self.foodPoint = foodPoint;
}

#pragma mark - SGGameViewDataSource

- (SGSnake *)snakeInGameView:(SGGameView *)gameView {
    return self.snake;
}

- (SGPoint)foodPointInGameView:(SGGameView *)gameView {
    return self.foodPoint;
}

#pragma mark - SGGameViewDelegate

- (void)gameViewDidSwipeUp:(SGGameView *)gameView {
    [self.snake turn:SGSnakeDirectionUp];
}

- (void)gameViewDidSwipeDown:(SGGameView *)gameView {
    [self.snake turn:SGSnakeDirectionDown];
}

- (void)gameViewDidSwipeLeft:(SGGameView *)gameView {
    [self.snake turn:SGSnakeDirectionLeft];
}

- (void)gameViewDidSwipeRight:(SGGameView *)gameView {
    [self.snake turn:SGSnakeDirectionRight];
}

#pragma mark - IBAction

- (IBAction)didTapStartButton:(UIButton *)sender {
    [self startGame];
}

@end
