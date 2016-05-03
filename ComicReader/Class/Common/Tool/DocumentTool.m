//
//  DoumentTool.m
//  ComicReader
//
//  Created by Mr_J on 16/2/29.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "DocumentTool.h"

@interface DocumentTool ()

@property (nonatomic, copy) NSString *path;

@end

static DocumentTool *documentInstance;

@implementation DocumentTool
@synthesize headerData = _headerData;

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        documentInstance = [super allocWithZone:zone];
    });
    return documentInstance;
}

+ (instancetype)sharedDocumentTool{
    documentInstance = [[DocumentTool alloc]init];
    return documentInstance;
}

- (NSString *)path{
    if (!_path) {
        _path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    }
    return _path;
}

- (NSString *)pathWithName:(NSString *)name{
    return [self.path stringByAppendingPathComponent:name];
}

- (void)setHeaderData:(id)headerData{
    _headerData = headerData;
    [NSKeyedArchiver archiveRootObject:headerData toFile:[self pathWithName:@"headerData.plist"]];
}

- (id)headerData{
    if (!_headerData) {
        _headerData = [NSKeyedUnarchiver unarchiveObjectWithFile:[self pathWithName:@"headerData.plist"]];
    }
    return _headerData;
}

@end
