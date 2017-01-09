//
//  UIScrollView+JFRefresh.m
//  RefreshDemo
//
//  Created by Mr_J on 16/3/5.
//  Copyright © 2016年 Mr_J. All rights reserved.
//

#import "UIScrollView+JFRefresh.h"
#import <objc/runtime.h>

NSString * const _jf_refreshControl = @"refreshControl";
@implementation UIScrollView (JFRefresh)
@dynamic jf_refreshControl;

- (void)addHeaderWithAction:(void (^)(NSInteger))action{
    [self.jf_refreshControl removeFromScrollView];
    
    self.jf_refreshControl = [[JFRefreshControl alloc]initWithScrollView:self];
    self.jf_refreshControl.actionOfIndex = action;
}

- (void)addHeaderWithAction:(void (^)(NSInteger))action customControl:(void (^)(JFRefreshControl *))opration{
    [self addHeaderWithAction:action];
    opration(self.jf_refreshControl);
}

- (JFRefreshControl *)refreshControl{
    return (JFRefreshControl *)objc_getAssociatedObject(self, &_jf_refreshControl);
}

- (void)setRefreshControl:(JFRefreshControl *)refreshControl{
    objc_setAssociatedObject(self, &_jf_refreshControl, refreshControl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
