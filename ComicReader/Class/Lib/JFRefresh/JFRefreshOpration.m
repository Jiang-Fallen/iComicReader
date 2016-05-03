//
//  JFRefreshOpration.m
//  RefreshDemo
//
//  Created by Mr_J on 16/3/5.
//  Copyright © 2016年 Mr_J. All rights reserved.
//

#import "JFRefreshOpration.h"
#import "UIView+JFFrame.h"

#define kRefreshMultiplier 3.0
@interface JFRefreshOpration () <UIGestureRecognizerDelegate>
{
    //top view value
    CGFloat _show_MIN_X;
    CGFloat _show_MAX_X;
    CGPoint _oprationAnchor;
    //state
    BOOL _isLoaded;
    BOOL _isTouchOpration;
    
    //animation displayLink paramer
    NSInteger _displayCount;
    NSInteger _displayKey;
    CGFloat _previousPoint;
    CGFloat _nextPoint;
    CGFloat _beginPoint;
    CGFloat _targetPoint;
}

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, weak) UIToolbar *backgroundView;
@property (nonatomic, weak) UIView *topContentView;

@property (nonatomic, assign) UIEdgeInsets scrollViewContentInset;
@property (nonatomic, strong) NSMutableArray *actionItems;
@property (nonatomic, weak) CADisplayLink *displayLink;

@end

@implementation JFRefreshOpration

#pragma mark - init fundation
- (instancetype)init
{
    return [self initFefresh];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initFefresh];
}

- (instancetype)initFefresh{
    CGRect frame = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:frame];
    if (self) {
        _baseHeight = 64.0;
        _startLocation_Y = 15;
        
        self.layer.masksToBounds = YES;
        UIView *contentView = [[UIView alloc]initWithFrame:self.bounds];
        contentView.alpha = 0;
        [self addSubview:contentView];
        _topContentView = contentView;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapContentViewAction:)];
        tap.delegate = self;
        [_topContentView addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark - get And set
- (CAShapeLayer *)shapeLayer{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        CGColorRef colorRef = [UIColor whiteColor].CGColor;
        _shapeLayer.strokeColor = colorRef;
        _shapeLayer.fillColor = colorRef;
        _shapeLayer.shadowColor = [UIColor blackColor].CGColor;
        _shapeLayer.shadowOpacity = 0;
        _shapeLayer.shadowOffset = CGSizeMake(0, 3);
        [self.topContentView.layer insertSublayer:_shapeLayer atIndex:0];
    }
    return _shapeLayer;
}

- (void)setTopShadowAlpha:(CGFloat)topShadowAlpha{
    _topShadowAlpha = topShadowAlpha;
    self.shapeLayer.shadowOpacity = topShadowAlpha;
}

- (UIToolbar *)backgroundView{
    if (!_backgroundView) {
        UIToolbar *backgroundView = [[UIToolbar alloc]initWithFrame:self.bounds];
        backgroundView.alpha = 0;
        [self insertSubview:backgroundView atIndex:0];
        _backgroundView = backgroundView;
    }
    return _backgroundView;
}

- (void)setLocation:(CGPoint)location{
    _location = location;
    if (location.y <= 0) {
        _isLoaded = NO;
        [self removeFromSuperview];
        return;
    }
    if(!_isLoaded){
        _isLoaded = YES;
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        [window addSubview:self];
    }
    _location.y = MAX(0, location.y);
    _oprationAnchor = _location;
    _oprationAnchor.y = (_location.y - self.startLocation_Y) * 2 + self.baseHeight;
    [self updateStateForLocation:_oprationAnchor];
}

- (void)setScrollView:(UIScrollView *)scrollView{
    _scrollView = scrollView;
    _show_MAX_X = scrollView.frame.size.width;
    _scrollViewContentInset = scrollView.contentInset;
}

- (NSMutableArray *)actionItems{
    if (!_actionItems) {
        _actionItems = [NSMutableArray array];
    }
    return _actionItems;
}

- (void)setNormalItems:(NSArray *)normalItems{
    _normalItems = normalItems;
    
    [self actionItemsOprationForSubCount];
    CGFloat unitWidth = self.width/ self.actionItems.count;
    for (int i = 0; i < self.actionItems.count; i++) {
        UIButton *button = self.actionItems[i];
        NSString *imageName = @"";
        if ([[normalItems[i] class] isSubclassOfClass:[NSString class]]) {
            imageName = normalItems[i];
        }
        UIImage *image = [UIImage imageNamed:imageName];
        [button setImage:image forState:UIControlStateNormal];
        button.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        button.width = unitWidth;
        button.centerX = unitWidth/ 2 + unitWidth * i;
        button.bottom = self.startLocation_Y;
    }
}

