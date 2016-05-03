//
//  ContentListView.h
//  ComicReader
//
//  Created by Jiang on 1/14/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    stateSuccess = 0,
    stateFailure,
    stateLoading
} RefreshState;

@class ComicStoreContentListCollectionView;

@protocol ComicStoreContentListCollectionViewDelegate <NSObject>

@optional
- (void)comicOrderSelectedIndex:(NSInteger)index;
- (void)comicOrderTouchAction;

@end

@interface ContentListView : UIView

//content列表ViewGo back按钮
@property (nonatomic, weak) UIView *contentBack;
//content列表ViewGo back按钮标题
@property (nonatomic, weak) UILabel *currentListTitle;
//图书列表页内容模型数据数组
@property (nonatomic, strong) NSArray *listRowContentModelArray;
//content列表View
@property (nonatomic, weak) ComicStoreContentListCollectionView *comicStoreContentListCollectionView;

@property (nonatomic, assign) id<ComicStoreContentListCollectionViewDelegate> delegate;

- (void)showRefreshState:(RefreshState)refreshState;

@end
