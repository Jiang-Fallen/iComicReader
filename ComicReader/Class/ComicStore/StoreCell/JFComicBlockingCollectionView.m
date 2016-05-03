//
//  JFComicLumpCollectionView.m
//  ComicReader
//
//  Created by Mr_J on 16/4/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "JFComicBlockingCollectionView.h"
#import "JFComicBlockingContentCellCollectionViewCell.h"

static NSString *blockingCellIdentifier = @"JFComicBlockingContentCellCollectionViewCellIdentifier";
@implementation JFComicBlockingCollectionView

- (void)initCompletionOpration{
    [self.contentCollectionView registerNib:[UINib nibWithNibName:@"JFComicBlockingContentCellCollectionViewCell" bundle:nil]
                 forCellWithReuseIdentifier:blockingCellIdentifier];
    self.contentLayout.minimumLineSpacing = 10;
    self.contentLayout.minimumInteritemSpacing = 10;
    self.contentLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
}

- (void)contentModelCompletionOpration{
    if (self.contentModel.type == 0){
        self.contentLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.contentCollectionView.scrollEnabled = YES;
    }else{
        self.contentLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.contentCollectionView.scrollEnabled = NO;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.contentModel.type == 0) {
        CGFloat height = (self.contentCollectionView.height - 20)/ 2;
        return CGSizeMake(height/ 90.0 * 130, height);
    }else {
        CGFloat width = (self.contentCollectionView.width - 30)/ 2.0;
        return CGSizeMake(width, width/ 172 * 115);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JFComicBlockingContentCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:blockingCellIdentifier forIndexPath:indexPath];
    cell.contentModel = self.contentModelArray[indexPath.row];
    return cell;
}

@end
