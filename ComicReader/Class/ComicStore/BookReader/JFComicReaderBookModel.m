//
//  JFComicReaderBookModel.m
//  ComicReader
//
//  Created by Mr_J on 16/5/2.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "JFComicReaderBookModel.h"

@implementation JFComicReaderBookModel

- (instancetype)initWithDictionary:(NSDictionary*)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setImages:(NSMutableArray *)images{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:images.count];
    for (NSString *urlString in images) {
        JFComicReaderBookContentModel *model = [[JFComicReaderBookContentModel alloc]init];
        model.cover_image_url = urlString;
        [array addObject:model];
    }
    _images = array;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.aID = value;
    }
}

@end
