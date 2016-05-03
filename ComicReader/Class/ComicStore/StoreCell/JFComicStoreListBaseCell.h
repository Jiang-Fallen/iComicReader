//
//  JFComicStoreListBaseCell.h
//  ComicReader
//
//  Created by Mr_J on 16/4/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFComicListTitleView.h"
#import "NewStoreTitleModel.h"
#import "ListContentModel.h"

@interface JFComicStoreListBaseCell : UICollectionViewCell <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) JFComicListTitleView *headerView;
@property (nonatomic, strong) UICollectionView *contentCollectionView;
@property (nonatomic, weak) UICollectionViewFlowLayout *contentLayout;

@property (nonatomic, weak) NewStoreTitleModel *contentModel;
@property (nonatomic, weak) NSArray *contentModelArray;

//子类重构
- (void)initCompletionOpration;
- (void)contentModelCompletionOpration;

@end
