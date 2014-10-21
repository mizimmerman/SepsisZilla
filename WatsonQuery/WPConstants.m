// WPConstants.m
//
// Copyright (c) 2014 Carlos Andreu
//

#import "WPConstants.h"

@implementation WPConstants

NSString* const MY_IDENTIFIER = @"myIdentifier";

NSString* const SEGUE_SHOW_ANSWER_LIST = @"showAnswerList";
NSString* const SEGUE_SHOW_RESULTS_DETAILS = @"ShowResultDetails";

NSString* const KEY_TEXT = @"text";
NSString* const KEY_CONFIDENCE = @"confidence";

NSString* const FAKE_FILE_NAME = @"fake";
NSString* const FAKE_FILE_EXTENSION = @"json";

NSString* const PATH_TO_ANSWERS = @"question.answers";
NSString* const PATH_TO_EVIDENCE = @"question.evidencelist";

NSString* const URL_WATSON_ASK_QUESTION_TEMPLATE = @"https://watson-wdc01.ihost.com/instance/%@/deepqa/v1/question";
NSString* const WATSON_ASK_QUESTION_PAYLOAD_TEMPLATE = @"{\"question\": {\"questionText\": \"%@\"}}";

NSString* const KEY_CONFIG_PLIST_USER = @"user";
NSString* const KEY_CONFIG_PLIST_PASSWORD = @"password";
NSString* const KEY_CONFIG_PLIST_WATSON_INSTANCE_ID = @"instance-id";

NSString* const CONFIG_PLIST_FILE_NAME = @"config";
NSString* const CONFIG_PLIST_EXTENSION = @"plist";

NSUInteger const MAX_NUM_QUESTION_CACHED = 3;

@end
