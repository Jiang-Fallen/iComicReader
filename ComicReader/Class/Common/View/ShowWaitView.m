//
//  ShowWaitView.m
//  ComicReader
//
//  Created by Jiang on 14/12/11.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ShowWaitView.h"
#import "MONActivityIndicatorView.h"
#import "Reachability.h"

typedef enum {
    waitStatic = 0,
    errorStatic
}ShowStatic;

@interface ShowWaitView () <MONActivityIndicatorViewDelegate>
@property (nonatomic, copy) void (^operation)();
@property (nonatomic, strong) UIImageView *imageErrorView;

@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) Reachability *wifiReachability;

@end

@implementation ShowWaitView

- (instancetype)initWithOperation:(void(^)())operation{
    CGRect rect = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    if (self = [super initWithFrame:rect]) {
        [self setBackGround];
        self.layer.zPosition = 5;
        [self addSubview:self.indicatorView];
        [self addSubview:self.label];
        [self addNotificationServer];
        self.operation = operation;
    }
    return self;
}

- (MONActivityIndicatorView *)indicatorView{
    if (_indicatorView == nil) {
        _indicatorView = [[MONActivityIndicatorView alloc] init];
        _indicatorView.delegate = self;
        _indicatorView.numberOfCircles = 6;
        _indicatorView.radius = 6;
        _indicatorView.internalSpacing = 3;
        _indicatorView.center = CGPointMake(kScreenWidth/2, (kScreenHeight - kToolBarHeight - kNavicationBarHeigth)/2);
    }
    return _indicatorView;
}

- (UILabel *)label{
    if (_label == nil) {
        CGFloat y = self.indicatorView.frame.origin.y + self.indicatorView.frame.size.height;
        CGRect rect = CGRectMake(0, 0, 200, 50);
        
        _label = [[UILabel alloc]initWithFrame:rect];
        _label.layer.position = CGPointMake(kScreenWidth/2, y);
        _label.layer.anchorPoint = CGPointMake(0.5, 0);
        _label.font = [UIFont systemFontOfSize:14];
        _label.textColor = [UIColor lightGrayColor];
        _label.numberOfLines = 0;
        [_label setTextAlignment:NSTextAlignmentCenter];
    }
    return _label;
}

- (UIImageView *)imageErrorView{
    if (_imageErrorView == nil) {
        UIImage *image = [UIImage imageNamed:@"data_loading_error"];
        _imageErrorView = [[UIImageView alloc]initWithImage:image];
        _imageErrorView.layer.position = self.label.layer.position;
        _imageErrorView.layer.anchorPoint = CGPointMake(0.5, 1);
        _imageErrorView.hidden = YES;
        [self insertSubview:_imageErrorView atIndex:0];
    }
    return _imageErrorView;
}

#pragma mark - showError
- (void)showError{
    [self.indicatorView stopAnimating];
    self.label.text = @"点击重试";
    self.imageErrorView.hidden = NO;
    self.indicatorView.hidden = YES;
    self.userInteractionEnabled = YES;
    
    CGFloat y = self.indicatorView.frame.origin.y + self.imageErrorView.bounds.size.height/2;
    CGPoint labelPosition = CGPointMake(kScreenWidth/2, y);
    self.label.layer.position = labelPosition;
    self.imageErrorView.center = labelPosition;
}

#pragma mark - showWait
- (void)showWait{
    [_indicatorView startAnimating];
    self.label.transform = CGAffineTransformIdentity;
    self.label.text = @"正在拼命加载数据\n请稍候!";
    self.indicatorView.hidden = NO;
    self.imageErrorView.hidden = YES;
    self.userInteractionEnabled = NO;
    self.operation();
    
    CGFloat y = self.indicatorView.frame.origin.y + self.indicatorView.frame.size.height;
    CGPoint labelPosition = CGPointMake(kScreenWidth/2, y);
    self.label.layer.position = labelPosition;
}

#pragma mark - MONActivityIndicatorViewDelegate设置进度条颜色

- (UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView
      circleBackgroundColorAtIndex:(NSUInteger)index {
    CGFloat red   = (arc4random() % 256)/255.0;
    CGFloat green = (arc4random() % 256)/255.0;
    CGFloat blue  = (arc4random() % 256)/255.0;
    CGFloat alpha = 1.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (void)setOperation:(void (^)())operation{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showWait)];
    [self addGestureRecognizer:gesture];
    _operation = operation;
}

- (void)addNotificationServer{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showWait) name:kReachabilityChangedNotification object:nil];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    //[self updateInterfaceWithReachability:self.internetReachability];
    
    //self.wifiReachability = [Reachability reachabilityForLocalWiFi];
    //[self.wifiReachability startNotifier];
    //[self updateInterfaceWithReachability:self.wifiReachability];
}

- (void)setBackGround{
    UIImage *image = [UIImage imageNamed:@"back_day.png"];
    self.layer.contents = (id)image.CGImage;
}

- (void)removeNotifacationServer{
    [self.internetReachability stopNotifier];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kReachabilityChangedNotification object:nil];
}
- (void)dealloc{
    [self removeNotifacationServer];
}
@end
