//
//  UIImage+CutIntoPieces.m
//  ComicReader
//
//  Created by Jiang on 1/4/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import "UIImage+CutIntoPieces.h"

@implementation UIImage (CutIntoPieces)

- (NSArray*)cutIntoPiecesForNumber:(NSInteger)number{
    CGFloat piecesHeight = self.size.height / number;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < number; i++) {
        CGRect rect = CGRectMake(0, piecesHeight * i, self.size.width, piecesHeight);
        CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        [array addObject:image];
    }
    return array;
}

@end
