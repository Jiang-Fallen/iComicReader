//
//  ContentListView.m
//  ComicReader
//
//  Created by Jiang on 1/14/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import "ContentListView.h"
#import "ComicStoreContentListCollectionView.h"
#import "ResizeLabel.h"

@interface ContentListView ()

@property (nonatomic, weak) UIView *rightHintView;
@property (nonatomic, weak) UILabel *rightHintViewLabel;
//是否在动画完毕之后执行删除rightHintView操作
@property (nonatomic, assign, getter=isExecutionRemove) BOOL executionRemove;

@end

@implementation ContentListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    ComicStoreContentListCollectionView *contentCollection = [[ComicStoreContentListCollectionView alloc]initWithFrame:self.bounds];
    
    [self addSubview:contentCollection];
    
    self.comicStoreContentListCollectionView = contentCollection;
}

- (void)setListRowContentModelArray:(NSArray *)listRowContentModelArray{
    _listRowContentModelArray = listRowContentModelArray;
    self.comicStoreContentListCollectionView.listRowContentModelArray = listRowContentModelArray;
}

- (void)showRefreshState:(RefreshState)refreshState{
    self.executionRemove = NO;
    CGRect rightHintRect = CGRectMake(self.bounds.size.width, 80, 120.0, 45.0);
    self.rightHintView.frame = rightHintRect;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissRefreshState) object:nil];
    switch (refreshState) {
        case stateSuccess:
            self.rightHintViewLabel.text = @"加载完成!";
            break;
        case stateFailure:
            self.rightHintViewLabel.text = @"加载失败!";
            break;
        case stateLoading:
            self.rightHintViewLabel.text = @"加载中!";
            break;
        default:
            break;
    }
    __block CGRect rect = self.rightHintView.frame;
    __unsafe_unretained typeof(self) p = self;
    [UIView animateWithDuration:0.25 animations:^{
        rect.origin.x -= rect.size.width;
        p.rightHintView.frame = rect;
    } completion:^(BOOL finished) {
        p.executionRemove = YES;
        [p performSelector:@selector(dismissRefreshState) withObject:nil afterDelay:2.0];
    }];
}

- (void)dismissRefreshState{
    __block CGRect rect = self.rightHintView.frame;
    __unsafe_unretained typeof(self) p = self;
    [UIView animateWithDuration:0.25 animations:^{
        rect.origin.x = p.frame.size.width;
        p.rightHintView.frame = rect;
    } completion:^(BOOL finished) {
        if (p.executionRemove) {
            [p.rightHintView removeFromSuperview];
        }
    }];
}

- (UIView *)rightHintView{
    if (!_rightHintView) {
        CGRect rect = CGRectMake(self.bounds.size.width, 20, 120.0, 45.0);
        UIView *view = [[UIView alloc]initWithFrame:rect];
        UIImage *image = [UIImage imageNamed:@"bookshelf_import_control_left"];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        imageView.alpha = 0.9;
        imageView.frame = view.bounds;
        [view addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:view.bounds];
        [label setTextAlignment:NSTextAlignmentCenter];
        label.font = [UIFont boldSystemFontOfSize:13.0];
        [view addSubview:label];
        _rightHintViewLabel = label;
        
        [self addSubview:view];
        _rightHintView = view;
    }
    return _rightHintView;
}

@end
