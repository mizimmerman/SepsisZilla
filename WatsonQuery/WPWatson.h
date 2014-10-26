// WPWatson.h
//
//

#import <Foundation/Foundation.h>
#import "WPWatsonQuestionResponse.h"

@interface WPWatson : NSObject

@property (nonatomic, retain) NSMutableDictionary* responses;
@property (nonatomic, retain) NSString* currentQuestion;
@property (nonatomic, retain) NSOperationQueue* queue;

+(instancetype) sharedManager;
-(void) askQuestion:(NSString*) question completionHandler:(void (^)(NSString *response, NSError* connectionError)) block;

@end
