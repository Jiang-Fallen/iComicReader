//
//  JFComicReaderBookModel.h
//  ComicReader
//
//  Created by Mr_J on 16/5/2.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFComicReaderBookContentModel.h"

@interface JFComicReaderBookModel : NSObject

@property (nonatomic, copy) NSString *cover_image_url;
@property (nonatomic, copy) NSString *aID;

@property (nonatomic, strong) NSNumber *created_at;

@property (nonatomic, strong) NSMutableArray *images;

- (instancetype)initWithDictionary:(NSDictionary*)dict;

@end
