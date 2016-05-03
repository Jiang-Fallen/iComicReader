//
//  TWSpringyFlowLayout.m
//  CollectionView
//
//  Created by Terry Worona on 8/15/13.
//  Copyright (c) 2013 Terry Worona. All rights reserved.
//

#import "TWSpringyFlowLayout.h"

// Numerics
CGFloat const kTWSpringyFlowLayoutDefaultBounce = 500.0f;

@interface TWSpringyFlowLayout ()

@property (nonatomic, assign) CGFloat bounceFactor;

@end

@implementation TWSpringyFlowLayout{
	UIDynamicAnimator *_dynamicAnimator;
}

#pragma mark - Alloc/Init

- (id)initWithBounceFactor:(CGFloat)bounceFactor
{
	self = [super init];
	if (self)
	{
		_bounceFactor = bounceFactor;
	}
	return self;
}

- (id)init
{
	return [self initWithBounceFactor:kTWSpringyFlowLayoutDefaultBounce];
}

#pragma - Prepareness

- (void)prepareLayout
{
	[super prepareLayout];
	
	if (!_dynamicAnimator)
	{
        [self reloadLayout];
	}
}

- (void)reloadLayout{
    _dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
    
    CGSize contentSize = [self collectionViewContentSize];
    NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
    
    for (UICollectionViewLayoutAttributes *item in items)
    {
        UIAttachmentBehavior *spring = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:[item center]];
        spring.length = 0;
        spring.damping = 0.5;
        spring.frequency = 0.8;
        [_dynamicAnimator addBehavior:spring];
    }
}

#pragma mark - Layout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
	return [_dynamicAnimator itemsInRect:rect];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return [_dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
	UIScrollView *scrollView = self.collectionView;
	CGFloat scrollDelta = newBounds.origin.y - scrollView.bounds.origin.y;
	CGPoint touchLocation = [scrollView.panGestureRecognizer locationInView:scrollView];
	
	for (UIAttachmentBehavior *spring in _dynamicAnimator.behaviors)
	{
		CGPoint anchorPoint = spring.anchorPoint;
		CGFloat distanceFromTouch = fabs(touchLocation.y - anchorPoint.y);
		CGFloat scrollResistance = distanceFromTouch / _bounceFactor; // higher the number, larger the bounce
		
		UICollectionViewLayoutAttributes *item = [spring.items firstObject];
		CGPoint center = item.center;
		center.y += scrollDelta * scrollResistance;
		item.center = center;
		
		[_dynamicAnimator updateItemUsingCurrentState:item];
	}
	
	return YES;
}

@end
