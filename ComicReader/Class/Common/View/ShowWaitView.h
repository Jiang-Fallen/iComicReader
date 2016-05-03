//
//  ShowWaitView.h
//  ComicReader
//
//  Created by Jiang on 14/12/11.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MONActivityIndicatorView;

@interface ShowWaitView : UIView

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) MONActivityIndicatorView *indicatorView;


- (void)showError;
- (void)showWait;
- (void)removeNotifacationServer;

- (instancetype)initWithOperation:(void(^)())operation;

@end
