//
//  NewStoreModel.h
//  ComicReader
//
//  Created by Jiang on 3/25/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListContentModel.h"

@interface NewStoreTitleModel : NSObject

@property (nonatomic, copy) NSNumber *action;
@property (nonatomic, copy) NSNumber *action_type;
@property (nonatomic, copy) NSNumber *item_type;
@property (nonatomic, copy) NSString *show_login_view;
@property (nonatomic, copy) NSString *title;

#pragma mark 自定义属性
//自定义cell样式
@property (nonatomic, assign, readonly) NSInteger type;
//内容列表数据
@property (nonatomic, strong) NSMutableArray *banners;
@property (nonatomic, strong) NSMutableArray *topics;
//cell显示内容个数
@property (nonatomic, assign, readonly) NSInteger contentCount;
//cell高度
@property (nonatomic, assign, readonly) CGFloat contentCellHeight;

- (instancetype)initWithDictionary:(NSDictionary*)dict;
+ (NSMutableArray*)modelArrayByDataArray:(NSArray*)array;

@end
