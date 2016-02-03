//
//  CustomListCell.m
//  Masonry111
//
//  Created by shavekevin on 16/1/26.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "CustomListCell.h"
#import "Masonry.h"

static CGFloat const kLeftMargin = 5.0f;
static CGFloat const kLeftPadding = 10.0f;
static CGFloat const kRightMargin = -10.0f;
static CGFloat const kBottomMargin = -10.0f;
static CGFloat const kTopMargin = 5.0f;
static CGFloat const kDefaultPadding = 0.0f;
static CGFloat const kSeperateLineHeight = 0.5f;
static CGFloat const kDefaultWidth = 20.0f;
static CGFloat const kDefaultSeperate = 10.0f;
static NSInteger const kDefaultFactor = 6;
static CGFloat const kTempImageviewHeight = 100.0f;

#define PhoneBounds [UIScreen mainScreen].bounds

@interface CustomListCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *line;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, assign) BOOL isFirstVisit;
@property (nonatomic, assign) id  dataSourceElement;
@end

@implementation CustomListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //这个加上是为了解决约束冲突
        self.frame = CGRectMake(0, 0, CGRectGetWidth(PhoneBounds), CGRectGetHeight(PhoneBounds));
        self.contentView.frame = self.frame;
        _isFirstVisit = NO;
    }
    return self;
}
- (UILabel *)contentLabel {
    
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.numberOfLines = 0;
        if ([_contentLabel isDescendantOfView:self.contentView] == NO) {
            [self.contentView addSubview:_contentLabel];
        }
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
    }
    return _line;
}
- (UIImageView *)iconImageView {
    if (!_iconImageView ) {
        _iconImageView = [[UIImageView alloc]init];
        if ([_iconImageView isDescendantOfView:self.contentView] == NO) {
            [self.contentView addSubview:self.iconImageView];
        }
        
    }
    return _iconImageView;
}
- (void)layoutSubviews {
    
    //这个得写上 不写高度 出不来啊 因为自适应的高度的话宽度是要固定的。所以这里要给上最大的宽度
    _nameLabel.preferredMaxLayoutWidth = CGRectGetWidth(PhoneBounds) - kDefaultSeperate;
    _contentLabel.preferredMaxLayoutWidth = CGRectGetWidth(PhoneBounds) - kDefaultSeperate;
    [super layoutSubviews];
    
}

- (void)customListBlindCell:(id)dataSource {
    
    _dataSourceElement = dataSource;
    self.contentView.backgroundColor = [UIColor lightGrayColor];
    self.nameLabel.backgroundColor = [UIColor orangeColor];
    self.contentLabel.backgroundColor = [UIColor redColor];
    
    if (![dataSource  isEqualToString:@"2"]) {
         self.iconImageView.image =  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"11" ofType:@"png"]];
    }
    else {
        self.iconImageView.image = nil;
    }
    self.nameLabel.text = dataSource;
    self.contentLabel.text = dataSource;
}

- (void)updateConstraints {
    
    //第一次进来的话走的是make  再次进来走的是update 或者 remake
    if (!_isFirstVisit) {
        
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kLeftMargin);
            make.top.mas_equalTo(kTopMargin * kDefaultFactor);
            make.right.mas_equalTo(kBottomMargin);
        }];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(kLeftPadding);
            make.left.mas_equalTo(kLeftPadding);
            make.width.mas_equalTo(kDefaultWidth);
            make.height.mas_equalTo(kSeperateLineHeight);
        }];
        [self.contentLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kLeftMargin);
            make.top.equalTo(self.line.mas_bottom).offset(kLeftPadding);
            make.right.mas_equalTo(kBottomMargin);
        }];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(kLeftPadding);
            make.left.mas_equalTo(kDefaultPadding);
            make.right.mas_equalTo(kBottomMargin);
            //如果图片不固定高度的话会计算会根据图片本身高度来计算  如果想固定图片高度就把下面的高度注释打开就好了
            // make.height.mas_equalTo(kTempImageviewHeight);
             make.bottom.equalTo(self.contentView.mas_bottom).offset(kBottomMargin);
        }];
        _isFirstVisit = YES;
    }
    
    if ([self.dataSourceElement isEqualToString:@"2"]) {
        // 如果 iconimageView的高度是固定的。那么更改约束的话 不仅仅修改的是iconimageview 的约束
        
        [self.iconImageView  mas_updateConstraints:^(MASConstraintMaker *make) {
        
            
            make.top.equalTo(self.contentLabel.mas_bottom).offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);

        }];
        
    }
    [super updateConstraints];
    
}
@end
