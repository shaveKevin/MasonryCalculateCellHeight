//
//  SKNetworkAgent.h
//  shavekevinRequest
//
//  Created by shavekevin on 16/3/8.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKNetworkBaseRequest;

@interface SKNetworkAgent : NSObject
/**
 *  单例
 *
 *  @return singleton
 */
+ (SKNetworkAgent *)sharedInstance;
/**
 *  添加网络请求  同步或者异步
 *
 *  @param request
 *  @param async   add networkrequest which will be  async  or sync
 */
- (void)addRequest:(SKNetworkBaseRequest *)request async:(BOOL)async;
/**
 *  取消一个请求
 *
 *  @param request cancel  one request
 */
- (void)cancleRequest:(SKNetworkBaseRequest *)request;
/**
 *  取消所有请求
 *
 *  @param request cancel  all requests
 */
- (void)cancleAllRequest;
/**
 *  构建网络请求体
 *
 *  @param request  the  request which should be bulit
 *
 *  @return build   network  method
 */
- (NSString *)buildRequestUrl:(SKNetworkBaseRequest *)request;


@end
