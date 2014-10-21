// WPConstants.h
//
// Copyright (c) 2014 Carlos Andreu

#import <Foundation/Foundation.h>

@interface WPConstants : NSObject

extern NSString* const MY_IDENTIFIER;

extern NSString * const SEGUE_SHOW_ANSWER_LIST;
extern NSString * const SEGUE_SHOW_RESULTS_DETAILS;

extern NSString * const KEY_TEXT;
extern NSString * const KEY_CONFIDENCE;

extern NSString * const PATH_TO_ANSWERS;
extern NSString * const PATH_TO_EVIDENCE;

extern NSString * const URL_WATSON_ASK_QUESTION_TEMPLATE;
extern NSString * const WATSON_ASK_QUESTION_PAYLOAD_TEMPLATE;

extern NSString * const KEY_CONFIG_PLIST_USER;
extern NSString * const KEY_CONFIG_PLIST_PASSWORD;
extern NSString * const KEY_CONFIG_PLIST_WATSON_INSTANCE_ID;

extern NSString * const CONFIG_PLIST_FILE_NAME;
extern NSString * const CONFIG_PLIST_EXTENSION;

extern NSUInteger const MAX_NUM_QUESTION_CACHED;

@end
