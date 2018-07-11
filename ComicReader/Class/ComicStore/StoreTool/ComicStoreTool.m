//
//  ComicStoreTool.m
//  ComicReader
//
//  Created by Jiang on 1/13/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import "ComicStoreTool.h"
#import "RequestTool.h"
#import "HeaderModel.h"
#import "NewRequestTool.h"
#import "NewStoreTitleModel.h"
#import "AFNetworking.h"
#import "DocumentTool.h"


@implementation ComicStoreTool

#pragma mark - Request Method
- (void)requestArrayByAsquireHeaderModelCompletion:(void (^)(NSMutableArray *blockHeaderArray))success
                                           failure:(void (^)(NSError *))failure{
    
    NSString *urlString = @"http://api.kuaikanmanhua.com/v1/banners";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = responseObject[@"data"][@"banner_group"];
        if (array && array.count > 0) {
            [DocumentTool sharedDocumentTool].headerData = array;
        }else{
            array = [DocumentTool sharedDocumentTool].headerData;
        }
        
        NSMutableArray *modelArray = [HeaderModel modelArrayForDataArray:array];
        success(modelArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)requestBannerList:(void (^)(NSMutableArray *blockListArray))success
                  failure:(void (^)(NSError *error))failure{
    
    NSString *urlString = @"https://api.kkmh.com/v1/topic_new/discovery_list";
    
    NSDictionary *params = @{@"gender": @1,
                             @"operator_count": @9,
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] != 200) {
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:[responseObject[@"code"] intValue] userInfo:nil];
            failure(error);
            return ;
        }
        NSArray *infos = responseObject[@"data"][@"infos"];
        
        if (!infos || infos.count == 0) {
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:[responseObject[@"code"] intValue] userInfo:nil];
            failure(error);
            return;
        }
        
        NSArray *array = infos.firstObject[@"topics"];
        NSMutableArray *modelArray = [HeaderModel modelArrayForDataArray:array];
        success(modelArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)requestNewsList:(void (^)(NSMutableArray *blockListArray))success
                failure:(void (^)(NSError *error))failure{
    
    NSString *urlString = @"https://api.kkmh.com/v1/daily/comic_lists/0";
    
    NSDictionary *params = @{@"gender": @1,
                             @"new_device": @NO,
                             @"since": @0,
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] != 200) {
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:[responseObject[@"code"] intValue] userInfo:nil];
            failure(error);
            return ;
        }
        NSArray *array = responseObject[@"data"][@"comics"];
        
        NSMutableArray *modelArray = [HeaderModel modelArrayForNewsData:array];
        success(modelArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)requestCategoryList:(void (^)(NSMutableArray *blockListArray))success
                    failure:(void (^)(NSError *error))failure{
    
    NSString *urlString = @"https://api.kkmh.com/v1/topic_new/lists/get_by_tag";
    
    NSDictionary *params = @{@"count": @20,
                             @"since": @0,
                             @"tag": @0,
                             @"gender": @1,
                             @"sort": @1,
                             @"query_category": @{@"pay_status": @-1, @"update_status": @-1}
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] != 200) {
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:[responseObject[@"code"] intValue] userInfo:nil];
            failure(error);
            return ;
        }
        NSArray *array = responseObject[@"data"][@"tags"];
        NSMutableArray *modelArray = [NewStoreTitleModel modelArrayByDataArray:array];
        success(modelArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)requestComicStoreNewModelCompletion:(void (^)(NSMutableArray *blockHeaderArray,
                                                      NSMutableArray *blockListArray))success
                                    failure:(void (^)(NSError *error))failure
{
    __weak typeof(self) weakSelf = self;
    [self requestNewsList:^(NSMutableArray *blockHeaderArray) {
        [weakSelf requestCategoryList:^(NSMutableArray *blockListArray) {
            success(blockHeaderArray, blockListArray);
        }failure:^(NSError *error) {
            failure(error);
        }];
    } failure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark - 单例实现
static ComicStoreTool *_instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedRequestTool{
    _instance = [[ComicStoreTool alloc]init];
    return _instance;
}

@end
