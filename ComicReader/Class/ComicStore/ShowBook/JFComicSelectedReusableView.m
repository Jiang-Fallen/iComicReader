//
//  JFComicSelectedReusableViewCollectionReusableView.m
//  ComicReader
//
//  Created by Mr_J on 16/5/3.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "JFComicSelectedReusableView.h"

@interface JFComicSelectedReusableView ()

@property (nonatomic, strong) CALayer *selectedLayer;

@end

@implementation JFComicSelectedReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self addSelectedBar];
}


- (void)addSelectedBar{
    self.selectedLayer = [CALayer layer];
    self.selectedLayer.frame = CGRectMake(0, self.selectedContentView.height - 2, (self.width - 2)/ 2, 2);
    self.selectedLayer.zPosition = 10;
    self.selectedLayer.backgroundColor = UIColorFromRGB(0xffbf00).CGColor;
    [self.selectedContentView.layer addSublayer:self.selectedLayer];
    
    UIButton *button = self.selectedButtonArray[1];
    [button sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)sortButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(comicHeaderSortAction:)]){
        [self.delegate comicHeaderSortAction:sender];
    }
}

- (IBAction)selectedButtonAction:(UIButton *)sender {
    for (UIButton *button in self.selectedButtonArray) {
        if (button == sender) {
            button.selected = YES;
            
            [CATransaction begin];
            [CATransaction setDisableActions:YES];
            CGPoint center = self.selectedLayer.position;
            center.x = button.centerX;
            self.selectedLayer.position = center;
            [CATransaction commit];
        }else{
            button.selected = NO;
        }
    }
    if ([self.delegate respondsToSelector:@selector(comicHeaderSelectedOfIndex:)]) {
        [self.delegate comicHeaderSelectedOfIndex:[self.selectedButtonArray indexOfObject:sender]];
    }
}

@end
