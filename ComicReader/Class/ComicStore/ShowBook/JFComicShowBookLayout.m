//
//  JFComicShowBookLayout.m
//  ComicReader
//
//  Created by Mr_J on 16/5/2.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "JFComicShowBookLayout.h"

@implementation JFComicShowBookLayout

- (instancetype)initWithAnimatedHeight:(CGFloat)height
{
    self = [super init];
    if (self) {
        self.headerHeight = height;
    }
    return self;
}

- (void)prepareLayout{
    [super prepareLayout];
}

- (CGSize)collectionViewContentSize{
    CGSize size = [super collectionViewContentSize];
    size.height += _headerHeight;
    return size;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    rect.origin.y -= _headerHeight;
    NSArray *itemArray = [super layoutAttributesForElementsInRect:rect];
    NSIndexPath *indexPath = [[NSIndexPath alloc]initWithIndexes:0 length:0];
    UICollectionViewLayoutAttributes *headerAttribute = [self layoutAttributesForSupplementaryViewOfKind:JFHeaderKind
                                                                                       atIndexPath:indexPath];
    headerAttribute.zIndex = 10;
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:itemArray];
    [mutableArray addObject:headerAttribute];
    
    for (UICollectionViewLayoutAttributes *attribute in itemArray) {
        CGRect frame = attribute.frame;
        frame.origin.y += _headerHeight;
        attribute.frame = frame;
        attribute.zIndex = 0;
    }
    return mutableArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes * attribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    [self setReusableViewParamsForAttribute:attribute];
    return attribute;
}

- (void)setReusableViewParamsForAttribute:(UICollectionViewLayoutAttributes *)attribute{
    CGFloat offset_Y = self.collectionView.contentOffset.y;
    CGFloat height = 0.0;
    if (offset_Y >= (_headerHeight - 64)) {
        height = 64;
    }else{
        height = _headerHeight - offset_Y;
    }
    attribute.frame = CGRectMake(0, offset_Y, kScreenWidth, height);
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
