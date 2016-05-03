//
//  ComicStoreContentListCollectionView.h
//  ComicReader
//
//  Created by Jiang on 1/9/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SRRefreshView;
@protocol ComicStoreCollectionViewDelegate <NSObject>

@optional
- (void)comicStoreCollectionDidScroll:(UIScrollView *)scrollView;
- (void)comicStoreCollectionDidSelected:(UICollectionView*)collectionView indePath:(NSIndexPath*)indexPath;
@end

@interface ComicStoreContentListCollectionView : UICollectionView

@property (assign, nonatomic) id<ComicStoreCollectionViewDelegate> comicStoreContentDelegate;
//图书列表内容模型数据数组
@property (nonatomic, strong) NSArray *listRowContentModelArray;
@property (nonatomic, strong) NSArray *headerModelArray;

//@property (nonatomic, strong) SRRefreshView *refreshView;

@end
