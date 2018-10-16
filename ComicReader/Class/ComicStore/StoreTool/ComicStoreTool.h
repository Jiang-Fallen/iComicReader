//
//  ComicStoreTool.h
//  ComicReader
//
//  Created by Jiang on 1/13/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComicStoreTool : NSObject

+ (AFHTTPSessionManager *)requestManager;

- (void)requestArrayByAsquireHeaderModelCompletion:(void (^)(NSMutableArray *blockHeaderArray))success
                                           failure:(void (^)(NSError *error))failure;

//new
- (void)requestComicStoreNewModelCompletion:(void (^)(NSMutableArray *blockHeaderArray,
                                                          NSMutableArray *blockListArray))success
                                        failure:(void (^)(NSError *error))failure;
+ (instancetype)sharedRequestTool;
@end
