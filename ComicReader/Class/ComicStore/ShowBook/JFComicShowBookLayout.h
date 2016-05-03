//
//  JFComicShowBookLayout.h
//  ComicReader
//
//  Created by Mr_J on 16/5/2.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *JFHeaderKind = @"JFComicHeaderReusableViewKind";
@interface JFComicShowBookLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) CGFloat headerHeight;

- (instancetype)initWithAnimatedHeight:(CGFloat)height;

@end
