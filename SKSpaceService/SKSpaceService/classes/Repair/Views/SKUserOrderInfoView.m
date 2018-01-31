//
//  SKUserOrderInfoView.m
//  SKSpaceService
//
//  Created by wangxiaodong on 2018/1/29.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKUserOrderInfoView.h"
#import "DetailImageInfoView.h"

@interface SKUserOrderInfoView()

@property(nonatomic,strong)DetailImageInfoView *imageView;

@end

@implementation SKUserOrderInfoView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.serviceAddressLabel90];
        [self addSubview:self.serviceAddressInfoLabel];
        [self addSubview:self.serviceArticleLabel];
        [self addSubview:self.serviceArticleInfoLabel];
        [self addSubview:self.serviceCauseLabel];
        [self addSubview:self.serviceCauseInfoLabel];
        [self addSubview:self.serviceTimeLabel];
        [self addSubview:self.serviceTimeInfoLabel];
        [self addSubview:self.imageView];
        [self layoutSubviews];
    }
    return self;
}

-(void)layoutSubviews
{
    [self.serviceAddressLabel90 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(20);
        make.left.equalTo(self).with.offset(20);
        make.width.mas_offset(90);
    }];
    
    [self.serviceAddressInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serviceAddressLabel90);
        make.left.equalTo(self.serviceAddressLabel90.mas_right);
    }];
    
    [self.serviceArticleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serviceAddressLabel90.mas_bottom).with.offset(15);
        make.left.equalTo(self).with.offset(20);
        make.width.mas_offset(90);
    }];
    
    [self.serviceArticleInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serviceArticleLabel);
        make.left.equalTo(self.serviceArticleLabel.mas_right);
    }];
    
    [self.serviceCauseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serviceArticleLabel.mas_bottom).with.offset(15);
        make.left.equalTo(self).with.offset(20);
        make.width.mas_offset(90);
    }];
    
    [self.serviceCauseInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serviceCauseLabel);
        make.left.equalTo(self.serviceCauseLabel.mas_right);
    }];
    
    [self.serviceTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serviceCauseLabel.mas_bottom).with.offset(15);
        make.left.equalTo(self).with.offset(20);
        make.width.mas_offset(90);
    }];
    
    [self.serviceTimeInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serviceTimeLabel);
        make.left.equalTo(self.serviceTimeLabel.mas_right);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serviceTimeLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
}

-(void)setImageDataArray:(NSArray *)imageArray
{
    self.imageUrlArray = imageArray;
   // self.imageView.imageUrlStrArray = imageArray;
    [self.imageView setimageArray:self.imageUrlArray];
}

-(UILabel *)serviceAddressLabel90
{
    if (_serviceAddressLabel90 == nil) {
        _serviceAddressLabel90 = [[UILabel alloc] init];
        _serviceAddressLabel90.text = @"维修地点：";
    }
    return _serviceAddressLabel90;
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

-(DetailImageInfoView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[DetailImageInfoView alloc] init];
        _imageView.titleString = @"用户上传图片";
        //_imageView.imageUrlStrArray = self.imageUrlArray;
    }
    return _imageView;
}

@end
