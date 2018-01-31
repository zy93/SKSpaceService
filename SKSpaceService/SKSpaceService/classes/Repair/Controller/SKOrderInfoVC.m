//
//  SKOrderInfoVC.m
//  SKSpaceService
//
//  Created by wangxiaodong on 2018/1/29.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKOrderInfoVC.h"
#import "SKUserOrderInfoView.h"
#import "DetailImageInfoView.h"
#import "ButtonView.h"

@interface SKOrderInfoVC ()
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)SKUserOrderInfoView *userOrderInfoView;
@property(nonatomic,strong)DetailImageInfoView *servicingImageInfoView;
@property(nonatomic,strong)DetailImageInfoView *finishedImageInfoView;
@property(nonatomic,strong)ButtonView *bottomButtonView;
@property(nonatomic,strong)UIView *constView;
@end

@implementation SKOrderInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"报修详情";
    [self.view addSubview:self.scrollView];
    //self.view = self.scrollView;
    //[self.scrollView addSubview:self.constView];
    [self.scrollView addSubview:self.userOrderInfoView];
    [self.scrollView addSubview:self.servicingImageInfoView];
    [self.scrollView addSubview:self.finishedImageInfoView];
    [self.scrollView addSubview:self.bottomButtonView];
    [self layoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)layoutSubviews
{
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomButtonView.mas_bottom).with.offset(10);
    }];
    
//    [self.constView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.scrollView);
//        make.width.height.equalTo(self.scrollView);
//    }];
    
    [self.userOrderInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView).with.offset(15);
        make.left.equalTo(self.scrollView).with.offset(15);
        make.right.equalTo(self.scrollView).with.offset(-15);
        make.height.mas_offset(270);
    }];
    
    [self.servicingImageInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userOrderInfoView.mas_bottom).with.offset(15);
        make.left.equalTo(self.scrollView).with.offset(15);
        make.right.equalTo(self.scrollView).with.offset(-15);
        make.height.mas_offset(120);
    }];
    
    [self.finishedImageInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.servicingImageInfoView.mas_bottom).with.offset(15);
        make.left.equalTo(self.scrollView).with.offset(15);
        make.right.equalTo(self.scrollView).with.offset(-15);
        make.height.mas_offset(120);
    }];
    
    [self.bottomButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.finishedImageInfoView.mas_bottom).with.offset(5);
        //make.bottom.equalTo(self.scrollView.mas_bottom).with.offset(-10);
        make.left.equalTo(self.scrollView.mas_left).with.offset(10);
        make.right.equalTo(self.scrollView.mas_right).with.offset(-10);
        make.centerX.equalTo(self.scrollView);
        make.height.mas_offset(48);
    }];
}

#pragma mark - 开始维修接口
-(void)startService
{
    NSLog(@"开始维修接口");
}

-(UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}


-(SKUserOrderInfoView *)userOrderInfoView
{
    if (_userOrderInfoView == nil) {
        _userOrderInfoView = [[SKUserOrderInfoView alloc] init];
        _userOrderInfoView.backgroundColor = [UIColor whiteColor];
        _userOrderInfoView.layer.shadowOpacity = 0.5;// 阴影透明度
        _userOrderInfoView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        _userOrderInfoView.layer.shadowRadius = 3;// 阴影扩散的范围控制
        _userOrderInfoView.layer.shadowOffset = CGSizeMake(1, 1);// 阴影的范围
    }
    return _userOrderInfoView;
}

-(DetailImageInfoView *)servicingImageInfoView
{
    if (_servicingImageInfoView == nil) {
        _servicingImageInfoView = [[DetailImageInfoView alloc] init];
        _servicingImageInfoView.backgroundColor = [UIColor whiteColor];
        _servicingImageInfoView.layer.shadowOpacity = 0.5;// 阴影透明度
        _servicingImageInfoView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        _servicingImageInfoView.layer.shadowRadius = 3;// 阴影扩散的范围控制
        _servicingImageInfoView.layer.shadowOffset = CGSizeMake(1, 1);// 阴影的范围
        _servicingImageInfoView.titleString = @"维修中图片";
    }
    return _servicingImageInfoView;
}

-(DetailImageInfoView *)finishedImageInfoView
{
    if (_finishedImageInfoView == nil) {
        _finishedImageInfoView = [[DetailImageInfoView alloc] init];
        _finishedImageInfoView.backgroundColor = [UIColor whiteColor];
        _finishedImageInfoView.layer.shadowOpacity = 0.5;// 阴影透明度
        _finishedImageInfoView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        _finishedImageInfoView.layer.shadowRadius = 3;// 阴影扩散的范围控制
        _finishedImageInfoView.layer.shadowOffset = CGSizeMake(1, 1);// 阴影的范围
        _finishedImageInfoView.titleString = @"维修完成图片";
    }
    return _finishedImageInfoView;
}

-(ButtonView *)bottomButtonView
{
    if (_bottomButtonView == nil) {
        _bottomButtonView = [[ButtonView alloc] init];
        _bottomButtonView.buttonTitleStr = @"开始维修";
        [_bottomButtonView.disposeButton addTarget:self action:@selector(startService) forControlEvents:UIControlEventTouchDown];
    }
    return _bottomButtonView;
}

@end
