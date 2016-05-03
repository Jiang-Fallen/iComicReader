//
//  MyComicContentModel.h
//  ComicReader
//
//  Created by Jiang on 14/12/9.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyComicContentModel : NSObject

@property (nonatomic, strong) NSNumber *bigbookid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *progresstype;
@property (nonatomic, copy) NSString *coverurl;
@property (nonatomic, copy) NSString *lastpartname;


- (instancetype)initWithDictionary:(NSDictionary*)dict;

- (void)setComicContentModelWithDictionary:(NSDictionary*)dict;

+ (instancetype)comicContentModelWithDictionary:(NSDictionary*)dict;

@end
