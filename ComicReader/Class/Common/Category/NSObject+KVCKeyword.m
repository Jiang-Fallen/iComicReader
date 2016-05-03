//
//  NSObject+KVCKeyword.m
//  ComicReader
//
//  Created by Jiang on 14/12/10.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "NSObject+KVCKeyword.h"

@implementation NSObject (KVCKeyword)

- (void)setValuesForKeywordsWithDictionary:(NSDictionary *)keyedValues{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:keyedValues];
    if (dict[@"id"]) {
        dict[@"aID"] = dict[@"id"];
        [dict removeObjectForKey:@"id"];
    }
    [self setValuesForKeysWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
