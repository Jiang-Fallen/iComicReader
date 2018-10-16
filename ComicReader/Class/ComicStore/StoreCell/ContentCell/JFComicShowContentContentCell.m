//
//  JFComicShowContentContentCell.m
//  ComicReader
//
//  Created by Mr_J on 16/4/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "JFComicShowContentContentCell.h"

@implementation JFComicShowContentContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setContentModel:(ListContentModel *)contentModel{
    _contentModel = contentModel;
    
    self.contentImageView.yy_imageURL = [NSURL URLWithString:contentModel.pic];
    self.titleLabel.text = contentModel.title;
    self.descriptionLabel.text = contentModel.aDescription;
    [self.likeButton setTitle:[NSString stringWithFormat:@" %d", contentModel.likes_count.intValue] forState:UIControlStateNormal];
}

@end
