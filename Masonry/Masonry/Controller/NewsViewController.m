//
//  NewsViewController.m
//  Masonry
//
//  Created by shavekevin on 16/3/4.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "NewsViewController.h"
#import "SKNetworkStatic_request.h"

@interface NewsViewController ()
@property (nonatomic, strong) SKNetworkStatic_request *request;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self getData];
    
}

- (void)getData{
    
    if (_request) {
        
        [_request stop];
        _request  = nil;
        
    }
    _request = [[SKNetworkStatic_request alloc]init];
    
    [_request asyncStartWithCompletionBlockWithSuccess:^(SKNetworkBaseRequest *request) {
        
        SKNetworkStatic_request *requsetStatic = (SKNetworkStatic_request *)request;
        NSLog(@"%lu",(unsigned long)requsetStatic.dataArray.count);
        
    } failure:^(SKNetworkBaseRequest *request) {
        //
    } cache:^(SKNetworkBaseRequest *request) {
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
