//
//  JFJumpToControllerManager.h
//  ComicReader
//
//  Created by Mr_J on 16/5/1.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class JFJumpToControllerManager;


@interface JFJumpToControllerManager : NSObject

@property (nonatomic, strong) UINavigationController *navigation;

+ (instancetype)shared;

@end
