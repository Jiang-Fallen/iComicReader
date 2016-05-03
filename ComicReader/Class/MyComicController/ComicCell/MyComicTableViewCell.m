//
//  MyComicTableViewCell.m
//  ComicReader
//
//  Created by Jiang on 14/12/9.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "MyComicTableViewCell.h"
#import "MyComicModel.h"
#import "MyComicController.h"
#import "MyComicContentModel.h"

@interface MyComicTableViewCell ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *lableView;

@property (nonatomic, strong) NSArray *comicContentModelArray;

@end

@implementation MyComicTableViewCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
}

- (void)setComicModel:(MyComicModel*)comicModel{
    self.lableView.text = comicModel.name;
    self.comicContentModelArray = comicModel.bigbooksjson;
}

- (void)setComicContentModelArray:(NSArray *)comicContentModelArray{
    CGFloat width = (kMyComicImageWidth + kSpace) * comicContentModelArray.count - kSpace;
    self.scrollView.contentSize = CGSizeMake(width, kMyComicCellHeight);
    for (int i = 0; i < comicContentModelArray.count; i++) {
        MyComicContentModel *model = comicContentModelArray[i];
        
        CGFloat imageWidth = (kMyComicImageWidth + kSpace) * i;
        CGRect rect = CGRectMake(imageWidth, 0, kMyComicImageWidth, kMyComicCellHeight);
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.coverurl]] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [imageView setImage:[UIImage imageWithData:data]];
            });
        }];
        [dataTask resume];
        
        [self.scrollView addSubview:imageView];
    }
}

@end
