//
//  JFComicShowImageCollectionView.m
//  ComicReader
//
//  Created by Mr_J on 16/4/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "JFComicShowImageCollectionView.h"
#import "JFComicShowImageContentCell.h"

static NSString *showImageCellIdentifier = @"JFComicShowImageContentCellIdentifier";
@implementation JFComicShowImageCollectionView

- (void)initCompletionOpration{
    [self.contentCollectionView registerNib:[UINib nibWithNibName:@"JFComicShowImageContentCell" bundle:nil]
                 forCellWithReuseIdentifier:showImageCellIdentifier];
    self.contentLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    self.contentLayout.minimumLineSpacing = 5;
    self.contentLayout.itemSize = CGSizeMake(kScreenWidth - 20, 110 * kScreen375Scale);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JFComicShowImageContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:showImageCellIdentifier forIndexPath:indexPath];
    cell.contentModel = self.contentModelArray[indexPath.row];
    return cell;
}

@end
