//
//  WebServerManager.m
//  StuYTKNetwork
//
//  Created by abc on 12/17/22.
//

#import "WebServerManager.h"
#import "GCDWebServer.h"
#import "GCDWebServerDataRequest.h"
#import "GCDWebServerDataResponse.h"

@interface WebServerManager()
@property (nonatomic, strong) GCDWebServer *webServer;
@end

@implementation WebServerManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static WebServerManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}


- (void)startHttp {
    self.webServer = [[GCDWebServer alloc] init];
    [self.webServer addHandlerForMethod:@"POST"
                                   path:@"/api/user/login"
                           requestClass:[GCDWebServerDataRequest class]
                      asyncProcessBlock:^(__kindof GCDWebServerDataRequest *request, GCDWebServerCompletionBlock completionBlock) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSDictionary *params = request.jsonObject;
            NSDictionary *json = @{
                @"uid":@1,
                @"token":@"werwer",
                @"name":params[@"username"],
                @"sex":@"female",
                @"age":@10
            };
            
            NSDictionary *bodyJson = @{
                @"refreshTime": @([@([NSDate date].timeIntervalSince1970) intValue]),
                @"isSuccess": @(YES),
                @"errorCode": @10000,
                @"message": @"",
                @"location": @"",
                @"data": json
            };
            GCDWebServerDataResponse* response = [GCDWebServerDataResponse responseWithJSONObject:bodyJson];
            completionBlock(response);
          });
    }];
    [self.webServer startWithPort:9001 bonjourName:nil];
}
@end
