//
//  GetRequestUrlTool.h
//  ComicReader
//
//  Created by Jiang on 1/13/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetRequestUrlTool : NSObject

+ (NSString*)getRequestHeaderUrl;
+ (NSString*)getStoreListUrl;
+ (NSString*)getStoreListMoreUrl;

//newURL
+ (NSString*)getNEWStoreTitleListUrl;
+ (NSString*)getNEWStoreContentListUrl:(NSString*)requestMethod;

@end
