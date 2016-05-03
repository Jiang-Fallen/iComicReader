//
//  JFRefreshControl.h
//  RefreshDemo
//
//  Created by Mr_J on 16/3/5.
//  Copyright © 2016年 Mr_J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFRefreshControl : UIControl

@property (nonatomic, assign) CGFloat baseHeight; //头视图基准高度 default == 64
@property (nonatomic, assign) CGFloat show_MIN_Y; //视图开始位置
@property (nonatomic, assign) CGFloat startLocation_Y; //开始曲线变换的值
@property (nonatomic, assign) CGFloat topShadowAlpha; //顶部shapeLayer阴影透明度
//ImageNamed Array  Type == NSString
@property (nonatomic) NSArray *normalItems; //常态下按钮图片数组
@property (nonatomic) NSArray *highlightItems; //高亮下按钮图片数组
@property (nonatomic, weak) void (^actionOfIndex)(NSInteger index);

- (void)registerFromScrollView:(UIScrollView *)scrollView;
- (void)removeFromScrollView;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView;

@end
