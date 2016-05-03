//
//  ComicStoreTool.h
//  ComicReader
//
//  Created by Jiang on 1/13/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComicStoreTool : NSObject

- (void)requestArrayByAsquireHeaderModelCompletion:(void (^)(NSMutableArray *blockHeaderArray))success
                                           failure:(void (^)(NSError *error))failure;

- (void)requestArrayByComicStoreListModelCompletion:(void (^)(NSMutableArray *blockListArray))success
                                            failure:(void (^)(NSError *error))failure;

- (void)requestArrayByComicStoreRowListModel:(id)parameters
                                  Completion:(void (^)(NSMutableArray *blockRowListArray))success
                                     failure:(void (^)(NSError *error))failure;

- (void)requestArrayByComicStoreModelCompletion:(void (^)(NSMutableArray *blockHeaderArray,
                                                          NSMutableArray *blockListArray))success
                                        failure:(void (^)(NSError *error))failure;

//new
- (void)requestComicStoreNewModelCompletion:(void (^)(NSMutableArray *blockHeaderArray,
                                                          NSMutableArray *blockListArray))success
                                        failure:(void (^)(NSError *error))failure;

- (void)requestComicStoreContentListNewModelCompletion:(NSString*)requestMethod
                                            parameters:(id)parameters
                                               success:(void (^)(NSMutableArray *blockRowListArray))success
                                               failure:(void (^)(NSError *error))failure;
+ (instancetype)sharedRequestTool;
@end
