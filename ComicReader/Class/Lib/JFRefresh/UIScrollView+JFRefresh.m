//
//  UIScrollView+JFRefresh.m
//  RefreshDemo
//
//  Created by Mr_J on 16/3/5.
//  Copyright © 2016年 Mr_J. All rights reserved.
//

#import "UIScrollView+JFRefresh.h"
#import <objc/runtime.h>

NSString * const _refreshControl = @"refreshControl";
@implementation UIScrollView (JFRefresh)

- (void)addHeaderWithAction:(void (^)(NSInteger))action{
    [self.refreshControl removeFromScrollView];
    
    self.refreshControl = [[JFRefreshControl alloc]initWithScrollView:self];
    self.refreshControl.actionOfIndex = action;
}

- (void)addHeaderWithAction:(void (^)(NSInteger))action customControl:(void (^)(JFRefreshControl *))opration{
    [self addHeaderWithAction:action];
    opration(self.refreshControl);
}

- (JFRefreshControl *)refreshControl{
    return (JFRefreshControl *)objc_getAssociatedObject(self, &_refreshControl);
}

- (void)setRefreshControl:(JFRefreshControl *)refreshControl{
    objc_setAssociatedObject(self, &_refreshControl, refreshControl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
