//
//  ComicShowBookModel.m
//  ComicReader
//
//  Created by Jiang on 5/9/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import "ComicShowBookModel.h"

@implementation ComicShowBookModel

- (instancetype)initWithDictionary:(NSDictionary*)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (NSArray*)modelArrayForDataArray:(NSArray*)dataArray{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in dataArray) {
        ComicShowBookModel *model = [[ComicShowBookModel alloc]initWithDictionary:dict];
        [array addObject:model];
    }
    return array;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
