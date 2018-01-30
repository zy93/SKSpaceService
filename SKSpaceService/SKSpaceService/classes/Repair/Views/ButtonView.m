//
//  ButtonView.m
//  ScrollViewClickDemo
//
//  Created by wangxiaodong on 2017/12/19.
//  Copyright © 2017年 wangxiaodong. All rights reserved.
//

#import "ButtonView.h"
#import "Masonry.h"
#import "UIColor+ColorChange.h"
#import "WOTConstants.h"
@interface ButtonView()



@end

@implementation ButtonView

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [self setUpView];
}

-(void)setUpView
{
    self.disposeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.disposeButton setTitle:self.buttonTitleStr forState:UIControlStateNormal];
    self.disposeButton.backgroundColor = UICOLOR_MAIN_ORANGE;
    self.disposeButton.layer.cornerRadius = 5.f;
    self.disposeButton.layer.borderWidth = 1.f;
    self.disposeButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [self addSubview:self.disposeButton];
    [self setUpLayout];
}

-(void)setUpLayout
{
    
    [self.disposeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.left.equalTo(self).with.offset(10);
        make.right.equalTo(self).with.offset(-10);
        make.height.equalTo(self);
    }];
}

@end
