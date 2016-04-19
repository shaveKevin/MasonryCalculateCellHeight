//
//  SKNetworkRequest.h
//  Masonry
//
//  Created by shavekevin on 16/3/8.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKNetworkBaseRequest.h"

@interface SKNetworkRequest : SKNetworkBaseRequest

/**
 *  参数字典
 */
@property (nonatomic,strong) NSDictionary *dicParame;

/**
 *  请求成功处理数据
 */
- (void)dealWithData;

@end
