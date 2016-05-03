//
//  MyComicTool.h
//  ComicReader
//
//  Created by Jiang on 14/12/9.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyComicTool : NSObject

+ (NSArray*)comicModelWithDictionary:(NSDictionary*)dict;
- (NSArray*)parseComicModelWithDictionay:(NSDictionary*)dict;

@end
