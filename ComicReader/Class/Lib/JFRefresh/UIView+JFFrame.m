//
//  UIView+JFFrame.m
//  RefreshDemo
//
//  Created by Mr_J on 16/3/6.
//  Copyright © 2016年 Mr_J. All rights reserved.
//

#import "UIView+JFFrame.h"

@implementation UIView (JFFrame)

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setOriginX:(CGFloat)originX{
    CGRect frame = self.frame;
    frame.origin.x = originX;
    self.frame = frame;
}

- (CGFloat)originX{
    return self.frame.origin.x;
}

- (void)setOriginY:(CGFloat)originY{
    CGRect frame = self.frame;
    frame.origin.y = originY;
    self.frame = frame;
}

- (CGFloat)originY{
    return self.frame.origin.y;
}

- (void)setBottom:(CGFloat)bottom{
    self.originY = bottom - self.height;
}

- (CGFloat)bottom{
    return self.originY + self.height;
}

- (void)setRight:(CGFloat)right{
    self.originX = right - self.width;
}

- (CGFloat)right{
    return self.originX + self.width;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY{
    return self.center.y;
}

@end
