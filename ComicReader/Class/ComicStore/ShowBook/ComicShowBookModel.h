//
//  ComicShowBookModel.h
//  ComicReader
//
//  Created by Jiang on 5/9/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComicShowBookModel : NSObject

@property (nonatomic, strong) NSNumber *BookClickCount;
@property (nonatomic, strong) NSNumber *BookColor;
@property (nonatomic, strong) NSNumber *BookDownCount;
@property (nonatomic, strong) NSNumber *BookID;
@property (nonatomic, strong) NSNumber *BookState;
@property (nonatomic, strong) NSNumber *CatalogID;
@property (nonatomic, strong) NSNumber *SiteID;

@property (nonatomic, copy) NSString *BookAuthor;
@property (nonatomic, copy) NSString *BookColorName;
@property (nonatomic, copy) NSString *BookCreationDate;
@property (nonatomic, copy) NSString *BookDescription;
@property (nonatomic, copy) NSString *BookExceptUpdateDate;
@property (nonatomic, copy) NSString *BookIconOtherURL;
@property (nonatomic, copy) NSString *BookIconSelfURL;
@property (nonatomic, copy) NSString *BookLinkURL;
@property (nonatomic, copy) NSString *BookName;
@property (nonatomic, copy) NSString *BookStateName;
@property (nonatomic, copy) NSString *BookUpdateDate;
@property (nonatomic, copy) NSString *BookUpdateSection;
@property (nonatomic, copy) NSString *CatalogName;
@property (nonatomic, copy) NSString *FistIndex;
@property (nonatomic, copy) NSString *SiteName;


- (instancetype)initWithDictionary:(NSDictionary*)dict;
+ (NSArray*)modelArrayForDataArray:(NSArray*)dataArray;

@end
