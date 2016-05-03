//
//  JFComicListTitleView.h
//  ComicReader
//
//  Created by Mr_J on 16/4/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewStoreTitleModel;

@interface JFComicListTitleView : UIView

@property (nonatomic, strong) UIView *tagView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *moreButton;

@property (nonatomic, strong) NewStoreTitleModel *contentModel;

@end
