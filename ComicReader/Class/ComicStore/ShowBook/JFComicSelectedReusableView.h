//
//  JFComicSelectedReusableViewCollectionReusableView.h
//  ComicReader
//
//  Created by Mr_J on 16/5/3.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol JFComicSelectedReusableViewDelegate <NSObject>

@optional
- (void)comicHeaderSelectedOfIndex:(NSInteger)index;
- (void)comicHeaderSortAction:(UIButton *)sender;

@end

@interface JFComicSelectedReusableView : UICollectionReusableView

@property (nonatomic, weak) id<JFComicSelectedReusableViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *selectedContentView;
@property (weak, nonatomic) IBOutlet UIButton *sortButton;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *selectedButtonArray;

@end
