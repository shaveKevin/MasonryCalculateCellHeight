//
//  SKBaseTableViewCell.h
//  Masonry111
//
//  Created by shavekevin on 16/4/19.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKBaseTableViewCell : UITableViewCell
/**
 *  对model 赋值后调用这个方法可以获取到高度 注意 一定要赋值之后 才要调用
 *
 *  @return cell的高度
 */
- (CGFloat)calculateHeight;

@end
