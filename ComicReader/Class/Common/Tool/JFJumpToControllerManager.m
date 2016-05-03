//
//  JFJumpToControllerManager.m
//  ComicReader
//
//  Created by Mr_J on 16/5/1.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "JFJumpToControllerManager.h"

static JFJumpToControllerManager *JumpManager;
@implementation JFJumpToControllerManager

#pragma mark - 单例实现
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        JumpManager = [super allocWithZone:zone];
    });
    return JumpManager;
}

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        JumpManager = [[self alloc]init];
    });
}

+ (instancetype)shared{
    return JumpManager;
}

- (UINavigationController *)navigation{
    if (!_navigation) {
        _navigation = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    }
    return _navigation;
}

@end
