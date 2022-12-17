//
//  MyRequest.h
//  StuYTKNetwork
//
//  Created by abc on 12/15/22.
//

#import <YTKNetwork/YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MyRequestStratery) {
    MyRequestStrateryOnlyRequest, // 不管有没有缓存都使用接口请求
    MyRequestStrateryCacheOrRequest, // 有缓存时就是用缓存，没有缓存时就使用接口请求
    MyRequestStrateryCacheAndRequest, // 有缓存时先使用缓存回调，同时发起接口请求
};

@interface MyRequest : YTKRequest
@property (nonatomic, assign) MyRequestStratery stragegy;
@property (nonatomic, copy) NSString *extraSaveTag;
// 非添加公共处理前的的参数，与实际发送请求的参数用不同的字段展示，便于需要添加功能参数、要加密的场景，这个原始的参数用于作为缓存的key的一部分
@property (nonatomic, strong) NSDictionary *originArguments;
// 获取这个字段来获取解密后的响应
- (id)decryptJsonObject;
@end

NS_ASSUME_NONNULL_END
