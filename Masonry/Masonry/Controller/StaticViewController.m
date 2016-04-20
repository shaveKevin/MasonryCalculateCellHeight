//
//  ViewController.m
//  Masonry
//
//  Created by shavekevin on 16/1/26.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "StaticViewController.h"
#import "Masonry.h"
#import "CustomListCell.h"
#import "YYFPSLabel.h"
#import "NewsViewController.h"

static  NSString *const cellIdentifier = @"cell";
#define PhoneBounds [UIScreen mainScreen].bounds

@interface StaticViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CustomListCell *tempCell;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation StaticViewController
- (IBAction)gotoNetworkVC:(id)sender {
    NewsViewController *newsVC = [[NewsViewController alloc]init];
    [self.navigationController pushViewController:newsVC animated:YES];
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
   // self.tableView.rowHeight = UITableViewAutomaticDimension;
   // self.tableView.estimatedRowHeight = 200;
    [self.tableView registerClass:[CustomListCell class] forCellReuseIdentifier:cellIdentifier];
    self.dataArray = [NSMutableArray array];
    [self setupDatasource];
    YYFPSLabel *label = [YYFPSLabel new];
    label.frame = CGRectMake((CGRectGetWidth(PhoneBounds)- 100)/2.0f, 0, 100, 30);
    [self.navigationController.navigationBar  addSubview:label];
    [self addHeaderView];
}

//TableviewHeaderview不可以被加约束可是它的子视图可以加约束 这里给获取一个高度就好 添加footview   添加区头区尾 也是同样的方法
- (void)addHeaderView {
    
    //headerview
    UIView *viewContview = [UIView new];
    viewContview.backgroundColor = [UIColor clearColor];
    UIImageView *headImageview = [UIImageView new];
    [viewContview addSubview:headImageview];
    headImageview.backgroundColor = [UIColor orangeColor];
    headImageview.image = [UIImage imageNamed:@"backgroundImage.jpg"];
    [headImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    CGFloat height = [viewContview systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = viewContview.frame;
    frame.size.height = height;
    viewContview.frame = frame;
    self.tableView.tableHeaderView = viewContview;
    
}

#pragma mark  - tableview delegate and datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell customListBlindCell: _dataArray[indexPath.row]];
    cell.reloadTableviewBlock = ^(){
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"reloadData  reloadData");
    };
    //这里的操作是对cell上的子view 根据数据源 添加 更新约束
    [cell  layOutViews];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

/**
 *   iOS8以后如果使用的是masonry 的话  返回高度的方法可以不用写 需要调用
 *   self.tableView.rowHeight = UITableViewAutomaticDimension;
 *   self.tableView.estimatedRowHeight = 200;
 *
 *  @return
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    //从重用池取出去的cell 然后对cell进行赋值 通过赋值 来调用是否更新约束的方法
    // 获得高度有两种方法： 如果子类对父类方法做了修改那么就 用方法2 如果没修改就用方法1
    /**
     *  1.  [self.tempCell customListBlindCell:_dataArray[indexPath.row]];
     
     *     [self.tempCell calculateHeight];

     *  2. [self.tempCell calculateHeightWithModel:_dataArray[indexPath.row]]
     */
    return [self.tempCell calculateHeightWithModel:_dataArray[indexPath.row]];

}
//懒加载一个cell 用于计算高度(从重用池中取出)  这里建议用dispatch once 来写。
- (CustomListCell *)tempCell {
    
    if (!_tempCell) {
        
        _tempCell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    return _tempCell;
}


#pragma mark  - 设置数据源
- (void)setupDatasource {
    
    NSError *error;
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"Datasource"ofType:@"json"];
    NSData*jdata = [[NSData alloc]initWithContentsOfFile:filePath];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jdata options:kNilOptions error:&error];
    if (jsonObject && [jsonObject isKindOfClass:[NSDictionary class]]) {
        NSArray *data  = [jsonObject valueForKey:@"data"];
        for (NSInteger i = 0; i < data.count; i ++) {
            NSString *dataContent = [data[i]valueForKey:@"content"];
            [self.dataArray addObject:dataContent];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
