//
//  ViewController.m
//  WatsonQuery
//
//  Created by Greg Azevedo on 10/15/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSDictionary *question = @{@"question": @[
                                       @{@"questionText": @"What is sepsis?"},
                                       @{@"items":@4}]};
    NSURL *url = [NSURL URLWithString:@"https://watsonwdc01.ihost.com/instance/509/deepqa/v1/question"]; //instance #: 509
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPAdditionalHeaders = @{@"api-key": @"API_KEY"};
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSError *error;
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:question options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPMethod = @"POST";
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) { }];
    [postDataTask resume];
}
                                          
- (NSData *)httpBodyForDictionary:(NSDictionary *)dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:question
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

+(NSString*) getBase64AuthHeaderWithUsername:(NSString*) user andPassword:(NSString*) password
{
    NSString* base64Login = [NSString stringWithFormat:@"%@:%@", user, password];
    
    NSData *plainDataLogin = [base64Login dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64StringLogin = [NSString stringWithFormat:@"Basic %@", [plainDataLogin base64EncodedStringWithOptions:kNilOptions]];
    
    return base64StringLogin;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
