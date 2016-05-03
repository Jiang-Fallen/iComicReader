//
//  DoumentTool.h
//  ComicReader
//
//  Created by Mr_J on 16/2/29.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocumentTool : NSObject

@property (nonatomic, strong) id headerData;

+ (instancetype)sharedDocumentTool;

@end
