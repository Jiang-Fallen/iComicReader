//
//  NSMutableAttributedString+TitleTreatment.m
//  ComicReader
//
//  Created by Jiang on 1/13/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import "NSMutableAttributedString+TitleTreatment.h"

@implementation NSMutableAttributedString (TitleTreatment)

+ (instancetype)titleWithName:(NSString*)name Hits:(NSString*)hits
{
    NSString *string = [NSString stringWithFormat:@"%@%@", name, hits];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:string];
    NSRange rangName = NSMakeRange(0, name.length);
    NSRange rangHist = NSMakeRange(name.length, hits.length);
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:rangName];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:rangHist];
    return str;
}

@end
