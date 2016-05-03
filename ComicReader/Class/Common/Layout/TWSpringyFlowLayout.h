//
//  TWSpringyFlowLayout.h
//  CollectionView
//
//  Created by Terry Worona on 8/15/13.
//  Copyright (c) 2013 Terry Worona. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWSpringyFlowLayout : UICollectionViewFlowLayout

// Lower the number, bigger the bounce.
// 0 = crazy bounce bounce, 1000 = minimum bounce
- (id)initWithBounceFactor:(CGFloat)bounceFactor;
- (void)reloadLayout;

@end
