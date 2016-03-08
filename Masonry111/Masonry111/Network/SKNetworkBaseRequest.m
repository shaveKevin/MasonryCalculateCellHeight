//
//  SKNetworkBaseRequest.m
//  shavekevinRequest
//
//  Created by shavekevin on 16/3/8.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKNetworkBaseRequest.h"
#import "SKNetworkAgent.h"
static CGFloat const timeOutInterval = 60.0f;
@implementation SKNetworkBaseRequest
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)init {
    
    if (self= [super init]) {
        
        _requestUrl = @"";
        _cdnUrl = @"";
        _baseUrl = @"";
        _requestTimeoutInterval = timeOutInterval;
        _requestMethod = SKNetworkRequestMethodGet;
        _requestSerializerType = SKNetworkRequestSerializerTypeHttp;
        _useCDN = NO;
        
    }
    return self;
}
/// 根据需要进行重载的
- (void)cacheCompleteFilter {
    
}
- (void)requestSuccessCompleteFilter {
    
}
- (void)requestFailureFilter {
    
}

- (NSString *)requestUrl {
    
    return _requestUrl;
}
- (NSString *)cdnUrl {
    
    return _cdnUrl;
}
- (NSString *)baseUrl {
    
    return _baseUrl;
}

- (NSTimeInterval)requestTimeoutInterval {
    
    return _requestTimeoutInterval;
    
}
- (id)requestArgument {
    
    return _requestArgument;
}
- (SKNetworkRequestMethod)requestMethod {
    
    return _requestMethod;
}
- (SKNetworkRequestSerializerType)requestSerializerType {
    
    return _requestSerializerType;
}

- (NSArray *)requestAuthorizationHeaderFieldArray {
    return _requestAuthorizationHeaderFieldArray;
}
- (NSDictionary *)requestHeaderFieldValueDictionary {
    return _requestHeaderFieldValueDictionary;
}
- (BOOL)useCDN {
    
    return _useCDN;
}
- (BOOL)statusCodeValidator {
    NSInteger statusCode = [self responseStatusCode];
    if (statusCode >= 200 && statusCode <= 299) {
        return YES;
    } else  {
        return NO;
    }
}

- (AFConstructingBlock)constructingBodyBlock {
    return nil;
}
/**
 *  异步
 */
- (void)asyncStart {
    
    [[SKNetworkAgent sharedInstance] addRequest:self async:YES];
}
/**
 *  同步
 */
- (void)syncStart {
    
    [[SKNetworkAgent sharedInstance] addRequest:self async:NO];

}
/**
 *  <#Description#>
 */
- (void)stop {
    self.delegate = nil;
    [[SKNetworkAgent sharedInstance] cancleRequest:self];
    
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)isExecuting {
    return self.requestOperation.isExecuting;
}
/**
 *  <#Description#>
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 *  @param cache   <#cache description#>
 */
- (void)asyncStartWithCompletionBlockWithSuccess:(void (^)(SKNetworkBaseRequest *))success failure:(void (^)(SKNetworkBaseRequest *))failure cache:(void (^)(SKNetworkBaseRequest *))cache {
    
    [self setCompletionBlockWithSuccess:success failure:failure cache:cache];
    [self asyncStart];
}
/**
 *  <#Description#>
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 *  @param cache   <#cache description#>
 */
- (void)syncStartWithCompletionBlockWithSuccess:(void (^)(SKNetworkBaseRequest *))success failure:(void (^)(SKNetworkBaseRequest *))failure cache:(void (^)(SKNetworkBaseRequest *))cache {
    [self setCompletionBlockWithSuccess:success failure:failure cache:cache];
    [self syncStart];
}
/**
 *  <#Description#>
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 *  @param cache   <#cache description#>
 */
- (void)setCompletionBlockWithSuccess:(void (^)(SKNetworkBaseRequest *))success failure:(void (^)(SKNetworkBaseRequest *))failure cache:(void (^)(SKNetworkBaseRequest *))cache {
    
    self.successComplitionBlock = success;
    self.failureComplitionBlock = failure;
    self.cacheComplitionBlock = cache;
}
/**
 *  <#Description#>
 */
- (void)clearCompletionBlock {
    
    self.successComplitionBlock = nil;
    self.failureComplitionBlock = nil;
    self.cacheComplitionBlock = nil;
    
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)responseString {
    
    NSString *responseStr = self.requestOperation.responseString;
    return responseStr;
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (id)responseJSONObject {
    
    NSString *responseJSONObject = self.requestOperation.responseObject;
    return responseJSONObject;
    
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)responseStatusCode {
    
    NSInteger responeStatusCode = self.requestOperation.response.statusCode;
    return responeStatusCode;
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (NSDictionary *)responseHeaders {
    
    NSDictionary *responseHeadersDict = self.requestOperation.response.allHeaderFields;
    return responseHeadersDict;
}


@end
