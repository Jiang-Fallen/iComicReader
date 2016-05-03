//
//  MyComicContentModel.h
//  ComicReader
//
//  Created by Jiang on 14/12/9.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListContentModel : NSObject

@property (nonatomic, strong) NSNumber *comics_count;
@property (nonatomic, strong) NSNumber *comments_count;
@property (nonatomic, strong) NSNumber *created_at;
@property (nonatomic, strong) NSNumber *is_favourite;
@property (nonatomic, strong) NSNumber *label_id;
@property (nonatomic, strong) NSNumber *likes_count;
@property (nonatomic, strong) NSNumber *order;
@property (nonatomic, strong) NSNumber *updated_at;
@property (nonatomic, strong) NSNumber *user_id;

@property (nonatomic, copy) NSString *aID;
@property (nonatomic, copy) NSString *cover_image_url;
@property (nonatomic, copy) NSString *aDescription;
@property (nonatomic, copy) NSString *discover_image_url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *vertical_image_url;

@property (nonatomic, strong) NSMutableArray *comics;

//自定义
@property (nonatomic, assign) BOOL isTitleCenter;
@property (nonatomic, assign) BOOL sortUP;

- (instancetype)initWithDictionary:(NSDictionary*)dict;

- (void)setComicContentModelWithDictionary:(NSDictionary*)dict;

+ (instancetype)comicContentModelWithDictionary:(NSDictionary*)dict;

+ (NSMutableArray*)modelArrayForDataArray:(NSArray*)dataArray;

@end
