//
//  WebServerManager.h
//  StuYTKNetwork
//
//  Created by abc on 12/17/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebServerManager : NSObject
+ (instancetype)sharedInstance;
- (void)startHttp;
@end

NS_ASSUME_NONNULL_END
