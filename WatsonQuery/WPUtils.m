// WPUtils.m
//

#import "WPUtils.h"
#import <UIKit/UIKit.h>
#import "WPWatsonQuestionResponse.h"
#import "WPConstants.h"

@implementation WPUtils

+ (WPWatsonQuestionResponse*)buildResponseObjectWithData:(NSData*) data
{
    NSError *error;
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"data: %@", jsonResponse);
    WPWatsonQuestionResponse* res = [[WPWatsonQuestionResponse alloc] init];
    res.answers = [jsonResponse valueForKeyPath:PATH_TO_ANSWERS];
    res.evidence = [jsonResponse valueForKeyPath:PATH_TO_EVIDENCE];
    res.bestAnswer = [[jsonResponse valueForKeyPath:@"question.evidencelist.text"] firstObject];
    NSLog(@"best answer: %@", res.bestAnswer);
    return res;
}

+ (NSString*)getBase64AuthHeaderWithUsername:(NSString*) user andPassword:(NSString*) password
{
    NSString* base64Login = [NSString stringWithFormat:@"%@:%@", user, password];
    NSData *plainDataLogin = [base64Login dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64StringLogin = [NSString stringWithFormat:@"Basic %@", [plainDataLogin base64EncodedStringWithOptions:kNilOptions]];
    return base64StringLogin;
}


@end
