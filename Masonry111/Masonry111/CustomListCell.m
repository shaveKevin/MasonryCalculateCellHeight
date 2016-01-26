//
//  CustomListCell.m
//  Masonry111
//
//  Created by shavekevin on 16/1/26.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "CustomListCell.h"
#import "Masonry.h"
@implementation CustomListCell


- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.numberOfLines = 0;
        //这个得写上 不写高度 出不来啊
        _contentLabel.preferredMaxLayoutWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - 10;
        if ([_contentLabel isDescendantOfView:self.contentView] == NO) {
            [self.contentView addSubview:_contentLabel];
        }

        
    }
    return _contentLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.numberOfLines = 1;
        if ([_nameLabel isDescendantOfView:self.contentView] == NO) {
            [self.contentView addSubview:_nameLabel];
        }
    }
    return _nameLabel;
}

- (void)customListBlindCell:(id)dataSource {
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(30);
        make.height.mas_equalTo(35);
    }];
    [self.contentLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.right.mas_greaterThanOrEqualTo(-15);
        make.bottom.mas_equalTo(-20);
    }];
    self.nameLabel.backgroundColor = [UIColor orangeColor];
    self.contentLabel.backgroundColor = [UIColor redColor];
    self.nameLabel.text = @"XXXXXX";
    self.contentLabel.text = dataSource;
}
@end
