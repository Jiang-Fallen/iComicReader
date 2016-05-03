//
//  UzysAnimtedGifLoadMoreView.m
//  UzysAnimatedGifLoadMore
//
//  Created by Uzysjung on 2014. 9. 25..
//  Copyright (c) 2014년 Uzys. All rights reserved.
//
/*
 1. 기능 x position offset
 2. Delegate 1. contentsize change 2. trigger , 3. 원래 상태.
 3. background View 받기 trigger 되기전 과 후. 2벌
 
 */

#import "UzysAnimtedGifLoadMoreView.h"
#import "UIScrollView+UzysAnimatedGifLoadMore.h"
#import "UzysAnimatedGifLoadMoreConfiguration.h"
@interface UzysAnimtedGifLoadMoreView()
@property (nonatomic,strong) UIImageView *_imageViewProgress;
@property (nonatomic,strong) UIImageView *_imageViewLoading;
@property (nonatomic,strong) NSArray *_pImgArrProgress;
@property (nonatomic,strong) NSArray *_pImgArrLoading;
@property (nonatomic, strong) UIActivityIndicatorView *_activityIndicatorView;  //Loading Indicator
@property (nonatomic, assign) double _progress;
@property (nonatomic, assign) NSInteger _progressThreshold;
@property (nonatomic, assign) NSInteger _loadingFrameRate;

- (void)_commonInit;
- (void)_initAnimationView;

- (void)_setFrameSizeByProgressImage;
- (void)_setFrameSizeByLoadingImage;
- (void)_setScrollViewContentInset:(UIEdgeInsets)contentInset handler:(loadMoreActionHandler)handler animation:(BOOL)animation;

- (void)_setupScrollViewContentInsetForLoadingIndicator:(loadMoreActionHandler)handler animation:(BOOL)animation;
- (void)_resetScrollViewContentInset:(loadMoreActionHandler)handler animation:(BOOL)animation;

- (void)_actionStopState;
- (void)_actionTriggeredState;
@end

@implementation UzysAnimtedGifLoadMoreView


- (id)initWithProgressImages:(NSArray *)progressImg LoadingImages:(NSArray *)loadingImages ProgressScrollThreshold:(NSInteger)threshold LoadingImagesFrameRate:(NSInteger)lFrameRate {
    if(threshold <=0) {
        threshold = initialLoadMoreThreshold;
    }
    UIImage *image = progressImg.firstObject;
    CGRect initialRect = CGRectMake(0, 0, image.size.width, image.size.height);
    initialRect = CGRectOffset(initialRect, 2, 2);
    self = [super initWithFrame:initialRect];
    if(self) {
        self.layer.zPosition = -1;
        self._pImgArrProgress = progressImg;
        self._pImgArrLoading = loadingImages;
        self._progressThreshold = threshold;
        self._loadingFrameRate = lFrameRate;
        [self _commonInit];
        
    }
    return self;
}
#pragma mark - private Method
- (void)_commonInit {
    self.activityIndicatorStyle = UIActivityIndicatorViewStyleGray;
    self.contentMode = UIViewContentModeRedraw;
    
    
    self.state = UZYSGIFLoadMoreStateNone;
    self.backgroundColor = [UIColor clearColor];
    
    NSAssert([self._pImgArrProgress.lastObject isKindOfClass:[UIImage class]], @"pImgArrProgress Array has object that is not image");
    self._imageViewProgress = [[UIImageView alloc] initWithImage:[self._pImgArrProgress lastObject]];
    self._imageViewProgress.contentMode = UIViewContentModeScaleAspectFit;
    self._imageViewProgress.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    self._imageViewProgress.frame = self.bounds;
    self._imageViewProgress.backgroundColor = [UIColor clearColor];
    [self addSubview:self._imageViewProgress];
    
    if(self._pImgArrLoading==nil)
    {
        self._activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorStyle];
        self._activityIndicatorView.hidesWhenStopped = YES;
        self._activityIndicatorView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
        self._activityIndicatorView.frame = self.bounds;
        self._activityIndicatorView.alpha = 0.0f;
        [self addSubview:self._activityIndicatorView];
    }
    else
    {
        NSAssert([self._pImgArrLoading.lastObject isKindOfClass:[UIImage class]], @"pImgArrLoading Array has object that is not image");
        self._imageViewLoading = [[UIImageView alloc] initWithImage:[self._pImgArrLoading firstObject]];
        self._imageViewLoading.contentMode = UIViewContentModeScaleAspectFit;
        self._imageViewLoading.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
        self._imageViewLoading.frame = self.bounds;
        self._imageViewLoading.animationImages = self._pImgArrLoading;
        self._imageViewLoading.animationDuration = (CGFloat)ceilf((1.0/(CGFloat)self._loadingFrameRate) * (CGFloat)self._imageViewLoading.animationImages.count);
        self._imageViewLoading.alpha = 0.0f;
        self._imageViewLoading.backgroundColor = [UIColor clearColor];
        [self addSubview:self._imageViewLoading];
    }
    
    self.alpha = 0.0f;
    [self _initAnimationView];
    
}

