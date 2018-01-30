//
//  SKOrderTableViewCell.m
//  SKSpaceService
//
//  Created by wangxiaodong on 2018/1/29.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKOrderTableViewCell.h"

@implementation SKOrderTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.backGroundView];
        [self.backGroundView addSubview:self.serviceAddressLabel];
        [self.backGroundView addSubview:self.serviceAddressInfoLabel];
        [self.backGroundView addSubview:self.serviceArticleLabel];
        [self.backGroundView addSubview:self.serviceArticleInfoLabel];
        [self.backGroundView addSubview:self.serviceCauseLabel];
        [self.backGroundView addSubview:self.serviceCauseInfoLabel];
        [self.backGroundView addSubview:self.serviceTimeLabel];
        [self.backGroundView addSubview:self.serviceTimeInfoLabel];
        [self layoutSubviews];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [self.backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(5);
        make.bottom.equalTo(self).with.offset(-5);
        make.left.equalTo(self).with.offset(10);
        make.right.equalTo(self).with.offset(-10);
    }];
    
    [self.serviceAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backGroundView).with.offset(20);
        make.left.equalTo(self.backGroundView).with.offset(20);
        make.width.mas_offset(90);
    }];
    
    [self.serviceAddressInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serviceAddressLabel);
        make.left.equalTo(self.serviceAddressLabel.mas_right);
    }];
    
    [self.serviceArticleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serviceAddressLabel.mas_bottom).with.offset(15);
        make.left.equalTo(self.backGroundView).with.offset(20);
        make.width.mas_offset(90);
    }];
    
    [self.serviceArticleInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serviceArticleLabel);
        make.left.equalTo(self.serviceArticleLabel.mas_right);
    }];
    
    [self.serviceCauseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serviceArticleLabel.mas_bottom).with.offset(15);
        make.left.equalTo(self.backGroundView).with.offset(20);
        make.width.mas_offset(90);
    }];
    
    [self.serviceCauseInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serviceCauseLabel);
        make.left.equalTo(self.serviceCauseLabel.mas_right);
    }];
    
    [self.serviceTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serviceCauseLabel.mas_bottom).with.offset(15);
        make.left.equalTo(self.backGroundView).with.offset(20);
        make.width.mas_offset(90);
    }];
    
    [self.serviceTimeInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serviceTimeLabel);
        make.left.equalTo(self.serviceTimeLabel.mas_right);
    }];
    
}

-(UIView *)backGroundView
{
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] init];
        _backGroundView.backgroundColor = [UIColor whiteColor];
        _backGroundView.layer.shadowOpacity = 0.5;// 阴影透明度
        _backGroundView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        _backGroundView.layer.shadowRadius = 3;// 阴影扩散的范围控制
        _backGroundView.layer.shadowOffset = CGSizeMake(1, 1);// 阴影的范围
        [self.contentView addSubview:_backGroundView];
    }
    return _backGroundView;
}

-(UILabel *)serviceAddressLabel
{
    if (_serviceAddressLabel == nil) {
        _serviceAddressLabel = [[UILabel alloc] init];
        _serviceAddressLabel.text = @"维修地点：";
    }
    return _serviceAddressLabel;
}

-(UILabel *)serviceAddressInfoLabel
{
    if (_serviceAddressInfoLabel == nil) {
        _serviceAddressInfoLabel = [[UILabel alloc] init];
    }
    return _serviceAddressInfoLabel;
}

-(UILabel *)serviceArticleLabel
{
    if (_serviceArticleLabel == nil) {
        _serviceArticleLabel = [[UILabel alloc] init];
        _serviceArticleLabel.text = @"维修类型：";
    }
    return _serviceArticleLabel;
}

-(UILabel *)serviceArticleInfoLabel
{
    if (_serviceArticleInfoLabel == nil) {
        _serviceArticleInfoLabel = [[UILabel alloc] init];
    }
    return _serviceArticleInfoLabel;
}

-(UILabel *)serviceCauseLabel
{
    if (_serviceCauseLabel == nil) {
        _serviceCauseLabel = [[UILabel alloc] init];
        _serviceCauseLabel.text = @"维修原因：";
    }
    return _serviceCauseLabel;
}

-(UILabel *)serviceCauseInfoLabel
{
    if (_serviceCauseInfoLabel == nil) {
        _serviceCauseInfoLabel = [[UILabel alloc] init];
    }
    return _serviceCauseInfoLabel;
}

-(UILabel *)serviceTimeLabel
{
    if (_serviceTimeLabel == nil) {
        _serviceTimeLabel = [[UILabel alloc] init];
        _serviceTimeLabel.text = @"创建时间：";
    }
    return _serviceTimeLabel;
}

-(UILabel *)serviceTimeInfoLabel
{
    if (_serviceTimeInfoLabel == nil) {
        _serviceTimeInfoLabel  = [[UILabel alloc] init];
    }
    return _serviceTimeInfoLabel;
}

@end
