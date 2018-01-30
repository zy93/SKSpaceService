//
//  SKQuestionDetailsHeader.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/25.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKQuestionDetailsHeader.h"

@implementation SKQuestionDetailsHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}


-(void)commonInit
{
    self.backgroundColor = UICOLOR_MAIN_BACKGROUND;
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.bgView setShadow:UICOLOR_MAIN_BLACK cornerRadius:5.f];
    [self addSubview:self.bgView];
    
    self.clientNameLab = [[UILabel alloc] init];
    [self.clientNameLab setFont:[UIFont systemFontOfSize:15]];
    [self.bgView addSubview:self.clientNameLab];
    
    self.star1Btn = [self createStarButtonWithTag:1001];
    self.star2Btn = [self createStarButtonWithTag:1002];
    self.star3Btn = [self createStarButtonWithTag:1003];
    self.star4Btn = [self createStarButtonWithTag:1004];
    [self.bgView addSubview:self.star1Btn];
    [self.bgView addSubview:self.star2Btn];
    [self.bgView addSubview:self.star3Btn];
    [self.bgView addSubview:self.star4Btn];
    
    self.intentionLab = [[UILabel alloc] init];
    [self.intentionLab setFont:[UIFont systemFontOfSize:15]];
    [self.bgView addSubview:self.intentionLab];
    self.intentionSpaceLab = [[UILabel alloc] init];
    [self.intentionSpaceLab setFont:[UIFont systemFontOfSize:15]];
    [self.bgView addSubview:self.intentionSpaceLab];
    
    [self setupViews];
}

-(void)setupViews {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(5);
        make.bottom.mas_equalTo(-10);
        make.right.mas_equalTo(-5);
    }];
    [self.clientNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
    }];
    
    [self.intentionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.clientNameLab.mas_bottom).offset(13);
        make.left.equalTo(self.clientNameLab.mas_left);
    }];
    [self.intentionSpaceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.intentionLab.mas_bottom).offset(13);
        make.left.equalTo(self.intentionLab.mas_left);
    }];
    [self.star1Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.intentionLab.mas_centerY);
        make.left.equalTo(self.intentionLab.mas_right).offset(3);
    }];
    [self.star2Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.intentionLab.mas_centerY);
        make.left.equalTo(self.star1Btn.mas_right).offset(2);
    }];
    [self.star3Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.intentionLab.mas_centerY);
        make.left.equalTo(self.star2Btn.mas_right).offset(2);
    }];
    [self.star4Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.intentionLab.mas_centerY);
        make.left.equalTo(self.star3Btn.mas_right).offset(2);
    }];
}

#pragma mark - other
-(UIButton *)createStarButtonWithTag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"star_small_gray"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"star_small_yellow"] forState:UIControlStateSelected];
    button.tag = tag;
    return button;
}

@end
