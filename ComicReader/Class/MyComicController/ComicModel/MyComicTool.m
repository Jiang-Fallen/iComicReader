//
//  MyComicTool.m
//  ComicReader
//
//  Created by Jiang on 14/12/9.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "MyComicTool.h"
#import "MyComicModel.h"

@implementation MyComicTool

+ (NSArray *)comicModelWithDictionary:(NSDictionary *)dict{
    NSMutableArray *comicArray = [NSMutableArray array];
    NSArray *array = dict[@"info"];
    for (NSDictionary *dict in array) {
        MyComicModel *comicModel = [MyComicModel comicModelWithDictionary:dict];
        [comicArray addObject:comicModel];
    }
    return [comicArray copy];
}

- (NSArray *)parseComicModelWithDictionay:(NSDictionary *)dict{
    return [MyComicTool comicModelWithDictionary:dict];
}
@end
