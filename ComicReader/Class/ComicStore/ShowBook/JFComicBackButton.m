//
//  JFComicBackButton.m
//  ComicReader
//
//  Created by Mr_J on 16/5/2.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "JFComicBackButton.h"

@implementation JFComicBackButton

- (void)awakeFromNib{
    self.imageView.layer.cornerRadius = self.imageView.height/ 2;
    self.imageView.layer.masksToBounds = YES;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGRect rect = CGRectMake(0, contentRect.size.height - 38, 35, 35);
    return rect;
}

@end
