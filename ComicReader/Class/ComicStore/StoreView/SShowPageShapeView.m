//
//  SShowPageShapeView.m
//  Wefafa
//
//  Created by Mr_J on 16/1/21.
//  Copyright © 2016年 metersbonwe. All rights reserved.
//

#import "SShowPageShapeView.h"

@interface SShowPageShapeView ()

@property (nonatomic, strong) CALayer *selectedLayer;
@property (nonatomic, strong) CAShapeLayer *showPageLayer;

@end

@implementation SShowPageShapeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews{
    self.backgroundColor = [UIColor blackColor];
    
    _selectedLayer = [CALayer layer];
    _selectedLayer.frame = CGRectMake(0, 0, 20, 2);
    _selectedLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:_selectedLayer];
    
    _showPageLayer = [CAShapeLayer layer];
    _showPageLayer.strokeColor = [UIColor blackColor].CGColor;
    _showPageLayer.lineWidth = 4;
    self.layer.mask = _showPageLayer;
}

- (void)setPageWidth:(CGFloat)pageWidth{
    _pageWidth = pageWidth;
    _selectedLayer.frame = CGRectMake(0, 0, pageWidth, 2);
    [self showPage];
}

- (void)setPageSize:(NSInteger)pageSize{
    _pageSize = pageSize;
    [self showPage];
}

- (void)setCurrentPage:(NSInteger)currentPage{
    _currentPage = currentPage;
    CGFloat pageWidth = _pageWidth > 0? _pageWidth: 20;
    CGFloat pageSpace = _pageSpace > 0? _pageSpace: 3;
    _selectedLayer.frame = CGRectMake(_origin_X + currentPage * (pageSpace + pageWidth), _origin_Y, pageWidth, 2);
}

- (void)setCurrentPercentage_X:(CGFloat)currentPercentage_X{
    _currentPercentage_X = currentPercentage_X;
    CGFloat pageWidth = _pageWidth > 0? _pageWidth: 20;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _selectedLayer.frame = CGRectMake(_origin_X + currentPercentage_X * _sunWidth, _origin_Y, pageWidth, 2);
    [CATransaction commit];
}

- (void)setNormalItemColor:(UIColor *)normalItemColor{
    _normalItemColor = normalItemColor;
    self.layer.backgroundColor = normalItemColor.CGColor;
}

- (void)setSelectedItemColor:(UIColor *)selectedItemColor{
    _selectedItemColor = selectedItemColor;
    _selectedLayer.backgroundColor = selectedItemColor.CGColor;
}

- (void)setPageSpace:(CGFloat)pageSpace{
    _pageSpace = pageSpace;
    [self showPage];
}

- (void)showPage{
    CGFloat pageWidth = _pageWidth > 0? _pageWidth: 20;
    CGFloat pageSpace = _pageSpace > 0? _pageSpace: 3;
    _sunWidth = _pageSize * pageWidth + pageSpace * (_pageSize - 1);
    _origin_X = self.center.x - _sunWidth/ 2;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    for (int i = 0; i < _pageSize; i++) {
        [bezierPath moveToPoint:CGPointMake(_origin_X + i * (pageSpace + pageWidth), _origin_Y)];
        [bezierPath addLineToPoint:CGPointMake(_origin_X + (i + 1) * pageWidth + i * pageSpace, _origin_Y)];
    }
    _showPageLayer.path = bezierPath.CGPath;
}

@end
