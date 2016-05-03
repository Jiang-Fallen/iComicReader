//
//  UIView+JFFrame.h
//  RefreshDemo
//
//  Created by Mr_J on 16/3/6.
//  Copyright © 2016年 Mr_J. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kScreen_Height  [UIScreen mainScreen].bounds.size.height

@interface UIView (JFFrame)

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat originX;
@property (nonatomic, assign) CGFloat originY;

@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@end
