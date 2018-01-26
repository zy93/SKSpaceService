//
//  SKTextViewVC.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/26.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKTextViewVC.h"

@interface SKTextViewVC ()

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation SKTextViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"编辑";
    self.view.backgroundColor = UICOLOR_MAIN_BACKGROUND;
    self.textView = [[UITextView alloc] init];
    [self.view addSubview:self.textView];
    self.textView.layer.cornerRadius = 5.f;
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(140);
    }];

    
    CGFloat viewWidth = SCREEN_WIDTH - 20;
    CGFloat viewHeight = 140;
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = CGRectMake(0, 0, viewWidth, viewHeight);
    borderLayer.position = CGPointMake(SCREEN_WIDTH/2, 10+(viewHeight/2));
    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:5.f].CGPath;
    borderLayer.lineWidth = 1.f;
    //虚线边框
    borderLayer.lineDashPattern = @[@4, @2];
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = UIColorFromRGB(0xc9c9c9).CGColor;
    [self.view.layer addSublayer:borderLayer];
    
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.saveBtn setBackgroundColor:UICOLOR_MAIN_ORANGE];
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:UICOLOR_WHITE forState:UIControlStateNormal];
    [self.saveBtn.layer setCornerRadius:5.f];
    [self.view addSubview:self.saveBtn];
    
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-40);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(43);
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
