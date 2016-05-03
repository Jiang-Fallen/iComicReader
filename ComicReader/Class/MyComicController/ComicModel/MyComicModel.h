//
//  MyComicModel.h
//  ComicReader
//
//  Created by Jiang on 14/12/9.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyComicModel : NSObject

@property (nonatomic, strong) NSArray *bigbooksjson;
@property (nonatomic, strong) NSNumber *mID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *targetargument;
@property (nonatomic, strong) NSNumber *targetmethod;


- (instancetype)initWithDictionary:(NSDictionary*)dict;

- (void)setComicModelWithDictionary:(NSDictionary*)dict;

+ (instancetype)comicModelWithDictionary:(NSDictionary*)dict;
@end
