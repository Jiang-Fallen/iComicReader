//
//  JFRefreshControl.m
//  RefreshDemo
//
//  Created by Mr_J on 16/3/5.
//  Copyright © 2016年 Mr_J. All rights reserved.
//

#import "JFRefreshControl.h"
#import "JFRefreshOpration.h"

@interface JFRefreshControl () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) JFRefreshOpration *refreshOpration;

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation JFRefreshControl

- (instancetype)initWithScrollView:(UIScrollView *)scrollView
{
    self = [super init];
    if (self) {
        [self registerFromScrollView:scrollView];
    }
    return self;
}

- (void)registerFromScrollView:(UIScrollView *)scrollView
{
    self.frame = ({
        CGRect frame = self.frame;
        frame.origin.y = -frame.size.height;
        frame.size.width = scrollView.bounds.size.width;
        frame;
    });
    self.scrollView = scrollView;
    [scrollView addSubview:self];
    
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    self.panGestureRecognizer.cancelsTouchesInView = NO;
    self.panGestureRecognizer.delegate = self;
    [self.scrollView addGestureRecognizer:self.panGestureRecognizer];
}

- (void)removeFromScrollView
{
    [self.scrollView removeGestureRecognizer:self.panGestureRecognizer];
    self.panGestureRecognizer.delegate = nil;
    self.scrollView = nil;
}

#pragma mark - set And get
- (void)setScrollView:(UIScrollView *)scrollView{
    _scrollView = scrollView;
    self.refreshOpration.scrollView = scrollView;
}

- (JFRefreshOpration *)refreshOpration{
    if (!_refreshOpration) {
        _refreshOpration = [JFRefreshOpration new];
        _refreshOpration.scrollView = self.scrollView;
    }
    return _refreshOpration;
}

#pragma mark set get Transfer
- (void)setNormalItems:(NSArray *)normalItems{
    self.refreshOpration.normalItems = normalItems;
}

- (NSArray *)normalItems{
    return self.refreshOpration.normalItems;
}

- (void)setHighlightItems:(NSArray *)highlightItems{
    self.refreshOpration.highlightItems = highlightItems;
}

- (NSArray *)highlightItems{
    return self.refreshOpration.highlightItems;
}

- (void)setActionOfIndex:(void (^)(NSInteger))actionOfIndex{
    self.refreshOpration.actionOfIndex = actionOfIndex;
}

- (void)setBaseHeight:(CGFloat)baseHeight{
    self.refreshOpration.baseHeight = baseHeight;
}

- (CGFloat)baseHeight{
    return self.refreshOpration.baseHeight;
}

- (void)setShow_MIN_Y:(CGFloat)show_MIN_Y{
    self.refreshOpration.show_MIN_Y = show_MIN_Y;
}

- (CGFloat)show_MIN_Y{
    return self.refreshOpration.show_MIN_Y;
}

- (void)setStartLocation_Y:(CGFloat)startLocation_Y{
    self.refreshOpration.startLocation_Y = startLocation_Y;
}

- (CGFloat)startLocation_Y{
    return self.refreshOpration.startLocation_Y;
}

- (void)setTopShadowAlpha:(CGFloat)topShadowAlpha{
    self.refreshOpration.topShadowAlpha = topShadowAlpha;
}

- (CGFloat)topShadowAlpha{
    return self.refreshOpration.topShadowAlpha;
}

#pragma mark - action
#pragma mark Gesture handling
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [self.refreshOpration resume];
        return;
    }
    
    CGPoint location = [gesture locationInView:self.scrollView];
    location.y = -(self.scrollView.contentOffset.y + self.scrollView.contentInset.top);
    self.refreshOpration.location = location;
}

@end
