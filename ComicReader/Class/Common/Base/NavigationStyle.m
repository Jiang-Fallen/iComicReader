//
//  NavigationStyle.m
//  ComicReader
//
//  Created by Jiang on 14/12/11.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "NavigationStyle.h"

@implementation NavigationStyle

- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self setTranslucent:NO];
    }
    return self;
}

@end
