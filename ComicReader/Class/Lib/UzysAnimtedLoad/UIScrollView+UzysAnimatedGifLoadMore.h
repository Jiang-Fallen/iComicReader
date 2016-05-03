//
//  UIScrollView+UzysAnimatedGifLoadMore.h
//  UzysAnimatedGifLoadMore
//
//  Created by Uzysjung on 2014. 9. 25..
//  Copyright (c) 2014년 Uzys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UzysAnimtedGifLoadMoreView.h"
@interface UIScrollView (UzysAnimatedGifLoadMore)
@property (nonatomic,assign) BOOL showLoadMore;
@property (nonatomic,assign) BOOL loadMoreAlphaTransition;
@property (nonatomic,assign) BOOL loadMoreVariableSize;
@property (nonatomic,strong) UzysAnimtedGifLoadMoreView *loadMoreView;
@property (nonatomic,assign) UIActivityIndicatorViewStyle loadMoreActivityIndcatorStyle;
//frameRate [1-30];
- (void)addLoadMoreActionHandler:(loadMoreActionHandler)handler
                       ProgressImages:(NSArray *)progressImages
                        LoadingImages:(NSArray *)loadingImages
              ProgressScrollThreshold:(NSInteger)threshold
               LoadingImagesFrameRate:(NSInteger)lframe;

- (void)addLoadMoreActionHandler:(loadMoreActionHandler)handler
                       ProgressImages:(NSArray *)progressImages
              ProgressScrollThreshold:(NSInteger)threshold;

- (void)addLoadMoreActionHandler:(loadMoreActionHandler)handler
                ProgressImagesGifName:(NSString *)progressGifName
              ProgressScrollThreshold:(NSInteger)threshold;

- (void)addLoadMoreActionHandler:(loadMoreActionHandler)handler
                ProgressImagesGifName:(NSString *)progressGifName
                 LoadingImagesGifName:(NSString *)loadingGifName
              ProgressScrollThreshold:(NSInteger)threshold;

- (void)addLoadMoreActionHandler:(loadMoreActionHandler)handler
                ProgressImagesGifName:(NSString *)progressGifName
                 LoadingImagesGifName:(NSString *)loadingGifName
              ProgressScrollThreshold:(NSInteger)threshold
                LoadingImageFrameRate:(NSInteger)frameRate;

- (void)removeLoadMoreActionHandler;

- (void)triggerLoadMoreActionHandler;
- (void)stopLoadMoreAnimation;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com