- (void)_initAnimationView {
    
    if(self._pImgArrLoading.count>0)
    {
        self._imageViewLoading.transform = CGAffineTransformIdentity;
        [self._imageViewLoading stopAnimating];
        self._imageViewLoading.alpha = 0.0f;
        
    }
    else
    {
        self._activityIndicatorView.transform = CGAffineTransformIdentity;
        [self._activityIndicatorView stopAnimating];
        self._activityIndicatorView.alpha = 0.0f;
    }
    //    self.alpha = 0.0f;
}

- (void)_setFrameSizeByProgressImage {
    UIImage *image1 = self._pImgArrProgress.lastObject;
    if(image1)
        self.frame = CGRectMake((self.scrollView.bounds.size.width - image1.size.width)/2, self.frame.origin.y, image1.size.width, image1.size.height);

}
- (void)_setFrameSizeByLoadingImage {
    UIImage *image1 = self._pImgArrLoading.lastObject;
    if(image1)
    {
        self.frame = CGRectMake((self.scrollView.bounds.size.width - image1.size.width)/2,  self.frame.origin.y, image1.size.width, image1.size.height);
    }

}
#pragma mark - override UIView
- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (self.superview && newSuperview == nil) {
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        if (scrollView.showLoadMore) {
            if (self.isObserving) {
                [scrollView removeObserver:self forKeyPath:@"contentOffset"];
                [scrollView removeObserver:self forKeyPath:@"contentSize"];
                [scrollView removeObserver:self forKeyPath:@"frame"];
                [scrollView.layer removeObserver:self forKeyPath:@"bounds"];
                self.isObserving = NO;
            }
        }
    }
}
- (void)didMoveToSuperview
{

}
- (void) dealloc
{
    self._imageViewLoading = nil;
    self._imageViewProgress = nil;
    self._pImgArrLoading = nil;
    self._pImgArrProgress = nil;
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    [self setSize:self.bounds.size];
}
#pragma mark - Property
- (void)set_progress:(double)_progress {
    static double prevProgress;
    if(_progress > 1.0f)
    {
        _progress = 1.0f;
    }
    if(_progress < 0.0f)
    {
        _progress = 0.0f;
    }
    
    if(self.showAlphaTransition)
    {
        if(self.state < UZYSGIFLoadMoreStateTriggered)
            self.alpha = 1.0 * _progress;
        else
            self.alpha = 1.0;
        
//        NSLog(@"self.alpha %f",self.alpha);
    }
    else
    {
        CGFloat alphaValue = 1.0 * _progress *5;
        if(alphaValue > 1.0)
            alphaValue = 1.0f;
        if(self.state < UZYSGIFLoadMoreStateTriggered)
            self.alpha = alphaValue;
        else
            self.alpha = 1.0;
    }
//     NSLog(@"self.alpha %f",self.alpha);
    if (_progress >= 0.0f && _progress <=1.0f) {
        //Animation
        NSInteger index = (NSInteger)roundf((self._pImgArrProgress.count ) * _progress);
        if(index ==0)
        {
            self._imageViewProgress.image = nil;
        }
        else
        {
            self._imageViewProgress.image = [self._pImgArrProgress objectAtIndex:index-1];
        }
    }
    __progress = _progress;
    prevProgress = _progress;
    
}

#pragma mark - Key Value Observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"contentOffset"])
    {
        [self _scrollViewDidScroll:[[change valueForKey:NSKeyValueChangeNewKey] CGPointValue]];
    }
    else if([keyPath isEqualToString:@"contentSize"])
    {
//        NSLog(@"self.frame %@",NSStringFromCGRect(self.scrollView.frame));
        [self setNeedsLayout];
        [self setNeedsDisplay];
    }
    else if([keyPath isEqualToString:@"frame"])
    {
        
        [self setNeedsLayout];
        [self setNeedsDisplay];
    }
    else if ([keyPath isEqualToString:@"bounds"])
    {
        [self setNeedsLayout];
        [self setNeedsDisplay];
        if(!CGSizeEqualToSize([change[@"new"] CGRectValue].size,[change[@"old"] CGRectValue].size ))
        {
            [self _setFrameSizeByProgressImage];
        }

    }
}
- (void)_scrollViewDidScroll:(CGPoint)contentOffset
{
    static double prevProgress;
    if(self.scrollView.frame.size.height <= self.scrollView.contentSize.height) {
        self.alpha = 1;
    } else {
        self.alpha = 0;
        return;
    }
    
    CGFloat yOffset = (contentOffset.y + self.scrollView.bounds.size.height) - self.scrollView.contentSize.height  ;
    self._progress = ((yOffset - LoadMoreStartPosition)/self._progressThreshold);
//    NSLog(@"progress:%f",__progress);
//    NSLog(@"state:%d",self.state);
    self.center = CGPointMake(roundf(self.center.x), roundf(self.scrollView.contentSize.height + (yOffset - self.originalBottomInset)/2 ) - 10);
    switch (_state) {
        case UZYSGIFLoadMoreStateNone: //detect action (0)
        {
            if(self.scrollView.isDragging && self._progress > 0.0000f )
            {
                self._imageViewProgress.alpha = 1.0f;
                [self _setFrameSizeByProgressImage];
                self.state = UZYSGIFLoadMoreStateTriggering;
            }
            break;
        }
        case UZYSGIFLoadMoreStateStopped: //finish (1)
            break;
        case UZYSGIFLoadMoreStateTriggering: //progress (2)
        {
            if(self._progress >= 1.0f)
                self.state = UZYSGIFLoadMoreStateTriggered;
        }
            break;
        case UZYSGIFLoadMoreStateTriggered: //fire actionhandler (3)
            if(self.scrollView.isDragging == NO && prevProgress > 0.98f)
            {
                [self _actionTriggeredState];
            }
            break;
        case UZYSGIFLoadMoreStateLoading: //wait until stopIndicatorAnimation (4)
            break;
        case UZYSGIFLoadMoreStateCanFinish: //(5)
            if(yOffset < 0.01f  && yOffset > -0.01f )
            {
                self.state = UZYSGIFLoadMoreStateNone;
            }
            break;
        default:
            break;
    }
    //because of iOS6 KVO performance
    prevProgress = self._progress;
    
}


