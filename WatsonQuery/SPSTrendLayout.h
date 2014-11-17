//
//  SPSTrendLayout.h
//  WatsonQuery
//
//  Created by gazevedo on 11/10/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SPSTrendLayoutSizer <NSObject>

-(CGSize)itemSize;

@end

@interface SPSTrendLayout : UICollectionViewFlowLayout

@end