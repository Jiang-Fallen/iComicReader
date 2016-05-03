//
//  JFComicListTitleView.m
//  ComicReader
//
//  Created by Mr_J on 16/4/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "JFComicListTitleView.h"
#import "JFComicMoreViewController.h"
#import "NewStoreTitleModel.h"

@implementation JFComicListTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    [self addSubview:self.contentLabel];
    [self addSubview:self.tagView];
    [self addSubview:self.moreButton];
}

- (UIView *)tagView{
    if (!_tagView) {
        _tagView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 5, 15)];
        _tagView.backgroundColor = UIColorFromRGB(0xffbf00);
        _tagView.layer.masksToBounds = YES;
        _tagView.layer.cornerRadius = 2.5;
    }
    return _tagView;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, kScreenWidth, self.height)];
        _contentLabel.font = [UIFont systemFontOfSize:13];
        _contentLabel.textColor = UIColorFromRGB(0x666666);
        _contentLabel.layer.zPosition = -1;
    }
    return _contentLabel;
}

- (UIButton *)moreButton{
    if (!_moreButton) {
        _moreButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 100 - 10, 0, 100, self.height)];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:11];
        _moreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_moreButton setTitleColor:UIColorFromRGB(0xBBBBBB) forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(moreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_moreButton setTitle:@"更多" forState:UIControlStateNormal];
    }
    return _moreButton;
}

- (void)setContentModel:(NewStoreTitleModel *)contentModel{
    _contentModel = contentModel;
    self.contentLabel.text = contentModel.title;
}

#pragma mark - action

- (void)moreButtonAction:(UIButton *)sender{
    JFComicMoreViewController *controller = [[JFComicMoreViewController alloc]init];
    controller.requestType = _contentModel.title;
    controller.title = _contentModel.title;
    [[JFJumpToControllerManager shared].navigation pushViewController:controller animated:YES];
}

@end
