//
//  SKBaseTableViewCell.m
//  Masonry
//
//  Created by shavekevin on 16/4/19.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKBaseTableViewCell.h"

@implementation SKBaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //这个加上是为了解决约束冲突
        self.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
        self.contentView.frame = self.frame;
    }
    return self;
}

- (CGFloat)calculateHeight{
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    return [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
