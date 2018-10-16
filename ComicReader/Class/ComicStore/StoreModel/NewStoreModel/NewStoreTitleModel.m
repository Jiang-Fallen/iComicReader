//
//  NewStoreModel.m
//  ComicReader
//
//  Created by Jiang on 3/25/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import "NewStoreTitleModel.h"
#import "JFComicStoreModelTool.h"

@implementation NewStoreTitleModel

- (instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setType:(NSInteger)type{
    NSArray *countArray = [JFComicStoreModelTool arrayForListCellShowCount];
    if (type >= countArray.count) {
        _type = (type - countArray.count) % 3 + 2;
    }else{
        _type = type;
    }
    
    _contentCount = [countArray[_type] integerValue];
    
    NSArray *heightArray = [JFComicStoreModelTool arrayForListCellHeight];
    _contentCellHeight = [heightArray[_type] floatValue];
}

- (void)setTopics:(NSMutableArray *)topics{
    _topics = [ListContentModel modelArrayForDataArray:topics];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+ (NSMutableArray*)modelArrayByDataArray:(NSArray*)array{
    NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        if ([dict[@"item_type"] integerValue] != 4) {
            continue;
        }
        NewStoreTitleModel *model = [[NewStoreTitleModel alloc] initWithDictionary:dict];
        model.type = [array indexOfObject:dict];
        [modelArray addObject:model];
    }
    return modelArray;
}

@end
