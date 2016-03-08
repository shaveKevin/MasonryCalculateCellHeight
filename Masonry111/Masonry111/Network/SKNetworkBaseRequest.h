//
//  SKNetworkBaseRequest.h
//  shavekevinRequest
//
//  Created by shavekevin on 16/3/8.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
/**
 *  MethodNetworkRequest
 */

typedef NS_ENUM(NSInteger, SKNetworkRequestMethod) {
    /**
     *  Description
     */
    SKNetworkRequestMethodGet = 0,
    /**
     *  Description
     */
    SKNetworkRequestMethodPut = 1,
    /**
     *  Description
     */
    SKNetworkRequestMethodPost = 2,
};

/**
 *  Description
 */
typedef NS_ENUM(NSInteger,  SKNetworkRequestSerializerType) {
    /**
     *  <#Description#>
     */
    SKNetworkRequestSerializerTypeHttp = 0,
    /**
     *  <#Description#>
     */
    SKNetworkRequestSerializerTypeJson = 1,
};

typedef void(^AFConstructingBlock)(id<AFMultipartFormData>formData);

@class SKNetworkBaseRequest;
@protocol SKNetworkBaseRequestDelegate <NSObject>

@optional
/**
 *  <#Description#>
 *
 *  @param request <#request description#>
 */
- (void)cacheFinished:(SKNetworkBaseRequest *)request;
/**
 *  <#Description#>
 *
 *  @param request <#request description#>
 */
- (void)requestFinished:(SKNetworkBaseRequest *)request;
/**
 *  <#Description#>
 *
 *  @param request <#request description#>
 */
- (void)requestFailed:(SKNetworkBaseRequest *)request;
/**
 *  <#Description#>
 */
- (void)clearRequet;


@end


@interface SKNetworkBaseRequest : NSObject

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) NSString *requestUrl;
@property (nonatomic, copy) NSString *cdnUrl;
@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, assign) NSTimeInterval requestTimeoutInterval;
@property (nonatomic, strong) id requestArgument;
@property (nonatomic, assign) SKNetworkRequestMethod requestMethod;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, assign) SKNetworkRequestSerializerType  requestSerializerType;
@property (nonatomic, strong) NSArray *requestAuthorizationHeaderFieldArray;
@property (nonatomic, strong) NSDictionary *requestHeaderFieldValueDictionary;
@property (nonatomic, assign) BOOL useCDN;
/**
 *  userinfo
 */
@property (nonatomic, strong) NSDictionary *userInfo;
@property (nonatomic, strong) AFHTTPRequestOperation *requestOperation;
/**
 *   request  delegate
 */
@property (nonatomic, weak) id<SKNetworkBaseRequestDelegate> delegate;
@property (nonatomic, strong ,readonly) NSDictionary *responseHeaders;
@property (nonatomic, copy, readonly) NSString *responseString;
@property (nonatomic, strong, readonly) id responseJSONObject;
@property (nonatomic, assign) NSInteger responseStatusCode;
@property (nonatomic, copy) void (^successComplitionBlock)(SKNetworkBaseRequest *);
@property (nonatomic, copy) void (^failureComplitionBlock)(SKNetworkBaseRequest *);
@property (nonatomic, copy) void (^cacheComplitionBlock)(SKNetworkBaseRequest *);
/**
 *  Description
 */
- (void)asyncStart;
/**
 *  <#Description#>
 */
- (void)syncStart;
/**
 *  remove self from request queue
 */
- (void)stop;

/**
 *  <#Description#>
 *
 *  @return execute
 */

- (BOOL)isExecuting;
/**
 *  block回调
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 *  @param cache   <#cache description#>
 */
-(void)asyncStartWithCompletionBlockWithSuccess:(void(^)(SKNetworkBaseRequest *request))success failure:(void (^)(SKNetworkBaseRequest *request))failure cache:(void(^)(SKNetworkBaseRequest *request))cache;

/**
 *  <#Description#>
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 *  @param cache   <#cache description#>
 */
-(void)syncStartWithCompletionBlockWithSuccess:(void(^)(SKNetworkBaseRequest *request))success failure:(void (^)(SKNetworkBaseRequest *request))failure cache:(void(^)(SKNetworkBaseRequest *request))cache;


- (void)setCompletionBlockWithSuccess:(void(^)(SKNetworkBaseRequest *request))success failure:(void (^)(SKNetworkBaseRequest *request))failure cache:(void(^)(SKNetworkBaseRequest *request))cache;
/**
 *  打破block循环引用
 */

- (void)clearCompletionBlock;
/**
 *  <#Description#>
 */
- (void)cacheCompleteFilter;
/**
 *  <#Description#>
 */
- (void)requestSuccessCompleteFilter;
/**
 *  <#Description#>
 */
- (void)requestFailureFilter;
/**
 *  <#Description#>
 *
 *  @param requestUrl <#requestUrl description#>
 */
- (void)setRequestUrl:(NSString *)requestUrl;
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)requestUrl;
/**
 *  <#Description#>
 *
 *  @param cdnUrl <#cdnUrl description#>
 */
- (void)setCdnUrl:(NSString *)cdnUrl;
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)cdnUrl;

/**
 *  <#Description#>
 *
 *  @param baseUrl <#baseUrl description#>
 */
- (void)setBaseUrl:(NSString *)baseUrl;
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)baseUrl;
/**
 *  <#Description#>
 *
 *  @param requestTimeoutInterval <#requestTimeoutInterval description#>
 */
- (void)setRequestTimeoutInterval:(NSTimeInterval)requestTimeoutInterval;
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (NSTimeInterval)requestTimeoutInterval;
/**
 *  <#Description#>
 *
 *  @param requestArgument <#requestArgument description#>
 */
- (void)setRequestArgument:(id)requestArgument;
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (id)requestArgument;
/**
 *  <#Description#>
 *
 *  @param requestMethod <#requestMethod description#>
 */
- (void)setRequestMethod:(SKNetworkRequestMethod)requestMethod;
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (SKNetworkRequestMethod)requestMethod;
/**
 *  <#Description#>
 *
 *  @param requestSerializerType <#requestSerializerType description#>
 */
- (void)setRequestSerializerType:(SKNetworkRequestSerializerType)requestSerializerType;
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (SKNetworkRequestSerializerType)requestSerializerType;
/**
 *  <#Description#>
 *
 *  @param requestAuthorizationHeaderFieldArray <#requestAuthorizationHeaderFieldArray description#>
 */
- (void)setRequestAuthorizationHeaderFieldArray:(NSArray *)requestAuthorizationHeaderFieldArray;
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */

- (NSArray *)requestAuthorizationHeaderFieldArray;
/**
 *  <#Description#>
 *
 *  @param requestHeaderFieldValueDictionary <#requestHeaderFieldValueDictionary description#>
 */
- (void)setRequestHeaderFieldValueDictionary:(NSDictionary *)requestHeaderFieldValueDictionary;
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (NSDictionary *)requestHeaderFieldValueDictionary;
/**
 *  <#Description#>
 *
 *  @param useCDN 是否使用CDN的host地址
 */
- (void)setUseCDN:(BOOL)useCDN;
/**
 *  GetterMETHOD
 *
 *  @return 是否使用CDN的host地址
 */
- (BOOL)useCDN;
/**
 *  用于检查Status Code是否正常的方法
 *
 *  @return <#return value description#>
 */
- (BOOL)statusCodeValidator;
/**
 *  <#Description#>
 *
 *  @return 当POST的内容带有文件等富文本时使用
 */
- (AFConstructingBlock)constructingBodyBlock;


@end
