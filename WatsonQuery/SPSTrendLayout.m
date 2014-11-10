//
//  SPSTrendLayout.m
//  WatsonQuery
//
//  Created by gazevedo on 11/10/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import "SPSTrendLayout.h"

@implementation SPSTrendLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    }
    return self;
}


- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)offset withScrollingVelocity:(CGPoint)velocity {
    
    CGRect cvBounds = self.collectionView.bounds;
    CGFloat halfWidth = cvBounds.size.width * 0.5f;
    CGFloat proposedContentOffsetCenterX = offset.x + halfWidth;
    NSArray* attributesArray = [self layoutAttributesForElementsInRect:cvBounds];
    UICollectionViewLayoutAttributes* candidateAttributes;
    for (UICollectionViewLayoutAttributes* attributes in attributesArray) {
        // == Skip comparison with non-cell items (headers and footers) == //
        if (attributes.representedElementCategory != UICollectionElementCategoryCell) {
            continue;
        }
        // == First time in the loop == //
        if(!candidateAttributes) {
            candidateAttributes = attributes;
            continue;
        }
        if (fabsf(attributes.center.x - proposedContentOffsetCenterX) < fabsf(candidateAttributes.center.x - proposedContentOffsetCenterX)) {
            candidateAttributes = attributes;
        }
    }
    return CGPointMake(candidateAttributes.center.x - halfWidth, offset.y);
}

@end
