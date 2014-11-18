//
//  SPSGraphView.h
//  WatsonQuery
//
//  Created by gazevedo on 11/10/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPSGraphDataSource.h"

@interface SPSGraphView : UIView

@property (nonatomic) id<SPSGraphDataSource> dataSource;
@property (nonatomic) SPSGraphType type;

@end
