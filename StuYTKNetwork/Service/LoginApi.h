//
//  LoginApi.h
//  StuYTKNetwork
//
//  Created by abc on 12/15/22.
//

#import <YTKNetwork/YTKNetwork.h>
#import "MyRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginApi : MyRequest
- (id)initWithUsername:(NSString *)username password:(NSString *)password;
@end

NS_ASSUME_NONNULL_END
