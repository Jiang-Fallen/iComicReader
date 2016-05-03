//
//  MyComicContentModel.m
//  ComicReader
//
//  Created by Jiang on 14/12/9.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ListContentModel.h"
#import "JFComicStoreModelTool.h"

@interface ListContentModel ()

@end

@implementation ListContentModel

- (instancetype)initWithDictionary:(NSDictionary*)dict{
    if (self = [super init]) {
        [self setComicContentModelWithDictionary:dict];
    }
    return self;
}

- (void)setComicContentModelWithDictionary:(NSDictionary*)dict{
    [self setValuesForKeysWithDictionary:dict];
}

- (void)setComics:(NSArray *)comics{
    _comics = [[self class]modelArrayForDataArray:comics];
}

+ (instancetype)comicContentModelWithDictionary:(NSDictionary*)dict{
    ListContentModel *comicContentModel = [[ListContentModel alloc]initWithDictionary:dict];
    return comicContentModel;
}

+ (NSMutableArray*)modelArrayForDataArray:(NSArray*)dataArray{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in dataArray) {
        id model = [[[self class] alloc]initWithDictionary:dict];
        [array addObject:model];
    }
    return array;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.aID = value;
    }else if ([key isEqualToString:@"description"]){
        self.aDescription = value;
    }
}

@end
