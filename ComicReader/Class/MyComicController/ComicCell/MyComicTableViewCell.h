//
//  MyComicTableViewCell.h
//  ComicReader
//
//  Created by Jiang on 14/12/9.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyComicModel;

@interface MyComicTableViewCell : UITableViewCell
- (void)setComicModel:(MyComicModel*)comicModel;
@end
