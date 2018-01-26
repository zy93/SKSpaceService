//
//  SKTextField.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/25.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKTextField.h"

@implementation SKTextField 

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

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit
{
    [self setBackgroundColor:[UIColor whiteColor]];
    [self setShadowWithText];
    self.textField = [[UITextField alloc] init];
    self.textField.delegate = self;
    [self addSubview:self.textField];

    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(15);
    }];
}

-(void)setButton:(BOOL)button
{
    _button = button;
    if (_button) {
        self.arrowIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backAcssory"]];
        [self addSubview:self.arrowIV];
        
        [self.arrowIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.mas_equalTo(-10);
        }];
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.isButton) {
        if (self.selectText) {
            self.selectText(self.textField);
        }
        return  NO;
    }
    return YES;
}

@end