- (void)setHighlightItems:(NSArray *)highlightItems{
    for (int i = 0; i < self.actionItems.count; i++) {
        UIButton *button = self.actionItems[i];
        NSString *imageName = @"";
        if ([[highlightItems[i] class] isSubclassOfClass:[NSString class]]) {
            imageName = highlightItems[i];
        }
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    }
}

- (void)setShow_MIN_Y:(CGFloat)show_MIN_Y{
    _show_MIN_Y = show_MIN_Y;
    self.originY = show_MIN_Y;
}

- (void)setRefreshState:(JFRefreshState)refreshState{
    if (refreshState == _refreshState) return;
    //BOOL isFormNormal = refreshState == stateSlide && _refreshState == stateNormal;
    _refreshState = refreshState;
    
    switch (refreshState) {
        case stateNormal:
            
            break;
        case stateSlide:
            _isTouchOpration = NO;
            break;
        case stateTouch:
            _isTouchOpration = YES;
            [self toTouchOpration];
            break;
        default:
            break;
    }
    /**
    //果冻动画 暂时放弃 如果需要使用需要在 touch 操作返回 滑动操作时交换开始与结束值，会在后面更新
    if (refreshState != stateNormal && !isFormNormal) {
        [self startDisplayLinkAnimation];
    }
     */
}

#pragma mark - opration
#pragma mark opration For set get

- (void)actionItemsOprationForSubCount{
    NSInteger addCount = 0;
    
    if (self.normalItems.count < self.actionItems.count) {
        addCount = self.actionItems.count - self.normalItems.count;
        for (int i = 0; i < addCount; i++) {
            UIView *view = self.actionItems[0];
            [view removeFromSuperview];
            [self.actionItems removeObjectAtIndex:0];
        }
    }else{
        addCount = self.normalItems.count - self.actionItems.count;
        for (int i = 0; i < addCount; i++) {
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, kRefreshMultiplier * _baseHeight)];
            [button addTarget:self action:@selector(userTouchAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.topContentView addSubview:button];
            [self.actionItems addObject:button];
        }
    }
}

- (void)settingactionItemstateForSelectedIndex:(NSNumber *)index bottomLocation_Y:(NSNumber *)location_Y{
    for (int i = 0; i < self.actionItems.count; i++) {
        UIButton *button = self.actionItems[i];
        button.selected = NO;
        if (index) {
            button.selected = index.intValue == i;
        }
        if (location_Y) {
            button.bottom = location_Y.floatValue;
        }
    }
}

#pragma mark opration For Animation

- (void)updateStateForLocation:(CGPoint)location{
    if (location.y <= self.baseHeight + _startLocation_Y) {
        self.refreshState = stateNormal;
        [self shapeShowOpration];
    }else{
        self.topContentView.alpha = 1;
        self.backgroundView.alpha = _oprationAnchor.y/((kRefreshMultiplier + 1) * _baseHeight);
        if (location.y > (self.baseHeight + _startLocation_Y)
            && location.y <= _baseHeight * (kRefreshMultiplier + 1)){
            self.refreshState = stateSlide;
            [self oprationForSlideAction];
        }else if(location.y > _baseHeight * (kRefreshMultiplier + 1)){
            self.refreshState = stateTouch;
        }
    }
}

- (void)shapeShowOpration{
    if (_oprationAnchor.y > _baseHeight) {
        [self drawShapeLayerWithLocation:_oprationAnchor bottom_Y:_baseHeight isLastStraightLine:NO];
        [self settingactionItemstateForSelectedIndex:nil bottomLocation_Y:nil];
        [self settingactionItemsLocationForTouchLocation:_oprationAnchor];
        return;
    }
    [self drawShapeLayerWithLocation:_oprationAnchor bottom_Y:_baseHeight isLastStraightLine:YES];
    [self settingactionItemstateForSelectedIndex:nil bottomLocation_Y:@(_baseHeight)];
    CGFloat alpha = _location.y/ self.startLocation_Y;
    self.topContentView.alpha = alpha;
}

