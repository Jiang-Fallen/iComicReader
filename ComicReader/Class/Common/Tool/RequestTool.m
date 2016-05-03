//
//  RequestTool.m
//  ComicReader
//
//  Created by Jiang on 14/12/10.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "RequestTool.h"
#import "AFNetworking.h"
#import "GetRequestUrlTool.h"

@interface RequestTool ()

@end

@implementation RequestTool

- (void)requestArrayByAsquireHeaderModelCompletion:(void (^)(NSDictionary *responseObject))success
                                           failure:(void (^)(NSError *))failure{
    
    NSString *urlString = [GetRequestUrlTool getRequestHeaderUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *downLoadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (location) {
            NSData *data = [NSData dataWithContentsOfFile:location.path];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                success(dict);
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });
        }
    }];
    [downLoadTask resume];
}

- (void)requestArrayByAsquireComicStoreListModelCompletion:(void (^)(NSDictionary *responseObject))success
                                                   failure:(void (^)(NSError *))failure{
   
    NSString *urlString = [GetRequestUrlTool getStoreListUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
//    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *downLoadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (location) {
            NSData *data = [NSData dataWithContentsOfFile:location.path];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            //            if ([[NSFileManager defaultManager] fileExistsAtPath:location.path]) {
            //                //获取已下载的文件长度
            //
            //            }
            dispatch_async(dispatch_get_main_queue(), ^{
                success(dict);
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });
        }
    }];
    [downLoadTask resume];
}

- (void)requestArrayByComicStoreRowListModel:(id)parameters
                                  Completion:(void (^)(NSDictionary *responseObject))success
                                     failure:(void (^)(NSError *error))failure
{
    NSString *urlString = [GetRequestUrlTool getStoreListMoreUrl];
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:parameters error:nil];
    request.timeoutInterval = 30.0;
    
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *data = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if(data){
//                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                success(dict);
//            }else{
//                failure(error);
//            }
//        });
//    }];
//    [data resume];
//    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *downLoadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (location) {
            NSData *data = [NSData dataWithContentsOfFile:location.path];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            //            if ([[NSFileManager defaultManager] fileExistsAtPath:location.path]) {
            //                //获取已下载的文件长度
            //
            //            }
            dispatch_async(dispatch_get_main_queue(), ^{
                success(dict);
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });
        }
    }];
    [downLoadTask resume];
}

- (unsigned long long)fileSizeForPath:(NSString *)path {
    signed long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager new]; // default is not thread safe
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
            }
        }
    return fileSize;
}

#pragma mark - 单例实现
static RequestTool *_instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedRequestTool{
    _instance = [[RequestTool alloc]init];
    return _instance;
}

@end
