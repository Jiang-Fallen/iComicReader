//
//  UIScrollView+UzysAnimatedGifLoadMore.m
//  UzysAnimatedGifLoadMore
//
//  Created by Uzysjung on 2014. 9. 25..
//  Copyright (c) 2014년 Uzys. All rights reserved.
//

#import "UIScrollView+UzysAnimatedGifLoadMore.h"
#import <objc/runtime.h>
#define IS_IOS7 (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1 && floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1)
#define IS_IOS8  ([[[UIDevice currentDevice] systemVersion] compare:@"8" options:NSNumericSearch] != NSOrderedAscending)
#define IS_IPHONE6PLUS ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) && [[UIScreen mainScreen] nativeScale] == 3.0f)
#define cDefaultFloatComparisonEpsilon    0.001
#define cEqualFloats(f1, f2, epsilon)    ( fabs( (f1) - (f2) ) < epsilon )
#define cNotEqualFloats(f1, f2, epsilon)    ( !cEqualFloats(f1, f2, epsilon) )
static char UIScrollViewLoadMoreView;

@implementation UIScrollView (UzysAnimatedGifLoadMore)
@dynamic loadMoreView,loadMoreActivityIndcatorStyle;
- (void)addLoadMoreActionHandler:(loadMoreActionHandler)handler
                  ProgressImages:(NSArray *)progressImages
                   LoadingImages:(NSArray *)loadingImages
         ProgressScrollThreshold:(NSInteger)threshold
          LoadingImagesFrameRate:(NSInteger)lframe
{
    if(self.loadMoreView == nil)
    {
        UzysAnimtedGifLoadMoreView *view = [[UzysAnimtedGifLoadMoreView alloc] initWithProgressImages:progressImages LoadingImages:loadingImages ProgressScrollThreshold:threshold LoadingImagesFrameRate:lframe];
        view.loadMoreHandler = handler;
        view.scrollView = self;
        view.frame = CGRectMake((self.bounds.size.width - view.bounds.size.width)/2,
                                self.contentSize.height, view.bounds.size.width, view.bounds.size.height);
        view.originalBottomInset = self.contentInset.bottom;
        
        [self addSubview:view];
        [self sendSubviewToBack:view];
        self.loadMoreView = view;
        self.showLoadMore = YES;
    }
}

- (void)addLoadMoreActionHandler:(loadMoreActionHandler)handler
                  ProgressImages:(NSArray *)progressImages
         ProgressScrollThreshold:(NSInteger)threshold
{
    [self addLoadMoreActionHandler:handler
                         ProgressImages:progressImages
                          LoadingImages:nil
                ProgressScrollThreshold:threshold
                 LoadingImagesFrameRate:0];
}

- (void)addLoadMoreActionHandler:(loadMoreActionHandler)handler
           ProgressImagesGifName:(NSString *)progressGifName
         ProgressScrollThreshold:(NSInteger)threshold
{
    UIImage *progressImage = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath]  stringByAppendingPathComponent:progressGifName]];
    [self addLoadMoreActionHandler:handler
                         ProgressImages:progressImage.images
                ProgressScrollThreshold:threshold];

}

- (void)addLoadMoreActionHandler:(loadMoreActionHandler)handler
           ProgressImagesGifName:(NSString *)progressGifName
            LoadingImagesGifName:(NSString *)loadingGifName
         ProgressScrollThreshold:(NSInteger)threshold
{
    
    UIImage *progressImage = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath]  stringByAppendingPathComponent:progressGifName]];
    UIImage *loadingImage = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath]  stringByAppendingPathComponent:loadingGifName]];
    
    [self addLoadMoreActionHandler:handler
                         ProgressImages:progressImage.images
                          LoadingImages:loadingImage.images
                ProgressScrollThreshold:threshold
                 LoadingImagesFrameRate:(NSInteger)ceilf(1.0/(loadingImage.duration/loadingImage.images.count))];

    

    
}

- (void)addLoadMoreActionHandler:(loadMoreActionHandler)handler
           ProgressImagesGifName:(NSString *)progressGifName
            LoadingImagesGifName:(NSString *)loadingGifName
         ProgressScrollThreshold:(NSInteger)threshold
           LoadingImageFrameRate:(NSInteger)frameRate
{
    UIImage *progressImage = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath]  stringByAppendingPathComponent:progressGifName]];
    UIImage *loadingImage = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath]  stringByAppendingPathComponent:loadingGifName]];

    [self addLoadMoreActionHandler:handler
                         ProgressImages:progressImage.images
                          LoadingImages:loadingImage.images
                ProgressScrollThreshold:threshold
                 LoadingImagesFrameRate:frameRate];
    
}

- (void)removeLoadMoreActionHandler
{
    self.showLoadMore = NO;
    [self.loadMoreView removeFromSuperview];
    self.loadMoreView = nil;
}

- (void)triggerLoadMoreActionHandler
{
    [self.loadMoreView manuallyTriggered];
}
- (void)stopLoadMoreAnimation
{
    [self.loadMoreView stopIndicatorAnimation];
}


#pragma mark - property
- (void)setLoadMoreView:(UzysAnimtedGifLoadMoreView *)loadMoreView
{
    [self willChangeValueForKey:@"UzysAnimtedGifLoadMoreView"];
    objc_setAssociatedObject(self, &UIScrollViewLoadMoreView, loadMoreView, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"UzysAnimtedGifLoadMoreView"];
}
- (UzysAnimtedGifLoadMoreView *)loadMoreView
{
    return objc_getAssociatedObject(self, &UIScrollViewLoadMoreView);
}
- (void)setShowLoadMore:(BOOL)showLoadMore
{
    self.loadMoreView.hidden = !showLoadMore;
    
    if(showLoadMore)
    {
        if(!self.loadMoreView.isObserving)
        {
            [self addObserver:self.loadMoreView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
            [self addObserver:self.loadMoreView forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
            [self addObserver:self.loadMoreView forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
            [self.layer addObserver:self.loadMoreView forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
            self.loadMoreView.isObserving = YES;
        }
    }
    else
    {
        if(self.loadMoreView.isObserving)
        {
            [self removeObserver:self.loadMoreView forKeyPath:@"contentOffset"];
            [self removeObserver:self.loadMoreView forKeyPath:@"contentSize"];
            [self removeObserver:self.loadMoreView forKeyPath:@"frame"];
            [self.layer removeObserver:self.loadMoreView forKeyPath:@"bounds"];
            self.loadMoreView.isObserving = NO;
        }
    }
}

- (BOOL)showLoadMore
{
    return !self.loadMoreView.hidden;
}

- (void)setLoadMoreAlphaTransition:(BOOL)loadMoreAlphaTransition
{
    self.loadMoreView.showAlphaTransition = loadMoreAlphaTransition;
}
- (BOOL)loadMoreAlphaTransition
{
    return self.loadMoreView.showAlphaTransition;
}
- (void)setLoadMoreVariableSize:(BOOL)loadMoreVariableSize
{
    self.loadMoreView.isVariableSize = loadMoreVariableSize;
}
-(BOOL)loadMoreVariableSize
{
    return self.loadMoreView.isVariableSize;
}
- (void)setLoadMoreActivityIndcatorStyle:(UIActivityIndicatorViewStyle)loadMoreActivityIndcatorStyle
{
    [self.loadMoreView setActivityIndicatorViewStyle:loadMoreActivityIndcatorStyle];
}
- (UIActivityIndicatorViewStyle)loadMoreActivityIndcatorStyle
{
    return self.loadMoreView.activityIndicatorStyle;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com