- (void)drawShapeLayerWithLocation:(CGPoint)location bottom_Y:(CGFloat)bottom_Y
                isLastStraightLine:(BOOL)isLastStraightLine{
    if (location.y > kRefreshMultiplier * _baseHeight) {
        bottom_Y += (location.y - kRefreshMultiplier * _baseHeight) * 2;
        bottom_Y = MIN(kRefreshMultiplier * _baseHeight, bottom_Y);
        location.y = _baseHeight * kRefreshMultiplier;
    }
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(_show_MIN_X, bottom_Y)];
    [bezierPath addLineToPoint:CGPointZero];
    [bezierPath addLineToPoint:CGPointMake(_show_MAX_X, 0)];
    [bezierPath addLineToPoint:CGPointMake(_show_MAX_X, bottom_Y)];
    if (isLastStraightLine) {
        [bezierPath addLineToPoint:CGPointMake(_show_MIN_X, bottom_Y)];
    }else{
        [bezierPath addQuadCurveToPoint:CGPointMake(_show_MIN_X, bottom_Y)
                           controlPoint:location];
    }
    [bezierPath containsPoint:CGPointZero];
    
    self.shapeLayer.path = bezierPath.CGPath;
}

- (void)startDisplayLinkAnimation{
    //果冻动画 暂时放弃 如果需要使用需要在 touch 操作返回 滑动操作时交换开始与结束值，会在后面更新
    _displayCount = 0;
    _displayKey = 0;
    _nextPoint = _baseHeight;
    _beginPoint = _baseHeight;
    _targetPoint = _baseHeight * 2;
    if (self.displayLink) {
        [self.displayLink removeFromRunLoop:[NSRunLoop currentRunLoop]  forMode:NSRunLoopCommonModes];
        [self.displayLink invalidate];
    }
    CADisplayLink *display = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateAnimationForDisplayLink:)];
    [display addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    self.displayLink = display;
}

#pragma mark opration For UserOpration
- (void)oprationForSlideAction{
    [self oprationForOffset_X:_location.x];
    
    [self drawShapeLayerWithLocation:_oprationAnchor bottom_Y:_baseHeight isLastStraightLine:NO];
    [self settingactionItemsLocationForTouchLocation:_oprationAnchor];
}

- (void)oprationForOffset_X:(CGFloat)offset_X{
    if (self.actionItems.count <= 0) return;
    CGFloat unitWidth = _show_MAX_X/ self.actionItems.count;
    NSInteger index = offset_X/ unitWidth;
    for (int i = 0; i < self.actionItems.count; i++) {
        UIButton *button = self.actionItems[i];
        button.selected = index == i;
    }
}

- (void)settingactionItemsLocationForTouchLocation:(CGPoint)location{
    CGFloat bottom_Y = _baseHeight;
    if (location.y > kRefreshMultiplier * _baseHeight) {
        bottom_Y += (location.y - kRefreshMultiplier * _baseHeight) * 2;
        bottom_Y = MIN(kRefreshMultiplier * _baseHeight, bottom_Y);
        location.y = _baseHeight * kRefreshMultiplier;
    }
    for (UIButton *button in self.actionItems) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            CGFloat location_Y = [self locationForBezierInPoint:location location_X:button.centerX bottom_Y:bottom_Y];
            dispatch_async(dispatch_get_main_queue(), ^{
                float minSpace = _show_MAX_X * 0.01;
                button.bottom = location_Y - minSpace;
            });
        });
    }
}

- (void)toTouchOpration{
    [self drawShapeLayerWithLocation:CGPointZero bottom_Y:_baseHeight * kRefreshMultiplier isLastStraightLine:YES];
    [self settingactionItemstateForSelectedIndex:nil bottomLocation_Y:@(_baseHeight * kRefreshMultiplier)];
}

#pragma mark opration for end
- (void)resume{
    if ([self userTouchEnd]) return;
    
    for (UIButton *button in self.actionItems) {
        if (button.selected) {
            self.actionOfIndex([self.actionItems indexOfObject:button]);
        }
    }
    [UIView animateWithDuration:0.15 animations:^{
        if (self.scrollView.contentInset.top != self.scrollViewContentInset.top) {
            self.scrollView.contentInset = self.scrollViewContentInset;
        }
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.alpha = 1;
        _isLoaded = NO;
        [self.actionItems enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
            button.originY = 0;
            button.selected = NO;
            self.backgroundView.alpha = 0;
        }];
    }];
}

- (BOOL)userTouchEnd{
    if (_isTouchOpration) {
        UIEdgeInsets edgeInsets = self.scrollViewContentInset;
        edgeInsets.top = _baseHeight * kRefreshMultiplier;
        self.scrollView.contentInset = edgeInsets;
        [self.scrollView setContentOffset:CGPointMake(0, -_baseHeight * kRefreshMultiplier) animated:YES];
        return YES;
    }
    return NO;
}

