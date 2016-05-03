//
//  ComicStoreBookContentListModel.h
//  ComicReader
//
//  Created by Jiang on 5/9/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComicStoreBookContentListModel : NSObject

@property (nonatomic, strong) NSNumber *BookID;
@property (nonatomic, strong) NSNumber *PicCount;
@property (nonatomic, strong) NSNumber *SectionID;

@property (nonatomic, copy) NSString *BookName;
@property (nonatomic, copy) NSString *PictureClassName;
@property (nonatomic, copy) NSString *SectionLinkURL;
@property (nonatomic, copy) NSString *SectionName;
@property (nonatomic, copy) NSString *SectionUrllist;

- (instancetype)initWithDictionary:(NSDictionary*)dict;
+ (NSArray*)modelArrayForDataArray:(NSArray*)dataArray;

@end
