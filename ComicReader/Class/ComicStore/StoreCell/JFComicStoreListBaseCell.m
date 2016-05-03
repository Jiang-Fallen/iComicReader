//
//  JFComicStoreListBaseCell.m
//  ComicReader
//
//  Created by Mr_J on 16/4/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "JFComicStoreListBaseCell.h"
#import "JFComicSectionsListViewController.h"

@implementation JFComicStoreListBaseCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    [self addSubview:self.headerView];
    [self addSubview:self.contentCollectionView];
    
    [self initSubViewLayouts];
    [self initCompletionOpration];
}

- (void)initSubViewLayouts{
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.height.mas_equalTo(@35);
    }];
    
    [self.contentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(35, 0, 0, 0));
    }];
}

- (void)initCompletionOpration{
    
}

- (void)contentModelCompletionOpration{
    
}

- (void)setContentModel:(NewStoreTitleModel *)contentModel{
    _contentModel = contentModel;
    self.headerView.contentModel = contentModel;
    self.contentModelArray = contentModel.contentArray;
    [contentModel addObserver:self forKeyPath:@"contentArray" options:NSKeyValueObservingOptionNew context:nil];
    [self contentModelCompletionOpration];
}

- (void)setContentModelArray:(NSArray *)contentModelArray{
    _contentModelArray = contentModelArray;
    [self.contentCollectionView reloadData];
}

#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    self.contentModelArray = _contentModel.contentArray;
    [self.contentCollectionView reloadData];
}

#pragma mark -

- (JFComicListTitleView *)headerView{
    if (!_headerView) {
        _headerView = [[JFComicListTitleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    }
    return _headerView;
}

- (UICollectionView *)contentCollectionView{
    if (!_contentCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _contentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _contentCollectionView.backgroundColor = [UIColor whiteColor];
        _contentCollectionView.scrollEnabled = NO;
        _contentCollectionView.showsVerticalScrollIndicator = NO;
        _contentCollectionView.showsHorizontalScrollIndicator = NO;
        _contentCollectionView.delegate = self;
        _contentCollectionView.dataSource = self;
        _contentLayout = layout;
    }
    return _contentCollectionView;
}

#pragma mark - delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _contentModelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ListContentModel *model = self.contentModelArray[indexPath.row];
    JFComicSectionsListViewController *controller = [[JFComicSectionsListViewController alloc]init];
    controller.bookID = model.aID;
    [[JFJumpToControllerManager shared].navigation pushViewController:controller animated:YES];
}

@end
