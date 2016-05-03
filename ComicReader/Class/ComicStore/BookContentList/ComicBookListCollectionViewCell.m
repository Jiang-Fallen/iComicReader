//
//  ComicBookListCollectionViewCell.m
//  ComicReader
//
//  Created by Jiang on 5/17/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import "ComicBookListCollectionViewCell.h"

@implementation ComicBookListCollectionViewCell

- (void)awakeFromNib {
    self.accesstoryImageView.transform = CGAffineTransformMakeRotation(M_PI);
}

@end
