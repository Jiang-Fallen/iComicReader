//
//  RequestTool.h
//  ComicReader
//
//  Created by Jiang on 14/12/10.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  AFHTTPRequestOperation;

@interface RequestTool : NSObject

- (void)requestArrayByAsquireHeaderModelCompletion:(void (^)(NSDictionary *responseObject))success
                                           failure:(void(^)(NSError *error))failure;

- (void)requestArrayByAsquireComicStoreListModelCompletion:(void(^)(NSDictionary *responseObject))success
                                            failure:(void(^)(NSError *error))failure;

- (void)requestArrayByComicStoreRowListModel:(id)parameters
                                  Completion:(void (^)(NSDictionary *responseObject))success
                                     failure:(void (^)(NSError *error))failure;

+ (instancetype)sharedRequestTool;

@end
