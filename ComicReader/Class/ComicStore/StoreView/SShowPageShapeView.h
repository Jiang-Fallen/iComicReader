//
//  SShowPageShapeView.h
//  Wefafa
//
//  Created by Mr_J on 16/1/21.
//  Copyright © 2016年 metersbonwe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SShowPageShapeView : UIView

@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) CGFloat currentPercentage_X;
@property (nonatomic, assign) CGFloat pageWidth;
@property (nonatomic, assign) CGFloat pageSpace;
@property (nonatomic, assign) CGFloat origin_Y;
@property (nonatomic, assign, readonly) CGFloat origin_X;
@property (nonatomic, assign, readonly) CGFloat sunWidth;

@property (nonatomic, strong) UIColor *selectedItemColor;
@property (nonatomic, strong) UIColor *normalItemColor;

- (void)showPage;

@end
