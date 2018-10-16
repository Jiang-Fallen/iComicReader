//
//  JFComicBlockingContentCellCollectionViewCell.h
//  ComicReader
//
//  Created by Mr_J on 16/4/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListContentModel.h"

@interface JFComicBlockingContentCellCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet YYAnimatedImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) ListContentModel *contentModel;

@end
