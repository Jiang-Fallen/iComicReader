//
//  JFComicMoreViewController.h
//  ComicReader
//
//  Created by Mr_J on 16/5/1.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFComicMoreViewController : UIViewController

@property (nonatomic, copy) NSString *requestType;
@property (nonatomic, assign, readonly) BOOL isSearch;

- (instancetype)initWithRequestSearch:(BOOL)isSearch;

@end
