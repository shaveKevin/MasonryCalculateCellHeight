//
//  SKNetworkConfig.h
//  shavekevinRequest
//
//  Created by shavekevin on 16/3/8.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKNetworkConfig : NSObject

/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
+ (SKNetworkConfig *)shareInstance;

/**
 *  基础接口
 */
@property (nonatomic, copy) NSString *baseUrl;
/**
 *  <#Description#>
 */
@property (nonatomic, copy) NSString *cdnUrl;

@end
