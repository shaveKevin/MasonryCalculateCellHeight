//
//  SKNetworkStatic_request.m
//  Masonry111
//
//  Created by shavekevin on 16/3/8.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKNetworkStatic_request.h"

static NSString *const staticAPI = @"http://m.aipai.com/mobile/xifen/collect_menuid-3_appver-a2.3.0_page-1.html";

@implementation SKNetworkStatic_request
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */

- (NSString *)requestUrl {
    
    return staticAPI;
}
/**
 * 参数字典
 *
 *  @return 返回参数字典
 */
- (id)requestArgument {
    
    NSDictionary *dictParame = nil;
    return dictParame;
}
/**
 *  请求方式 默认Get
 *
 *  @return <#return value description#>
 */
- (SKNetworkRequestMethod)requestMethod {
    
    return SKNetworkRequestMethodGet;
}
/**
 *  如果是post 请求需要重载下面的方法 默认的是 http
 *
 *  @return <#return value description#>
 */
/*
- (SKNetworkRequestSerializerType)requestSerializerType {
    
    return SKNetworkRequestSerializerTypeJson;
}
 */
/**
 *  需要重载这里对model赋值。可以使用模型化  yymodel  jsonmodel   mantle   等等
 */
- (void)dealWithData {
    NSString *responseString = [self responseString];
    NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if (result!= nil) {
        NSArray *contentArray = (NSArray *)result[@"data"];
        [self.dataArray addObjectsFromArray:contentArray];
    }

}
@end
