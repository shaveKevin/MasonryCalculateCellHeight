//
//  SKNetworkStatic_request.m
//  Masonry111
//
//  Created by shavekevin on 16/3/8.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKNetworkStatic_request.h"

@implementation SKNetworkStatic_request


- (NSString *)requestUrl {
    
    return @"http://m.aipai.com/mobile/xifen/collect_menuid-3_appver-a2.3.0_page-1.html";
}

- (id)requestArgument {
    
    NSDictionary *dictParame = nil;
    return dictParame;
}

- (SKNetworkRequestMethod)requestMethod {
    
    return SKNetworkRequestMethodGet;
}

- (NSTimeInterval)requestTimeoutInterval{
    return 6.0f;
}

/// 请求成功
- (void)requestSuccessCompleteFilter {
    [self dealWithData];
}

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
