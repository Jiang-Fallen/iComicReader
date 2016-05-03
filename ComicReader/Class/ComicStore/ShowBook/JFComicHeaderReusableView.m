//
//  JFComicHeaderReusableView.m
//  ComicReader
//
//  Created by Mr_J on 16/5/2.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "JFComicHeaderReusableView.h"
#import "ListContentModel.h"
#import "FXBlurView.h"

@interface JFComicHeaderReusableView ()

@property (nonatomic, strong) UIImage *contentShowImage;
@property (nonatomic, weak) CAGradientLayer *gradientLayer;

@end

@implementation JFComicHeaderReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backButton.imageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:YES];
    self.titleLabel.height = self.titleContentView.height;
    self.contentImageView.layer.zPosition = -2;
    self.maskImageView.layer.zPosition = -1;
    [self addGradient];
}

- (void)addGradient{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.titleContentView.bounds;
    gradientLayer.zPosition = -1;
    UIColor *graidentColor = [UIColor blackColor];
    gradientLayer.locations = @[@0];
    gradientLayer.colors = @[(__bridge id)[graidentColor colorWithAlphaComponent:0.8].CGColor,
                             (__bridge id)[graidentColor colorWithAlphaComponent:0.0].CGColor];
    gradientLayer.startPoint = CGPointMake(0.5, 1);
    gradientLayer.endPoint = CGPointMake(0.5, 0);
    [self.titleContentView.layer addSublayer:gradientLayer];
    _gradientLayer = gradientLayer;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.maskValue = MAX(self.imageHeight - self.height, 0)/ self.imageHeight;
    CGFloat maskValue = MAX(self.imageHeight - (self.height - 64), 0)/ self.imageHeight;
    self.backButton.imageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5 * (1 - maskValue)];
    [CATransaction begin];//去除隐性动画
    [CATransaction setDisableActions:YES];
    self.gradientLayer.opacity = (1 - maskValue);
    [CATransaction commit];
    
    CGFloat title_X = 0.0;
    BOOL isTitleCenter;
    if (self.titleContentView.originY > 44) {
        title_X = 10;
        isTitleCenter = NO;
    }else{
        title_X = (self.width - self.titleLabel.width)/ 2;
        isTitleCenter = YES;
    }
    if (!isTitleCenter == _contentModel.isTitleCenter) {
        _contentModel.isTitleCenter = isTitleCenter;
        [UIView animateWithDuration:0.25 animations:^{
            self.titleLabel.originX = title_X;
        }];
    }
}

- (void)setContentModel:(ListContentModel *)contentModel{
    _contentModel = contentModel;
    
    [self settingContentImageForURLString];
    self.titleLabel.text = contentModel.title;
    self.titleLabel.width = [contentModel.title sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}].width;
    
    CGFloat title_X = 0.0;
    if (!_contentModel.isTitleCenter) {
        title_X = 10;
    }else{
        title_X = (self.width - self.titleLabel.width)/ 2;
    }
    self.titleLabel.originX = title_X;
}

- (void)setContentShowImage:(UIImage *)contentShowImage{
    _contentShowImage = contentShowImage;
    self.maskImageView.image = [self.contentShowImage
                                blurredImageWithRadius:10
                                iterations:5
                                tintColor:[UIColor blackColor]];
}

- (void)setMaskValue:(CGFloat)maskValue{
    _maskValue = maskValue;
    if (!self.contentShowImage) return;
    self.maskImageView.alpha = MIN(maskValue * 2, 1);
}

- (void)settingContentImageForURLString{
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:_contentModel.cover_image_url]
                             placeholderImage:nil
                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         if (image) {
             self.contentShowImage = image;
             CGFloat imageHeight = (image.size.height * (self.width/ image.size.width));
             //图片高度可能会不等于原始imageView高度，做处理
             if (imageHeight != self.imageHeight) {
                 for (NSLayoutConstraint *layout in self.constraints) {
                     if ([layout.identifier isEqualToString:@"imageBottomLayout"]) {
                         layout.constant = -(imageHeight - self.imageHeight);
                     }
                 }
             }
         }
     }];
}

#pragma mark - action
- (IBAction)backButtonAction:(id)sender {
    [[JFJumpToControllerManager shared].navigation popViewControllerAnimated:YES];
}


@end
