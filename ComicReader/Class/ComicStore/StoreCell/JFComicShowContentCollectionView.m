
//
//  JFComicShowContentCollectionView.m
//  ComicReader
//
//  Created by Mr_J on 16/4/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "JFComicShowContentCollectionView.h"
#import "JFComicShowContentContentCell.h"

static NSString *showContentCellIdentifier = @"JFComicShowContentContentCellIdentifier";
@implementation JFComicShowContentCollectionView

- (void)initCompletionOpration{
    [self.contentCollectionView registerNib:[UINib nibWithNibName:@"JFComicShowContentContentCell" bundle:nil]
                 forCellWithReuseIdentifier:showContentCellIdentifier];
    
    self.contentLayout.minimumLineSpacing = 0;
    self.contentLayout.itemSize = CGSizeMake(kScreenWidth, 90 * kScreen375Scale);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JFComicShowContentContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:showContentCellIdentifier forIndexPath:indexPath];
    cell.contentModel = self.contentModelArray[indexPath.row];
    return cell;
}

@end
