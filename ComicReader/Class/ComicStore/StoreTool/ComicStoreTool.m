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
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *array = responseObject[@"data"][@"banner_group"];
        if (array && array.count > 0) {
            [DocumentTool sharedDocumentTool].headerData = array;
        }else{
            array = [DocumentTool sharedDocumentTool].headerData;
        }
        
        NSMutableArray *modelArray = [HeaderModel modelArrayForDataArray:array];
        success(modelArray);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

- (void)requestArrayByComicStoreListModelCompletion:(void (^)(NSMutableArray *blockListArray))success
                                               failure:(void (^)(NSError *error))failure{
    
    RequestTool *request = [RequestTool sharedRequestTool];
    [request requestArrayByAsquireComicStoreListModelCompletion:^(NSDictionary *responseObject) {

    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)requestArrayByComicStoreModelCompletion:(void (^)(NSMutableArray *blockHeaderArray,
                                                          NSMutableArray *blockListArray))success
                                        failure:(void (^)(NSError *error))failure
{
    [self requestArrayByAsquireHeaderModelCompletion:^(NSMutableArray *blockHeaderArray) {
        [self requestArrayByComicStoreListModelCompletion:^(NSMutableArray *blockListArray) {
            success(blockHeaderArray, blockListArray);
        } failure:^(NSError *error) {
            failure(error);
        }];
    } failure:^(NSError *error) {
        failure(error);
    }];
}


- (void)requestComicStoreNewModelCompletion:(void (^)(NSMutableArray *blockHeaderArray,
                                                      NSMutableArray *blockListArray))success
                                    failure:(void (^)(NSError *error))failure
{
    NewRequestTool *request = [NewRequestTool sharedRequestTool];
    [self requestArrayByAsquireHeaderModelCompletion:^(NSMutableArray *blockHeaderArray) {
        [request requestTitleModelCompletion:^(NSDictionary *responseObject) {
            NSMutableArray *array = [NewStoreTitleModel modelArrayByDataArray:responseObject[@"data"][@"suggestion"]];
            success(blockHeaderArray, array);
        } failure:^(NSError *error) {
            failure(error);
        }];
    } failure:^(NSError *error) {
        failure(error);
    }];
}
- (void)requestComicStoreContentListNewModelCompletion:(NSString*)requestMethod
                               parameters:(id)parameters
                                  success:(void (^)(NSMutableArray *))success
                                  failure:(void (^)(NSError *))failure
{
    [[NewRequestTool sharedRequestTool] requestContentListModelCompletion:requestMethod parameters:parameters success:^(NSMutableArray *responseObject) {
        
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
