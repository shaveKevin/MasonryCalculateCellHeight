//
//  SKNetworkConfig.m
//  shavekevinRequest
//
//  Created by shavekevin on 16/3/8.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKNetworkConfig.h"

@implementation SKNetworkConfig
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
+ (SKNetworkConfig *)shareInstance {
    
    static SKNetworkConfig *shareManager = nil;
    static   dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        
        shareManager = [[SKNetworkConfig alloc]init];
    });
    return shareManager;
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)baseUrl {
    
    return nil;
}

@end
