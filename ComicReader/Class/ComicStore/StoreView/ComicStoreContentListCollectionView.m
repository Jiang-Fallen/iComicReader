//
//  ComicStoreContentListCollectionView.m
//  ComicReader
//
//  Created by Jiang on 1/9/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import "ComicStoreContentListCollectionView.h"
//#import "SRRefreshView.h"
#import "ComicStoreHeaderView.h"
#import "JFComicStoreModelTool.h"
#import "NewStoreTitleModel.h"
#import "JFComicStoreListBaseCell.h"

@interface ComicStoreContentListCollectionView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *cellNameArray;

@end

static NSString *headerIdentifier = @"ComicStoreHeaderIdentifier";
@implementation ComicStoreContentListCollectionView
- (instancetype)initWithFrame:(CGRect)frame{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 49, 0);
    layout.minimumLineSpacing = 0;
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.dataSource = self;
        self.delegate = self;
        self.alwaysBounceVertical = YES;
        
        [self registerClass:[ComicStoreHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
        //这里注册用到的CELL
        [JFComicStoreModelTool registerCellForCollectionView:self];
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (NSArray *)cellNameArray{
    if (!_cellNameArray) {
        _cellNameArray = [JFComicStoreModelTool arrayForListCellClassName];
    }
    return _cellNameArray;
}

-(void)setHeaderModelArray:(NSArray *)headerModelArray{
    _headerModelArray = headerModelArray;
    [self reloadData];
}

- (void)setListRowContentModelArray:(NSArray *)listRowContentModelArray{
    _listRowContentModelArray = listRowContentModelArray;
    [self reloadData];
}

#pragma mark - 数据源
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NewStoreTitleModel *model = _listRowContentModelArray[indexPath.row];
    NSString *identifier = @"";
    if (model.type < 2) {
        identifier = @"JFComicBlockingCollectionView";
    }else{
        int index = (model.type - 2) % 3;
        identifier = self.cellNameArray[index];
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(setContentModel:)]) {
        [cell setValue:model forKey:@"contentModel"];
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listRowContentModelArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NewStoreTitleModel *model = _listRowContentModelArray[indexPath.row];
    return CGSizeMake(kScreenWidth, model.contentCellHeight);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ComicStoreHeaderView *collectionReusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        collectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        collectionReusableView.modelArray = self.headerModelArray;
    }
    return collectionReusableView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth, kHeaderHeight);
}

#pragma mark - 代理

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.comicStoreContentDelegate respondsToSelector:@selector(comicStoreCollectionDidSelected:indePath:)]) {
        [self.comicStoreContentDelegate comicStoreCollectionDidSelected:self indePath:indexPath];
    }
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.comicStoreContentDelegate respondsToSelector:@selector(comicStoreCollectionDidScroll:)]) {
        [self.comicStoreContentDelegate comicStoreCollectionDidScroll:scrollView];
    }
}

@end
