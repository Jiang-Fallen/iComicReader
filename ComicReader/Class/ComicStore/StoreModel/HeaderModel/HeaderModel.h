//
//  HeaderModel.h
//  ComicReader
//
//  Created by Jiang on 14/12/10.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeaderModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *pic;

@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSNumber *value;

+ (instancetype)headerModelWithDictionary:(NSDictionary*)dict;
- (instancetype)initWithDictionary:(NSDictionary*)dict;

+ (NSMutableArray *)modelArrayForDataArray:(NSArray *)dataArray;

@end
