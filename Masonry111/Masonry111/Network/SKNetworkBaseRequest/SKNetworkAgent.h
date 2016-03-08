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
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
+(SKNetworkAgent *)sharedInstance;
/**
 *  <#Description#>
 *
 *  @param request <#request description#>
 *  @param async   <#async description#>
 */
- (void)addRequest:(SKNetworkBaseRequest *)request async:(BOOL)async;
/**
 *  <#Description#>
 *
 *  @param request <#request description#>
 */
- (void)cancleRequest:(SKNetworkBaseRequest *)request;
/**
 *  <#Description#>
 */
- (void)cancleAllRequest;
/**
 *  <#Description#>
 *
 *  @param request <#request description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)buildRequestUrl:(SKNetworkBaseRequest *)request;

@end
