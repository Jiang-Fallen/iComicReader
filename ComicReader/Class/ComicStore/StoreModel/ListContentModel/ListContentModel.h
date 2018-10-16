//
//  MyComicContentModel.h
//  ComicReader
//
//  Created by Jiang on 14/12/9.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListContentModel : NSObject

@property (nonatomic, strong) NSNumber *target_id;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSNumber *label_id;
@property (nonatomic, strong) NSNumber *is_favourite;
@property (nonatomic, strong) NSNumber *likes_count;

@property (nonatomic, copy) NSString *aID;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *aDescription;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSMutableArray *comics;

//自定义
@property (nonatomic, assign) BOOL isTitleCenter;
@property (nonatomic, assign) BOOL sortUP;

- (instancetype)initWithDictionary:(NSDictionary*)dict;

- (void)setComicContentModelWithDictionary:(NSDictionary*)dict;

+ (instancetype)comicContentModelWithDictionary:(NSDictionary*)dict;

+ (NSMutableArray*)modelArrayForDataArray:(NSArray*)dataArray;

@end
