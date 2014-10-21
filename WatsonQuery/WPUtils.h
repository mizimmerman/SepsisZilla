// WPUtils.h
//
// Copyright (c) 2014 Carlos Andreu

#import <Foundation/Foundation.h>
#import "WPWatsonQuestionResponse.h"
#import <UIKit/UIKit.h>

@interface WPUtils : NSObject

+(WPWatsonQuestionResponse*) buildResponseObjectWithData:(NSData*) data;
+(NSString*) getBase64AuthHeaderWithUsername:(NSString*)user andPassword:(NSString*) password;

@end
