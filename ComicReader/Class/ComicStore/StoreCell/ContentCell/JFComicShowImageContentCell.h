//
//  JFComicShowImageContentCell.h
//  ComicReader
//
//  Created by Mr_J on 16/4/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListContentModel.h"

@interface JFComicShowImageContentCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@property (nonatomic, strong) ListContentModel *contentModel;

@end
