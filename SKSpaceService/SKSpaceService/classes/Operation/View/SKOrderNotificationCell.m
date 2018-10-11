//
//  SKOrderNotificationCell.m
//  SKSpaceService
//
//  Created by wangxiaodong on 10/10/2018.
//  Copyright © 2018 张雨. All rights reserved.
//

#import "SKOrderNotificationCell.h"

@implementation SKOrderNotificationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.backGroundView];
        [self.backGroundView addSubview:self.clientNameLabel];
        [self.backGroundView addSubview:self.clientNameInfoLabel];
        [self.backGroundView addSubview:self.presetTimeLabel];
        [self.backGroundView addSubview:self.presetTimeInfoLabel];
        [self.backGroundView addSubview:self.spaceLabel];
        [self.backGroundView addSubview:self.spaceInfoLabel];
        [self.backGroundView addSubview:self.promptInfoLabel];
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
    
    [self.clientNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backGroundView).with.offset(20);
        make.left.equalTo(self.backGroundView).with.offset(20);
        make.width.mas_offset(90);
    }];
    
    [self.clientNameInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.clientNameLabel);
        make.left.equalTo(self.clientNameLabel.mas_right);
        make.right.equalTo(self.backGroundView).with.offset(-10);
    }];
    
    [self.presetTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.clientNameLabel.mas_bottom).with.offset(15);
        make.left.equalTo(self.backGroundView).with.offset(20);
        make.width.mas_offset(90);
    }];
    
    [self.presetTimeInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.presetTimeLabel);
        make.left.equalTo(self.presetTimeLabel.mas_right);
    }];
    
    [self.spaceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.presetTimeLabel.mas_bottom).with.offset(15);
        make.left.equalTo(self.backGroundView).with.offset(20);
        make.width.mas_offset(90);
    }];
    
    [self.spaceInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.spaceLabel);
        make.left.equalTo(self.spaceLabel.mas_right);
        make.right.equalTo(self.backGroundView).with.offset(-10);
    }];
    
    [self.promptInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.spaceLabel.mas_bottom).with.offset(15);
        make.centerX.equalTo(self.backGroundView);
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

-(UILabel *)clientNameLabel
{
    if (_clientNameLabel == nil) {
        _clientNameLabel = [[UILabel alloc] init];
        _clientNameLabel.text = @"客户姓名：";
    }
    return _clientNameLabel;
}

-(UILabel *)clientNameInfoLabel
{
    if (_clientNameInfoLabel == nil) {
        _clientNameInfoLabel = [[UILabel alloc] init];
    }
    return _clientNameInfoLabel;
}

-(UILabel *)presetTimeLabel
{
    if (_presetTimeLabel == nil) {
        _presetTimeLabel = [[UILabel alloc] init];
        _presetTimeLabel.text = @"预定时间：";
    }
    return _presetTimeLabel;
}

-(UILabel *)presetTimeInfoLabel
{
    if (_presetTimeInfoLabel == nil) {
        _presetTimeInfoLabel = [[UILabel alloc] init];
    }
    return _presetTimeInfoLabel;
}

-(UILabel *)spaceLabel
{
    if (_spaceLabel == nil) {
        _spaceLabel = [[UILabel alloc] init];
        _spaceLabel.text = @"预定社区：";
    }
    return _spaceLabel;
}

-(UILabel *)spaceInfoLabel
{
    if (_spaceInfoLabel == nil) {
        _spaceInfoLabel = [[UILabel alloc] init];
    }
    return _spaceInfoLabel;
}

-(UILabel *)promptInfoLabel
{
    if (_promptInfoLabel == nil) {
        _promptInfoLabel = [[UILabel alloc] init];
        _promptInfoLabel.text = @"请相关人员提前做好准备工作！";
    }
    return _promptInfoLabel;
}


@end
