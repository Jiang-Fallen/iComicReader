//
//  UIScrollView+JFRefresh.h
//  RefreshDemo
//
//  Created by Mr_J on 16/3/5.
//  Copyright © 2016年 Mr_J. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFRefreshControl.h"

@interface UIScrollView (JFRefresh)

@property (nonatomic, strong) JFRefreshControl *refreshControl;

- (void)addHeaderWithAction:(void (^)(NSInteger index))action;
- (void)addHeaderWithAction:(void (^)(NSInteger index))action
              customControl:(void (^)(JFRefreshControl *control))opration;

@end
