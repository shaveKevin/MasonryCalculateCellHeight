//
//  CustomListCell.h
//  Masonry
//
//  Created by shavekevin on 16/1/26.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKBaseTableViewCell.h"

@interface CustomListCell : SKBaseTableViewCell
/**
 *  点击reloadTableview
 */
@property (nonatomic, copy) void (^reloadTableviewBlock)();


/**
 *  绑定数据源
 *
 *  @param dataSource 数据源
 */
- (void)customListBlindCell:(id)dataSource;
/**
 *  执行父类的方法获取cell高度
 *
 *  @param model 数据源
 *
 *  @return cell高度
 */
- (CGFloat)calculateHeightWithModel:(id)model;


@end
