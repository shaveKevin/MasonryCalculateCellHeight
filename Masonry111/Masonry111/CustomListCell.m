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
        if ([_contentLabel isDescendantOfView:self.contentView] == NO) {
            [self.contentView addSubview:_contentLabel];
        }
        [self.contentLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.top.equalTo(self.line.mas_bottom).offset(10);
            make.right.mas_greaterThanOrEqualTo(-15);
            make.bottom.mas_equalTo(-20);
        }];


        
    }
    return _contentLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.numberOfLines = 0;
        if ([_nameLabel isDescendantOfView:self.contentView] == NO) {
            [self.contentView addSubview:_nameLabel];
        }
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.top.mas_equalTo(30);
            make.right.mas_equalTo(-5);
        }];

    }
    return _nameLabel;
}
- (UILabel *)line {
    if (!_line) {
        _line = [UILabel new];
        _line.backgroundColor = [UIColor redColor];
        if ([_line isDescendantOfView:self.contentView] == NO) {
            [self.contentView addSubview:_line];
        }
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _line;
}
- (void)layoutSubviews {
    //这个得写上 不写高度 出不来啊
    _nameLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 10;
    _contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 10;
    [super layoutSubviews];
}
- (void)customListBlindCell:(id)dataSource {
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentView.backgroundColor = [UIColor lightGrayColor];
    self.nameLabel.backgroundColor = [UIColor orangeColor];
    self.contentLabel.backgroundColor = [UIColor redColor];
    self.nameLabel.text = dataSource;
    self.contentLabel.text = dataSource;
}
@end
