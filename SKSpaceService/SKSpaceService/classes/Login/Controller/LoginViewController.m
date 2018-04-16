//
//  LoginViewController.m
//  LoginDemo
//
//  Created by git on 2017/12/1.
//  Copyright © 2017年 YiLiANGANG. All rights reserved.
//登录界面

#import "LoginViewController.h"
#import "Masonry.h"
#import "UIColor+ColorChange.h"
#import "SKSelectIdentityView.h"
#import "AppDelegate.h"
#import <JPUSHService.h>


@interface LoginViewController () <SKSelectIdentityViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIView *userTelView;
@property (nonatomic, strong) UIImageView *userTelImageView;
@property (nonatomic, strong) UITextField *userTelField;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *verificationCodeImageView;
@property (nonatomic, strong) UITextField *verificationCodeField;

@property (nonatomic, strong) UIButton *rememberPasswordButton;
@property (nonatomic, strong) UILabel *rememberPasswordLabel;
@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.view.backgroundColor = [UIColor whiteColor];
    self.logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_ylg"]];
    self.logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.logoImageView];
    self.navigationItem.title = @"登录";

    self.userTelView = [UIView new];
    self.userTelView.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    self.userTelView.layer.cornerRadius = 5.f;
    [self.view addSubview:self.userTelView];
    
    
    self.userTelImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"usericon"]];
    self.userTelImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.userTelView addSubview:self.userTelImageView];
    
    self.userTelField = [[UITextField alloc] init];
    self.userTelField.delegate = self;
    self.userTelField.placeholder = @"请输入手机号";
    [self.userTelView addSubview:self.userTelField];
    
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.userTelView addSubview:self.lineView];
    
    self.verificationCodeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pwdicon"]];
    self.verificationCodeImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.userTelView addSubview:self.verificationCodeImageView];
    
    self.verificationCodeField = [[UITextField alloc] init];
    self.verificationCodeField.delegate = self;
    self.verificationCodeField.placeholder = @"请输入密码";
    self.verificationCodeField.secureTextEntry = YES;
    [self.userTelView addSubview:self.verificationCodeField];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginButton addTarget:self action:@selector(loginButtonMethod) forControlEvents:UIControlEventTouchDown];
    [self.loginButton setBackgroundColor:UICOLOR_MAIN_ORANGE];
    [self.loginButton setTitle:@"登  录" forState:UIControlStateNormal];
    [self.loginButton.layer setCornerRadius:5.f];
    [self.view addSubview:self.loginButton];
    
    self.rememberPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rememberPasswordButton setBackgroundImage:[UIImage imageNamed:@"noselect"] forState:UIControlStateNormal];
    [self.rememberPasswordButton addTarget:self action:@selector(rememberPasswordButtonMethod:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.rememberPasswordButton];
    
    self.rememberPasswordLabel = [[UILabel alloc] init];
    self.rememberPasswordLabel.text = @"下次自动登录";
    self.rememberPasswordLabel.textColor = [UIColor grayColor];
    [self.rememberPasswordLabel setFont:[UIFont systemFontOfSize:12.f]];
    [self.view addSubview:self.rememberPasswordLabel];
    
   
}
-(void)viewDidLayoutSubviews
{
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(120);
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.right.equalTo(self.view.mas_right).with.offset(-30);
        make.height.mas_equalTo(70);
    }];
    
    [self.userTelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageView.mas_bottom).with.offset(50);
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.right.equalTo(self.view.mas_right).with.offset(-30);
        make.height.mas_equalTo(100);
    }];
    
    [self.userTelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userTelView).with.offset(10);
        make.top.equalTo(self.userTelView).with.offset(15);
        make.width.mas_equalTo(42);
        make.height.mas_equalTo(21);
    }];
    
    [self.userTelField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userTelImageView);
        make.left.equalTo(self.userTelImageView.mas_right);
        make.right.equalTo(self.userTelView);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userTelView);
        make.left.equalTo(self.userTelView).with.offset(20);
        make.right.equalTo(self.userTelView).with.offset(-20);
        make.height.mas_offset(1);
    }];
    
    [self.verificationCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userTelView).with.offset(10);
        make.top.equalTo(self.lineView.mas_bottom).with.offset(15);
        make.width.mas_equalTo(42);
        make.height.mas_equalTo(21);
    }];
    
    [self.verificationCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).with.offset(15);
        make.left.equalTo(self.verificationCodeImageView.mas_right);
        make.right.equalTo(self.userTelView);
    }];
    
    [self.rememberPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userTelView.mas_bottom).with.offset(20);
        make.left.equalTo(self.userTelView).with.offset(10);
        make.height.width.with.mas_equalTo(15);
    }];
    
    [self.rememberPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rememberPasswordButton.mas_top);
        make.left.equalTo(self.rememberPasswordButton.mas_right).with.offset(5);
        make.centerY.equalTo(self.rememberPasswordButton);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rememberPasswordButton.mas_bottom).with.offset(15);
        make.left.equalTo(self.userTelView);
        make.right.equalTo(self.userTelView);
        make.height.mas_equalTo(50);
    }];
    
}


-(void)rememberPasswordButtonMethod:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected) {
        [self.rememberPasswordButton setBackgroundImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    }
    else
    {
        [self.rememberPasswordButton setBackgroundImage:[UIImage imageNamed:@"noselect"] forState:UIControlStateNormal];
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 登录
-(void)loginButtonMethod
{

    BOOL isUserTel = [self.userTelField.text isEqualToString:@""] || self.userTelField.text ==NULL;
    BOOL isPassWord = [self.verificationCodeField.text isEqualToString:@""] || self.userTelField.text == NULL;
    if (isUserTel || isPassWord) {
        [MBProgressHUDUtil showMessage:@"请填写完整信息！" toView:self.view];
        return;
    }
    else if (![NSString valiMobile:self.userTelField.text]) {
        [MBProgressHUDUtil showMessage:@"电话格式不正确！" toView:self.view];
        return;
    }
    NSString *alias = [NSString stringWithFormat:@"%@S",self.userTelField.text];
    [WOTHTTPNetwork userLoginWithTelOrEmail:self.userTelField.text password:self.verificationCodeField.text alias:alias success:^(id bean) {
        SKLoginModel_msg *model = bean;
        if ([model.code isEqualToString:@"200"]) {
            NSLog(@"权限字段%@",[[WOTUserSingleton shared] getUserPermissions]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[WOTUserSingleton shared] saveUserInfoToPlistWithModel:model.msg];
                [WOTUserSingleton shared].login = YES;
                //让用户选择所要进入的页面。[WOTUserSingleton shared] getUserPermissions]
                if ([[WOTUserSingleton shared] getUserPermissions].count == 0) {
                    [MBProgressHUDUtil showMessage:@"没有权限！" toView:self.view];
                    return ;
                }
                SKSelectIdentityView *select = [[SKSelectIdentityView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, CGRectGetHeight(self.view.frame)) buttonTitles:[[WOTUserSingleton shared] getUserPermissions]];
                select.delegate = self;
                [self.view addSubview:select];
                [select showView];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                    } seq:1];
                });
            });
        }else
        {
            [MBProgressHUDUtil showMessage:model.result toView:self.view];
        }
        
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [MBProgressHUDUtil showMessage:errorMessage toView:self.view];
    }];
}

#pragma mark - text delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

#pragma mark - selectIndentity delegate
-(void)selectIdentityView:(SKSelectIdentityView *)view selectIndentity:(NSString *)indentity
{
    
    [WOTUserSingleton shared].userInfo.currentPermission = indentity;
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate loadViewControllerWithName:permissionVCNameList[indentity]];
    
}



@end
