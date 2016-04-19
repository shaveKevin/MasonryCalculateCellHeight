//
//  SKNetworkRequest.m
//  Masonry
//
//  Created by shavekevin on 16/3/8.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKNetworkRequest.h"

@implementation SKNetworkRequest

//请求成功
-(void)requestSuccessCompleteFilter {
    
    [self dealWithData];
}


- (NSTimeInterval)requestTimeoutInterval{
    return 6.0f;
}
/**
 * 参数字典
 *
 *  @return 返回参数字典
 */
- (id)requestArgument {
    
    return _dicParame;
}

// 重载

- (void)dealWithData {
    
}
@end
