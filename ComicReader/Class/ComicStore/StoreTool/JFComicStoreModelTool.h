//
//  JFComicStoreModelTool.h
//  ComicReader
//
//  Created by Mr_J on 16/4/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFComicStoreModelTool : NSObject

+ (NSArray *)arrayForListCellHeight;
+ (NSArray *)arrayForListCellShowCount;
+ (NSArray *)arrayForListCellClassName;

+ (void)registerCellForCollectionView:(UICollectionView *)collectionView;

@end
