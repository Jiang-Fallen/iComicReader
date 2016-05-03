//
//  JFComicStoreModelTool.m
//  ComicReader
//
//  Created by Mr_J on 16/4/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "JFComicStoreModelTool.h"

@implementation JFComicStoreModelTool

//cell共五种样式，前两个固定，后面三个重复出现排列 (下面情况相同)
+ (NSArray *)arrayForListCellShowCount{
    return @[@20,
             @6,
             @3,
             @4,
             @2];
}

+ (NSArray *)arrayForListCellHeight{
    return @[@(35 + 200 * kScreen375Scale),
             @(35 + 375 * kScreen375Scale),
             @(35 + 270 * kScreen375Scale),
             @(35 + 245 * kScreen375Scale),
             @(35 + 220 * kScreen375Scale)];
}

//cell三个类，blockingCell通过type变换三种样式
+ (NSArray *)arrayForListCellClassName{
    return @[@"JFComicShowContentCollectionView",
             @"JFComicBlockingCollectionView",
             @"JFComicShowImageCollectionView"];
}

+ (void)registerCellForCollectionView:(UICollectionView *)collectionView{
    NSArray *classArray = [self arrayForListCellClassName];
    
    for (NSString *className in classArray) {
        Class class = NSClassFromString(className);
        NSString *identifier = [NSString stringWithFormat:@"%@", className];
        [collectionView registerClass:class forCellWithReuseIdentifier:identifier];
    }
}

@end
