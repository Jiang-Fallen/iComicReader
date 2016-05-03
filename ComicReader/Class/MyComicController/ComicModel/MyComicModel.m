//
//  MyComicModel.m
//  ComicReader
//
//  Created by Jiang on 14/12/9.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "MyComicModel.h"
#import "MyComicContentModel.h"

@interface MyComicModel ()

@end

@implementation MyComicModel

- (instancetype)initWithDictionary:(NSDictionary*)dict{
    if (self = [super init]) {
        [self setComicModelWithDictionary:dict];
    }
    return self;
}

- (void)setComicModelWithDictionary:(NSDictionary*)dict{
    self.bigbooksjson   = dict[@"bigbooksjson"];
    self.mID            = dict[@"id"];
    self.name           = dict[@"name"];
    self.targetargument = dict[@"targetargument"];
    self.targetmethod   = dict[@"targetmethod"];
}

+ (instancetype)comicModelWithDictionary:(NSDictionary*)dict{
    MyComicModel *comicModel = [[MyComicModel alloc]initWithDictionary:dict];
    return comicModel;
}

- (void)setBigbooksjson:(NSString *)bigbooksjson{
    NSMutableArray *comicArray = [NSMutableArray array];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:[bigbooksjson dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    for (NSDictionary *dict in array) {
        [comicArray addObject:[MyComicContentModel comicContentModelWithDictionary:dict]];
    }
    _bigbooksjson = [comicArray copy];
}

@end
