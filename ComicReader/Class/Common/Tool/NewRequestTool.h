//
//  NewRequestTool.h
//  ComicReader
//
//  Created by Jiang on 3/25/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewRequestTool : NSObject

- (void)requestTitleModelCompletion:(void (^)(NSDictionary *responseObject))success
                                           failure:(void(^)(NSError *error))failure;

- (void)requestContentListModelCompletion:(NSString*)requestMethod
                               parameters:(id)parameters
                                  success:(void (^)(NSMutableArray *responseObject))success
                                  failure:(void (^)(NSError *error))failure;

+ (instancetype)sharedRequestTool;
@end
