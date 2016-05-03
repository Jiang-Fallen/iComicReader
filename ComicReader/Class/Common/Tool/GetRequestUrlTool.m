//
//  GetRequestUrlTool.m
//  ComicReader
//
//  Created by Jiang on 1/13/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import "GetRequestUrlTool.h"

@interface GetRequestUrlTool ()

@end

@implementation GetRequestUrlTool

+ (NSString*)getRequestHeaderUrl
{
    NSString *urlString = [NSString stringWithFormat:
                           @"%@/%@?%@&%@&%@&%@&%@",
                           kRequestURL,
                           kGetProad,
                           [GetRequestUrlTool getDeviceInfo],
                           kChannelid,
                           kChannelId,
                           kPlatformtype,
                           kAdgroupid];
    return urlString;
}
//platformtype=2&channelId=tongbu&appVersionName=2.4.0&mobileModel=iPod5,1&osVersionCode=7.1.1&channelid=tongbu
//appVersionName=2.4.0&mobileModel=iPod5,1&osVersionCode=7.1.1&channelid=tongbu&channelId=tongbu&platformtype=2&adgroupid=4

//mhjk.1391.com/comic/getproad?appVersionName=2.4.2&mobileModel=iPod5,1&osVersionCode=7.1.1&channelid=manhuadao&channelId=manhuadao&platformtype=2&adgroupid=4

+ (NSString*)getStoreListUrl
{
    NSString *urlString = [NSString stringWithFormat:
                           @"%@/%@?%@&%@&%@&%@",
                           kRequestURL,
                           kGetalbumlist,
                           [GetRequestUrlTool getDeviceInfo],
                           kChannelid,
                           kChannelId,
                           kPlatformtype];
    return urlString;
}

+ (NSString*)getStoreListMoreUrl
{
    NSString *urlString = [NSString stringWithFormat:
                           @"%@/%@?%@&%@",
                           kRequestURL,
                           kComicslist_v2,
                           kChannelId,
                           [GetRequestUrlTool getDeviceInfo]];
    return urlString;
}
//mhjk.1391.com/comic/comicslist_v2?channelId=manhuadao&appVersionName=2.4.2&mobileModel=iPod5,1&osVersionCode=7.1.1

#pragma mark - newURL
+ (NSString*)getNEWStoreTitleListUrl{
    NSString *urlString = [NSString stringWithFormat:@"%@?method=%@",
                          kNewRequestURL,
                          kNewTitleMethod];
    return urlString;
}

+ (NSString*)getNEWStoreContentListUrl:(NSString*)requestMethod{
    NSString *urlString = [NSString stringWithFormat:@"%@?method=%@",
                           kNewRequestURL,
                           requestMethod];
    return urlString;
}

#pragma mark showbook
//http://112.124.96.190:9090/manhuakong4yuansen0520/ComicHandle.ashx?method=booksite&bookname=%E7%81%AB%E5%BD%B1%E5%BF%8D%E8%80%85&bookid=5103

#pragma mark -

+ (NSString*)getDeviceInfo{
    NSString *deviceInfo = [NSString stringWithFormat:
                           @"%@&%@&%@",
                           kAppVersionName,
                           [GetRequestUrlTool mobileModel],
                           [GetRequestUrlTool osVer]];
    return deviceInfo;
}

#pragma mark -

+ (NSString *)osVer{
    NSString *osVer = [NSString stringWithFormat:
                  @"%@=%@", kOsVersionCode, [[UIDevice currentDevice] systemVersion]];
    
    return osVer;
}

+ (NSString *)mobileModel{
    NSString *mobileModel = [NSString stringWithFormat:
                        @"%@=iPhone4,1", kMobileModel];
    return mobileModel;
}

@end