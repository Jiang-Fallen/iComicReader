//
//  HeaderModel.m
//  ComicReader
//
//  Created by Jiang on 14/12/10.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "HeaderModel.h"
#import "NSObject+KVCKeyword.h"

@implementation HeaderModel

+ (instancetype)headerModelWithDictionary:(NSDictionary *)dict{
    return [[HeaderModel alloc]initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (NSMutableArray *)modelArrayForDataArray:(NSArray *)dataArray{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:dataArray.count];
    for (NSDictionary *dict in dataArray) {
        id model = [[self class] headerModelWithDictionary:dict];
        [array addObject:model];
    }
    return array;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
