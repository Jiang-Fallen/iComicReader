//
//  UzysAnimtedGifLoadMoreView.h
//  UzysAnimatedGifLoadMore
//
//  Created by Uzysjung on 2014. 9. 25..
//  Copyright (c) 2014년 Uzys. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^loadMoreActionHandler)(void);
typedef NS_ENUM(NSUInteger, UZYSLoadMoreState) {
    UZYSGIFLoadMoreStateNone =0,
    UZYSGIFLoadMoreStateStopped,
    UZYSGIFLoadMoreStateTriggering,
    UZYSGIFLoadMoreStateTriggered,
    UZYSGIFLoadMoreStateLoading,
    UZYSGIFLoadMoreStateCanFinish

};
@interface UzysAnimtedGifLoadMoreView : UIView
@property (nonatomic,assign) BOOL isObserving;
@property (nonatomic,assign) CGFloat originalBottomInset;

@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,copy) loadMoreActionHandler loadMoreHandler;
@property (nonatomic,assign) BOOL showAlphaTransition;
@property (nonatomic,assign) BOOL isVariableSize;
@property (nonatomic,assign) UIActivityIndicatorViewStyle activityIndicatorStyle;
@property (nonatomic,assign) UZYSLoadMoreState state;
- (id)initWithProgressImages:(NSArray *)progressImg LoadingImages:(NSArray *)loadingImages ProgressScrollThreshold:(NSInteger)threshold LoadingImagesFrameRate:(NSInteger)lFrameRate;
- (void)stopIndicatorAnimation;
- (void)manuallyTriggered;
- (void)setSize:(CGSize) size;
- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle) style;

//- (void)setFrameSizeByProgressImage;
//- (void)setFrameSizeByLoadingImage;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com