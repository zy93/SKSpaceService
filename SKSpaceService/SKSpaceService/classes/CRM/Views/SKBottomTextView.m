//
//  SKBottomTextView.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/26.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKBottomTextView.h"

@implementation SKBottomTextView

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
    self.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = UICOLOR_MAIN_LINE;
    [self addSubview:line];
    
    self.textView = [[UITextView alloc] init];
    self.textView.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.textView.layer.borderWidth = 1.f;
    self.textView.layer.cornerRadius = 5.f;
    [self.textView setFont:[UIFont systemFontOfSize:16.f]];
    [self addSubview:self.textView];
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [self.addBtn setBackgroundColor:UICOLOR_MAIN_ORANGE];
    self.addBtn.layer.cornerRadius = 5.f;
    [self addSubview:self.addBtn];
    
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.height.mas_offset(1);
    }];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(8);
        make.right.mas_offset(-15);
        make.bottom.mas_offset(-5);
        make.width.mas_offset(60);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(8);
        make.left.mas_offset(12);
        make.bottom.mas_offset(-5);
        make.right.equalTo(self.addBtn.mas_left).offset(-10);
    }];
}

-(void)addBtnClick:(UIButton *)sender
{
    if (self.editingText) {
        self.editingText(self.textView.text);
    }
}

@end
