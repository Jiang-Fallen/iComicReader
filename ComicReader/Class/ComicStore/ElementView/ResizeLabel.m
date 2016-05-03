//
//  ResizeLabel.m
//  ComicReader
//
//  Created by Jiang on 1/12/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import "ResizeLabel.h"

@interface ResizeLabel ()

@property (nonatomic, assign) CGSize firstSize;
@end

@implementation ResizeLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.firstSize = frame.size;
    }
    return self;
}

- (void)setText:(NSString *)text
{
    CGRect rect = [text boundingRectWithSize:self.firstSize
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName: self.font}
                                     context:nil];
    
    rect.origin = self.frame.origin;
    rect.size.width = self.firstSize.width;
    self.frame = rect;
    [super setText:text];
}

@end
