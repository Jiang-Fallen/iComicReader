//
//  NewStoreModel.h
//  ComicReader
//
//  Created by Jiang on 3/25/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewStoreTitleModel : NSObject

@property (nonatomic, copy) NSNumber *priority;
@property (nonatomic, copy) NSNumber *tag_id;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;

#pragma mark 自定义属性
//自定义cell样式
@property (nonatomic, assign, readonly) NSInteger type;
//内容列表数据
@property (nonatomic, strong) NSMutableArray *contentArray;
//cell显示内容个数
@property (nonatomic, assign, readonly) NSInteger contentCount;
//cell高度
@property (nonatomic, assign, readonly) CGFloat contentCellHeight;

- (instancetype)initWithDictionary:(NSDictionary*)dict;
+ (NSMutableArray*)modelArrayByDataArray:(NSArray*)array;

@end
