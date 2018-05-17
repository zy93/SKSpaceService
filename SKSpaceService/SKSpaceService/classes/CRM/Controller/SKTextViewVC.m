//
//  SKTextViewVC.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/26.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKTextViewVC.h"
#import "NSString+Category.h"

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
    [self.textView setFont:[UIFont systemFontOfSize:17.f]];
    
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
    [self.saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.saveBtn];
    
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-40);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(43);
    }];
    
    if (self.type == SKTextViewVCTYPE_EDIT_CLIENT_APPOINTMENT_PEOPLENUM) {
        self.textView.keyboardType = UIKeyboardTypeNumberPad;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - action
- (void)saveBtnClick:(UIButton *)sender
{
    
    switch (self.type) {
        case SKTextViewVCTYPE_EDIT_LOG:
        {
            if (strIsEmpty(self.textView.text)) {
                [MBProgressHUDUtil showMessage:@"请录入信息!" toView:self.view];
                return;
                
            }
            NSDictionary *params = @{@"sellId":self.model.sellId,
                                     @"content":self.textView.text,
                                     };
            [WOTHTTPNetwork addSalesOrderLogWithParam:params success:^(id bean) {
                [MBProgressHUD showMessage:@"添加成功！" toView:self.view hide:YES afterDelay:0.8f complete:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            } fail:^(NSInteger errorCode, NSString *errorMessage) {
                [MBProgressHUDUtil showMessage:errorMessage toView:self.view];
            }];
        }
        
            break;
        case SKTextViewVCTYPE_EDIT_CLIENT_NAME:
            {
                if (strIsEmpty(self.textView.text)) {
                    [MBProgressHUDUtil showMessage:@"请录入信息!" toView:self.view];
                    return;
                    
                }
                NSDictionary *params = @{@"sellId":self.model.sellId,
                                         @"clientName":self.textView.text,
                                         @"contacts":self.textView.text,
                                         };
                [WOTHTTPNetwork updateSalesOrderInfoWithParam:params success:^(id bean) {
                    [MBProgressHUD showMessage:@"修改成功！" toView:self.view hide:YES afterDelay:0.8f complete:^{
                        self.model.clientName = self.textView.text;
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                } fail:^(NSInteger errorCode, NSString *errorMessage) {
                    [MBProgressHUDUtil showMessage:errorMessage toView:self.view];
                }];
                
            }
            break;
        case SKTextViewVCTYPE_EDIT_CLIENT_TEL:
        {
            if (strIsEmpty(self.textView.text) || ![NSString valiMobile:self.textView.text]) {
                [MBProgressHUDUtil showMessage:@"请录入正确手机号!" toView:self.view];
                return;
                
            }
            NSDictionary *params = @{@"sellId":self.model.sellId,
                                     @"tel":self.textView.text,
                                     };
            [WOTHTTPNetwork updateSalesOrderInfoWithParam:params success:^(id bean) {
                [MBProgressHUD showMessage:@"修改成功！" toView:self.view hide:YES afterDelay:0.8f complete:^{
                    self.model.tel = self.textView.text;
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            } fail:^(NSInteger errorCode, NSString *errorMessage) {
                [MBProgressHUDUtil showMessage:errorMessage toView:self.view];
            }];
        }
            break;
        case SKTextViewVCTYPE_EDIT_CLIENT_COMPANY:
        {
            
            NSDictionary *params = @{@"sellId":self.model.sellId,
                                     @"companyName":self.textView.text,
                                     };
            [WOTHTTPNetwork updateSalesOrderInfoWithParam:params success:^(id bean) {
                [MBProgressHUD showMessage:@"修改成功！" toView:self.view hide:YES afterDelay:0.8f complete:^{
                    self.model.companyName = self.textView.text;
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            } fail:^(NSInteger errorCode, NSString *errorMessage) {
                [MBProgressHUDUtil showMessage:errorMessage toView:self.view];
            }];
        }
            break;
        case SKTextViewVCTYPE_EDIT_CLIENT_SPECIFIC_SOURCE:
        {
            if (strIsEmpty(self.textView.text)) {
                [MBProgressHUDUtil showMessage:@"请录入信息!" toView:self.view];
                return;
                
            }
            NSDictionary *params = @{@"sellId":self.model.sellId,
                                     @"specificSource":self.textView.text,
                                     };
            [WOTHTTPNetwork updateSalesOrderInfoWithParam:params success:^(id bean) {
                [MBProgressHUD showMessage:@"修改成功！" toView:self.view hide:YES afterDelay:0.8f complete:^{
                    self.model.specificSource = self.textView.text;
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            } fail:^(NSInteger errorCode, NSString *errorMessage) {
                [MBProgressHUDUtil showMessage:errorMessage toView:self.view];
            }];
        }
            break;
            
        case SKTextViewVCTYPE_EDIT_CLIENT_REMARK:
        {
            if (strIsEmpty(self.textView.text)) {
                [MBProgressHUDUtil showMessage:@"请录入信息!" toView:self.view];
                return;
                
            }
            NSDictionary *params = @{@"sellId":self.model.sellId,
                                     @"remark":self.textView.text,
                                     };
            [WOTHTTPNetwork updateSalesOrderInfoWithParam:params success:^(id bean) {
                [MBProgressHUD showMessage:@"修改成功！" toView:self.view hide:YES afterDelay:0.8f complete:^{
                    self.model.remark = self.textView.text;
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            } fail:^(NSInteger errorCode, NSString *errorMessage) {
                [MBProgressHUDUtil showMessage:errorMessage toView:self.view];
            }];
        }
            break;
        case SKTextViewVCTYPE_EDIT_CLIENT_APPOINTMENT_PEOPLENUM:
        {
            if (strIsEmpty(self.textView.text)) {
                [MBProgressHUDUtil showMessage:@"请录入信息!" toView:self.view];
                return;
                
            }
            NSDictionary *params = @{@"sellId":self.model.sellId,
                                     @"peopleNum":@([self.textView.text integerValue]),
                                     };
            [WOTHTTPNetwork updateSalesOrderInfoWithParam:params success:^(id bean) {
                [MBProgressHUD showMessage:@"修改成功！" toView:self.view hide:YES afterDelay:0.8f complete:^{
                    self.model.peopleNum = @([self.textView.text integerValue]);
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            } fail:^(NSInteger errorCode, NSString *errorMessage) {
                [MBProgressHUDUtil showMessage:errorMessage toView:self.view];
            }];
        }
            break;
        case SKTextViewVCTYPE_EDIT_CLIENT_APPOINTMENT_TIME:
        {
            if (strIsEmpty(self.textView.text)) {
                [MBProgressHUDUtil showMessage:@"请录入信息!" toView:self.view];
                return;
                
            }
            NSDictionary *params = @{@"sellId":self.model.sellId,
                                     @"appointmentTime":self.textView.text,
                                     };
            [WOTHTTPNetwork updateSalesOrderInfoWithParam:params success:^(id bean) {
                [MBProgressHUD showMessage:@"修改成功！" toView:self.view hide:YES afterDelay:0.8f complete:^{
                    self.model.appointmentTime = self.textView.text;
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            } fail:^(NSInteger errorCode, NSString *errorMessage) {
                [MBProgressHUDUtil showMessage:errorMessage toView:self.view];
            }];
        }
            break;
            
        default:
            break;
    }
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
