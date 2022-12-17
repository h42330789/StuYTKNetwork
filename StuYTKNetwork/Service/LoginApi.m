//
//  LoginApi.m
//  StuYTKNetwork
//
//  Created by abc on 12/15/22.
//

#import "LoginApi.h"

@implementation LoginApi {
    NSString *_username;
    NSString *_password;
}

- (id)initWithUsername:(NSString *)username password:(NSString *)password {
    self = [super init];
    if (self) {
        _username = username;
        _password = password;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"api/user/login";
}

- (NSString *)baseUrl {
    return @"http://localhost:9001";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSInteger)cacheTimeInSeconds {
    return 1000*1000;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return @{@"username":_username,@"password":_password};
}
@end