#pragma mark - user touch action
- (void)userTouchAction:(UIButton *)sender{
    NSInteger index = [self.actionItems indexOfObject:sender];
    self.actionOfIndex(index);
}

- (void)tapContentViewAction:(UITapGestureRecognizer *)tap{
    
}

#pragma mark - gestureRecognizer Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (_isTouchOpration) {
        _isTouchOpration = NO;
        [self resume];
    }
    return YES;
}

#pragma mark - bezier point

- (CGFloat)locationForBezierInPoint:(CGPoint)point
                         location_X:(CGFloat)location_X
                           bottom_Y:(CGFloat)bottom_Y{
    CGPoint p1 = CGPointMake(0, bottom_Y); //起点
    CGPoint cp = point; //初始的控制点
    CGPoint p2 = CGPointMake(_show_MAX_X, bottom_Y); //初始的终点
    
    float t = 0;
    
    float c1x; //将要求出的控制点的x
    float c1y; //将要求出的控制点的y
    float c2x; //将要求出的终点的x
    float c2y; //将要求出的终点的y
    
    float px; //二次贝赛尔曲线上的点的x
    float py; //二次贝赛尔曲线上的点的y
    
    float minSpace = _show_MAX_X * 0.01;
    
    while ( t < 1 ) {
        /*
         控制点是由起点和初始的控制点组成的一次／线性贝赛尔曲线上的点,
         所以由一次／线性贝赛尔曲线函数表达式求出c1x,c1y
         */
        c1x = p1.x + ( cp.x - p1.x ) * t;
        c1y = p1.y + ( cp.y - p1.y ) * t;
        
        /*
         终点是由初始的控制点和初始的终点组成的一次／线性贝赛尔曲线上的点,
         所以由一次／线性贝赛尔曲线函数表达式求出c2x,c2y
         */
        c2x = cp.x + ( p2.x - cp.x ) * t;
        c2y = cp.y + ( p2.y - cp.y ) * t;
        
        /*
         二次贝赛尔曲线上的点是由控制点和终点组成的一次／线性贝赛尔曲线上的点,
         所以由一次／线性贝赛尔曲线函数表达式求出px,py
         */
        px = c1x + ( c2x - c1x ) * t;
        py = c1y + ( c2y - c1y ) * t;
        
        if (-minSpace < (location_X - px) &&  (location_X - px) < minSpace) {
            return py;
        }
        t += 0.01f;
    }
    return 0.0;
}

#pragma mark - animation for displayLink
- (void)updateAnimationForDisplayLink:(CADisplayLink *)display{
    //果冻动画 暂时放弃 如果需要使用需要在 touch 操作返回 滑动操作时交换开始与结束值，会在后面更新
    if (_displayKey > 5) {
        _displayKey = 0;
        _previousPoint = _nextPoint;
        NSInteger direction = -1;
        for (int i = 0; i < _displayCount; i++) {
            direction *= -1;
        }
        _nextPoint = _targetPoint + (_targetPoint - _beginPoint)/ ((CGFloat)(++_displayCount + 1) * direction * 1.5);
        NSLog(@"%@", display);
    }
    if ((_targetPoint - _nextPoint) < 5 && (_targetPoint - _nextPoint) > -5) {
        [display removeFromRunLoop:[NSRunLoop currentRunLoop]  forMode:NSRunLoopCommonModes];
        [display invalidate];
        return;
    }
    _displayKey ++;
    CGFloat currentPoint = _previousPoint + (_nextPoint - _previousPoint) * _displayKey/ 5;
    [self drawShapeLayerWithBottom:currentPoint location_Y:_baseHeight * 2];
}

- (void)drawShapeLayerWithBottom:(CGFloat)bottom location_Y:(CGFloat)location_Y{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(_show_MIN_X, bottom)];
    [bezierPath addLineToPoint:CGPointZero];
    [bezierPath addLineToPoint:CGPointMake(_show_MAX_X, 0)];
    [bezierPath addLineToPoint:CGPointMake(_show_MAX_X, bottom)];
    [bezierPath addQuadCurveToPoint:CGPointMake(_show_MIN_X, bottom)
                       controlPoint:CGPointMake(_location.x, location_Y)];
    [bezierPath containsPoint:CGPointZero];
    
    self.shapeLayer.path = bezierPath.CGPath;
}

@end
