//
//  JFRefreshOpration.h
//  RefreshDemo
//
//  Created by Mr_J on 16/3/5.
//  Copyright © 2016年 Mr_J. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JFRefreshState) {
    stateNormal = 0,
    stateSlide,
    stateTouch
};


@interface JFRefreshOpration : UIView

@property (nonatomic, assign) CGPoint location; //scrollView.contentOffset对于ContentInset偏移量
@property (nonatomic, assign) CGFloat baseHeight; //头视图基准高度 default == 64
@property (nonatomic, assign) CGFloat show_MIN_Y; //视图开始位置
@property (nonatomic, assign) CGFloat startLocation_Y; //开始曲线变换的值
@property (nonatomic, assign) CGFloat topShadowAlpha; //顶部shapeLayer阴影透明度
@property (nonatomic, copy) void (^actionOfIndex)(NSInteger index);

@property (nonatomic, assign) JFRefreshState refreshState;

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *normalItems; //常态下按钮图片数组
@property (nonatomic, strong) NSArray *highlightItems; //高亮下按钮图片数组

- (void)resume;

@end
