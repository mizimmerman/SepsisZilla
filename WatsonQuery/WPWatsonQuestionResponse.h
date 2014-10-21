// WPWatsonQuestionResponse.h
//

#import <Foundation/Foundation.h>

@interface WPWatsonQuestionResponse : NSObject

@property (nonatomic, strong) NSArray* answers;
@property (nonatomic, strong) NSArray* evidence;
@property (nonatomic) NSString *bestAnswer;

@end