#pragma mark - LoadMore State Method
-(void)_actionStopState {
    if (self.state == UZYSGIFLoadMoreStateNone) {
        return;
    }
    self.state = UZYSGIFLoadMoreStateNone;
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction animations:^{
        if(self._pImgArrLoading.count>0)
        {
            self._imageViewLoading.transform = CGAffineTransformMakeScale(0.1, 0.1);
        }
        else
        {
            self._activityIndicatorView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        }
    } completion:^(BOOL finished) {
        
    }];
    
    [self _resetScrollViewContentInset:^{
    } animation:YES];
    
    [self _initAnimationView];
}
-(void)_actionTriggeredState {
    self.state = UZYSGIFLoadMoreStateLoading;

    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionLayoutSubviews animations:^{

        self._imageViewProgress.alpha = 0.0f;

        if(self.isVariableSize)
        {
            [self _setFrameSizeByLoadingImage];
        }
        if(self._pImgArrLoading.count>0)
        {
            self._imageViewLoading.alpha = 1.0f;
        }
        else
        {
            self._activityIndicatorView.alpha = 1.0f;
        }
        
    } completion:^(BOOL finished) {
        
    }];
    
    if(self._pImgArrLoading.count>0)
    {
        [self._imageViewLoading startAnimating];
    }
    else
    {
        [self._activityIndicatorView startAnimating];
    }
    
    [self _setupScrollViewContentInsetForLoadingIndicator:^{
        
    } animation:YES];
    
    if(self.loadMoreHandler)
        self.loadMoreHandler();
}
#pragma mark - ScrollViewInset
- (void)_setupScrollViewContentInsetForLoadingIndicator:(loadMoreActionHandler)handler animation:(BOOL)animation
{
    
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    float idealOffset = self.originalBottomInset + self.bounds.size.height + 2 ;
    currentInsets.bottom = idealOffset;
    
    [self _setScrollViewContentInset:currentInsets handler:handler animation:animation];
}
- (void)_resetScrollViewContentInset:(loadMoreActionHandler)handler animation:(BOOL)animation
{
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    currentInsets.bottom = self.originalBottomInset;
    [self _setScrollViewContentInset:currentInsets handler:handler animation:animation];
}
- (void)_setScrollViewContentInset:(UIEdgeInsets)contentInset handler:(loadMoreActionHandler)handler animation:(BOOL)animation
{
    if(animation)
    {
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.scrollView.contentInset = contentInset;
                             if(self.isVariableSize) {
                                 self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentSize.height - self.scrollView.bounds.size.height+ contentInset.bottom);
                             }
                         }
                         completion:^(BOOL finished) {
                             if(handler)
                                 handler();
                         }];
    }
    else
    {
        self.scrollView.contentInset = contentInset;
        if(handler)
            handler();
    }
}
#pragma mark - Public Method

- (void)stopIndicatorAnimation {
    [self _actionStopState];
}

- (void)manuallyTriggered {

    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    currentInsets.bottom = self.originalBottomInset + self.bounds.size.height + 1.0f;
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction animations:^{
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentSize.height + currentInsets.bottom - self.scrollView.bounds.size.height);
    } completion:^(BOOL finished) {
        [self _actionTriggeredState];
    }];
}

- (void)setSize:(CGSize) size {
    CGRect rect = CGRectMake((self.scrollView.bounds.size.width - size.width)/2,
                             self.scrollView.contentSize.height, size.width, size.height);
    self.frame=rect;
    self._activityIndicatorView.frame = self.bounds;
    self._imageViewProgress.frame = self.bounds;
    self._imageViewLoading.frame = self.bounds;
}

- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle) style {
    if(self._activityIndicatorView)
    {
        _activityIndicatorStyle = style;
        [self._activityIndicatorView removeFromSuperview];
        self._activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
        self._activityIndicatorView.hidesWhenStopped = YES;
        [self insertSubview:self._activityIndicatorView belowSubview:self._imageViewProgress];
        self._activityIndicatorView.frame = self.bounds;
    }
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com