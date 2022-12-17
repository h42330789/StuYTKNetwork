//
//  ViewController.m
//  StuYTKNetwork
//
//  Created by abc on 12/15/22.
//

#import "ViewController.h"
#import "LoginApi.h"

@interface ViewController ()

@end
@interface ViewController (registerApi) <YTKRequestDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (IBAction)loginButtonPressed:(UIButton *)sender {
    
    NSString *username = @"1";
    NSString *password = @"2";
    
    if (username.length > 0 && password.length > 0) {
        LoginApi *api = [[LoginApi alloc] initWithUsername:username password:password];
        api.stragegy = sender.tag;
        [api startWithCompletionBlockWithSuccess:^(MyRequest *request) {
            // 你可以直接在这里使用 self
            BOOL isCacheData = request.isDataFromCache;
            NSDictionary *data = request.decryptJsonObject;
            NSLog(@"RegisterApi isCacheData: %@ dataCount:%@",isCacheData ? @"true" : @"false",data.allKeys);
        } failure:^(YTKBaseRequest *request) {
            // 你可以直接在这里使用 self
            NSLog(@"failed: %@",request.error);
        }];
    }
}

- (IBAction)loginButtonPressed2:(id)sender {
    
    NSString *username = @"1";
    NSString *password = @"2";
    
    if (username.length > 0 && password.length > 0) {
        LoginApi *api = [[LoginApi alloc] initWithUsername:username password:password];
        [api startWithCompletionBlockWithSuccess:^(YTKRequest *request) {
            // 你可以直接在这里使用 self
            NSLog(@"succeed");
            BOOL isCacheData = request.isDataFromCache;
            NSLog(@"LoginApi isCacheData: %d",isCacheData);
        } failure:^(YTKBaseRequest *request) {
            // 你可以直接在这里使用 self
            NSLog(@"failed: %@",request.error);
        }];
    }
}

- (void)onlyCache {
    // 总是有缓存就用缓存，没有缓存时也不请求，这种在实际中不存在，因为第一次总没有缓存，然后一直不请求，则一直没有缓存
    // RegisterApi请求类 ignoreCache=NO && cacheTimeInSeconds>0
    NSString *username = @"1";
    NSString *password = @"2";
    
    if (username.length > 0 && password.length > 0) {
        LoginApi *api = [[LoginApi alloc] initWithUsername:username password:password];
        if([api loadCacheWithError:nil]){
            NSDictionary *json = [api responseJSONObject];
            NSLog(@"cache: %@",json);
        }
    }
}

- (void)onlyRequest {
    // 总是有缓存就用缓存不请求，没有缓存时在请求
    // RegisterApi请求类 ignoreCache=YES || cacheTimeInSeconds<=0
    NSString *username = @"1";
    NSString *password = @"2";
    
    if (username.length > 0 && password.length > 0) {
        LoginApi *api = [[LoginApi alloc] initWithUsername:username password:password];
        [api startWithCompletionBlockWithSuccess:^(YTKRequest *request) {
            // 你可以直接在这里使用 self
            NSLog(@"succeed");
            NSDictionary *json = [request responseJSONObject];
            NSLog(@"response: %@",json);
        } failure:^(YTKBaseRequest *request) {
            // 你可以直接在这里使用 self
            NSLog(@"failed");
        }];
    }
}

- (void)useCacheOrRequest {
    // 总是有缓存就用缓存不请求，没有缓存时在请求
    // RegisterApi请求类 ignoreCache=NO && cacheTimeInSeconds>0
    NSString *username = @"1";
    NSString *password = @"2";
    
    if (username.length > 0 && password.length > 0) {
        LoginApi *api = [[LoginApi alloc] initWithUsername:username password:password];
        [api startWithCompletionBlockWithSuccess:^(YTKRequest *request) {
            // 你可以直接在这里使用 self
            NSLog(@"succeed");
            NSDictionary *json = [request responseJSONObject];
            NSLog(@"response: %@",json);
        } failure:^(YTKBaseRequest *request) {
            // 你可以直接在这里使用 self
            NSLog(@"failed");
        }];
    }
}

- (void)useCacheAndAwalysRequest {
    // 总是先使用缓存，同时还会发起请求
    // RegisterApi请求类 ignoreCache=YES && cacheTimeInSeconds>0
    NSString *username = @"1";
    NSString *password = @"2";
    
    if (username.length > 0 && password.length > 0) {
        LoginApi *api = [[LoginApi alloc] initWithUsername:username password:password];
        if([api loadCacheWithError:nil]){
            NSDictionary *json = [api responseJSONObject];
            NSLog(@"cache: %@",json);
        }
        
        [api startWithCompletionBlockWithSuccess:^(YTKRequest *request) {
            // 你可以直接在这里使用 self
            NSLog(@"succeed");
            NSDictionary *json = [request responseJSONObject];
            NSLog(@"response: %@",json);
        } failure:^(YTKBaseRequest *request) {
            // 你可以直接在这里使用 self
            NSLog(@"failed");
        }];
    }
}


@end
