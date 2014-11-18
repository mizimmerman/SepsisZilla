//
//  SPSTrendViewCell.h
//  WatsonQuery
//
//  Created by gazevedo on 11/10/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPSGraphDataSource.h"

@class SPSGraphView;

@interface SPSTrendViewCell : UICollectionViewCell

@property (nonatomic) NSString *headerText;
@property (nonatomic) NSString *summaryText;

-(void)setGraphDataSource:(id<SPSGraphDataSource>)dataSource;
-(void)setType:(SPSGraphType)type;

@end
