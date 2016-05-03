//
//  JFComicHeaderReusableView.h
//  ComicReader
//
//  Created by Mr_J on 16/5/2.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListContentModel;

@interface JFComicHeaderReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UIImageView *maskImageView; //这个ImageView用来减少计算量，只计算一次，通过alpha通道调整虚化程度
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIView *titleContentView;

@property (nonatomic, strong) ListContentModel *contentModel;
@property (nonatomic, assign) CGFloat imageHeight;
@property (nonatomic, assign) CGFloat maskValue;

@end
