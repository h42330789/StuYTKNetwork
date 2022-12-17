//
//  MyRequest.m
//  StuYTKNetwork
//
//  Created by abc on 12/15/22.
//

#import "MyRequest.h"
#import <YTKNetwork/YTKNetworkPrivate.h>

@implementation MyRequest
{
    BOOL _isDataFromCache;
}

- (void)startWithCompletionBlockWithSuccess:(YTKRequestCompletionBlock)success
                                    failure:(YTKRequestCompletionBlock)failure {
    [self setCompletionBlockWithSuccess:success failure:failure];
    if(self.stragegy == MyRequestStrateryOnlyRequest){
        self.ignoreCache = YES;
        
    }else if(self.stragegy == MyRequestStrateryCacheOrRequest){
        if([self loadCacheWithError:nil]){
            _isDataFromCache = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                MyRequest *strongSelf = self;
                [strongSelf.delegate requestFinished:strongSelf];
                if (strongSelf.successCompletionBlock) {
                    strongSelf.successCompletionBlock(strongSelf);
                }
                [strongSelf clearCompletionBlock];
            });
            return;
        }
        // cacheTimeInSeconds必须大于0
    }else if(self.stragegy == MyRequestStrateryCacheAndRequest){
        self.ignoreCache = YES;
        // cacheTimeInSeconds必须大于0
        if([self loadCacheWithError:nil]){
            _isDataFromCache = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                MyRequest *strongSelf = self;
                [strongSelf.delegate requestFinished:strongSelf];
                if (strongSelf.successCompletionBlock) {
                    strongSelf.successCompletionBlock(strongSelf);
                }
            });
           
        }
        [self startWithCache];
        return;
    }
    [self start];
}
#pragma mark - seperate cache
- (void)requestCompletePreprocessor {
    _isDataFromCache = NO;
    [super requestCompletePreprocessor];
}
    
- (BOOL)isDataFromCache {
    return _isDataFromCache;
}
- (void)startWithCache {
    [self toggleAccessoriesWillStartCallBack];
    [[YTKNetworkAgent sharedAgent] addRequest:self];
}

#pragma mark - seperate encrypt & decrypt
- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    // 处理需要统一添加的header
    return @{};
}
- (id)requestArgument {
    // 可以在这里处理公共参数或加密
    return self.originArguments;
}
- (id)decryptJsonObject {
    // 这里处理统一的解密等操作
    return self.responseJSONObject;
}

#pragma mark - seperate User
- (NSString *)cacheFileName {
    // 适配对于url、参数都相同，但是用header里的token不同来进行区分不同用户的数据
    NSString *requestUrl = [self requestUrl];
    NSString *baseUrl = [YTKNetworkConfig sharedConfig].baseUrl;
    id argument = [self cacheFileNameFilterForRequestArgument:[self originArguments]];
    // 用于区分url一致，参数也一致，但是属于不同用户的数据，尤其在应用切换用户的场景下容易遇见
    NSString *extraSaveTag = self.extraSaveTag;
    if(extraSaveTag == nil){
        extraSaveTag = @"";
    }
    NSString *requestInfo = [NSString stringWithFormat:@"Method:%ld Host:%@ Url:%@ Argument:%@ user:%@",
                             (long)[self requestMethod], baseUrl, requestUrl, argument, self.extraSaveTag];
    NSString *cacheFileName = [YTKNetworkUtils md5StringFromString:requestInfo];
    return cacheFileName;
}
@end
