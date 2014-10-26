// WPWatson.m
//

#import "WPWatson.h"
#import "WPUtils.h"
#import "WPConstants.h"

@implementation WPWatson

+ (instancetype)sharedManager {
    static WPWatson *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [self new];
    });
    return sharedManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.currentQuestion = @"";
        self.responses = [NSMutableDictionary dictionary];
        self.queue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)askQuestion:(NSString*)question completionHandler:(void (^)(NSString *response, NSError* connectionError))callback {
    self.currentQuestion = question;
    NSString *path = [[NSBundle mainBundle] pathForResource:CONFIG_PLIST_FILE_NAME ofType:CONFIG_PLIST_EXTENSION];
    NSDictionary *config = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSString* user = config[KEY_CONFIG_PLIST_USER];
    NSString* pass = config[KEY_CONFIG_PLIST_PASSWORD];
    NSString* instanceId = config[KEY_CONFIG_PLIST_WATSON_INSTANCE_ID];
    if (![user length] || ![pass length] || ![instanceId length]) {
        callback(@"no user or pass, no repsonse", nil);
        return;
    }
    NSString* urlWithInstanceId = [NSString stringWithFormat:URL_WATSON_ASK_QUESTION_TEMPLATE, instanceId];
    NSURL* url = [NSURL URLWithString:urlWithInstanceId];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod: @"POST"];
    [request setValue:@"30" forHTTPHeaderField:@"X-SyncTimeout"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    NSString* authHeader = [WPUtils getBase64AuthHeaderWithUsername:user andPassword:pass];
    [request setValue:authHeader forHTTPHeaderField:@"Authorization"];
    
    NSDictionary *questionStr = @{@"question": @{@"questionText": question, @"items":@1}};
    NSError *error;
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:questionStr options:NSJSONWritingPrettyPrinted error:&error];
//    NSString *s = [NSJSONSerialization JSONObjectWithData:request.HTTPBody options:NSJSONReadingAllowFragments error:&error];
//    NSLog(@"request: %@", s);
    [NSURLConnection sendAsynchronousRequest:request queue:self.queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            NSLog(@"Error contacting the server: %@", error);
            callback(@"", error);
        } else {
//            NSLog(@"%@", data);
            [self _saveWithResponseData:data andQuestion:question];
            WPWatsonQuestionResponse* res = [WPUtils buildResponseObjectWithData:data];
            callback(res.bestAnswer, error);
        }
    }];
}

#pragma mark PRIVATE

- (void)_saveWithResponseData:(NSData*) data andQuestion:(NSString*) question {
    WPWatsonQuestionResponse* res = [WPUtils buildResponseObjectWithData:data];
    [self.responses setObject:res forKey:question];
}

@end
