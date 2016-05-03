//
//  JFComicShowContentContentCell.h
//  ComicReader
//
//  Created by Mr_J on 16/4/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListContentModel.h"

@interface JFComicShowContentContentCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@property (nonatomic, strong) ListContentModel *contentModel;

@end
