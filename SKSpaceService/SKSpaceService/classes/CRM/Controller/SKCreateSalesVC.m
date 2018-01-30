//
//  SKCreateSalesVC.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/25.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKCreateSalesVC.h"
#import "SKTextField.h"
#import "WOTSelectWorkspaceListVC.h"
#import "SKSelectTypeVC.h"
#import "SKBaseResponseModel.h"
#import "SKSalesMainVC.h"

@interface SKCreateSalesVC ()
@property (nonatomic, strong) UILabel *clientNameLab;
@property (nonatomic, strong) UILabel *clientTelLab;
@property (nonatomic, strong) UILabel *clientCompanyLab;
@property (nonatomic, strong) UILabel *intentionSpaceLab;
@property (nonatomic, strong) UILabel *clientSourceLab;
@property (nonatomic, strong) UILabel *specificSourceLab;
@property (nonatomic, strong) UILabel *intentionStarLab;
@property (nonatomic, strong) SKTextField *clientNameText;
@property (nonatomic, strong) SKTextField *clientTelText;
@property (nonatomic, strong) SKTextField *clientCompanyText;
@property (nonatomic, strong) SKTextField *intentionSpaceText;
@property (nonatomic, strong) SKTextField *clientSourceText;
@property (nonatomic, strong) SKTextField *specificSourceText;
@property (nonatomic, strong) UIButton *star1Btn;
@property (nonatomic, strong) UIButton *star2Btn;
@property (nonatomic, strong) UIButton *star3Btn;
@property (nonatomic, strong) UIButton *star4Btn;

@property (nonatomic, strong) UIButton *saveBtn;

//数据
@property (nonatomic, strong) NSNumber *spaceId;
@property (nonatomic, strong) NSString *spaceName;
//@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation SKCreateSalesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UICOLOR_MAIN_BACKGROUND;
    self.navigationItem.title = @"添加客户信息";
    [self loadViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadViews {
    self.clientNameLab = [[UILabel alloc] init];
    self.clientNameLab.text = @"客户姓名：";
    [self.clientNameLab setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:self.clientNameLab];
    self.clientTelLab = [[UILabel alloc] init];
    self.clientTelLab.text = @"电话号码：";
    [self.clientTelLab setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:self.clientTelLab];
    self.clientCompanyLab = [[UILabel alloc] init];
    self.clientCompanyLab.text = @"公司名称：";
    [self.clientCompanyLab setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:self.clientCompanyLab];
    self.intentionSpaceLab = [[UILabel alloc] init];
    self.intentionSpaceLab.text = @"意向空间：";
    [self.intentionSpaceLab setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:self.intentionSpaceLab];
    self.clientSourceLab = [[UILabel alloc] init];
    self.clientSourceLab.text = @"客户来源：";
    [self.clientSourceLab setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:self.clientSourceLab];
    self.specificSourceLab = [[UILabel alloc] init];
    self.specificSourceLab.text = @"具体来源：";
    [self.specificSourceLab setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:self.specificSourceLab];
    self.intentionStarLab = [[UILabel alloc] init];
    self.intentionStarLab.text = @"客户意向：";
    [self.intentionStarLab setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:self.intentionStarLab];
    
    self.clientNameText = [[SKTextField alloc] init];
    self.clientNameText.textField.placeholder = @"请输入客户姓名";
    [self.view addSubview:self.clientNameText];
    self.clientTelText = [[SKTextField alloc] init];
    self.clientTelText.textField.placeholder = @"请输入客户电话号码";
    [self.view addSubview:self.clientTelText];
    self.clientCompanyText = [[SKTextField alloc] init];
    self.clientCompanyText.textField.placeholder = @"请输入客户公司名称（选填）";
    [self.view addSubview:self.clientCompanyText];
    self.intentionSpaceText = [[SKTextField alloc] init];
    self.intentionSpaceText.textField.placeholder = @"请选择客户意向空间（选填）";
    self.intentionSpaceText.button = YES;
    __weak typeof(self) weakSelf = self;
    self.intentionSpaceText.selectText = ^(UITextField *textField) {
        WOTSelectWorkspaceListVC *vc = [[WOTSelectWorkspaceListVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
        vc.selectSpaceBlock = ^(WOTSpaceModel *model) {
            textField.text = model.spaceName;
            weakSelf.spaceId = model.spaceId;
            weakSelf.spaceName = model.spaceName;
        };
    };
    [self.view addSubview:self.intentionSpaceText];
    self.clientSourceText = [[SKTextField alloc] init];
    self.clientSourceText.textField.placeholder = @"请选择客户来源";
    self.clientSourceText.button = YES;
    self.clientSourceText.selectText = ^(UITextField *textField) {
        SKSelectTypeVC *vc = [[SKSelectTypeVC alloc] init];
        vc.tableList = SalesClientSource;
        [weakSelf.navigationController pushViewController:vc animated:YES];
        vc.selectSpaceBlock = ^(__autoreleasing id model) {
            textField.text = (NSString *)model;
        };
        
    };
    [self.clientSourceText setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.clientSourceText];
    self.specificSourceText = [[SKTextField alloc] init];
    self.specificSourceText.textField.placeholder = @"请输入客户具体来源";
    [self.view addSubview:self.specificSourceText];
    
    self.star1Btn = [self createStarButtonWithTag:1001];
    [self.view addSubview:self.star1Btn];
    self.star2Btn = [self createStarButtonWithTag:1002];
    [self.view addSubview:self.star2Btn];
    self.star3Btn = [self createStarButtonWithTag:1003];
    [self.view addSubview:self.star3Btn];
    self.star4Btn = [self createStarButtonWithTag:1004];
    [self.view addSubview:self.star4Btn];
    
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.saveBtn setBackgroundColor:UICOLOR_MAIN_ORANGE];
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.saveBtn setShadow:UICOLOR_MAIN_BLACK downOffset:3 cornerRadius:5.f];
    [self.view addSubview:self.saveBtn];
    
    [self setupViews];
}


-(void)setupViews
{
    [self.clientNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(90);
    }];
    [self.clientTelLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.clientNameLab.mas_bottom).offset(35);
        make.left.equalTo(self.clientNameLab.mas_left);
        make.width.equalTo(self.clientNameLab.mas_width);
    }];
    [self.clientCompanyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.clientTelLab.mas_bottom).offset(35);
        make.left.equalTo(self.clientNameLab.mas_left);
        make.width.equalTo(self.clientNameLab.mas_width);
    }];
    [self.intentionSpaceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.clientCompanyLab.mas_bottom).offset(35);
        make.left.equalTo(self.clientNameLab.mas_left);
        make.width.equalTo(self.clientNameLab.mas_width);
    }];
    [self.clientSourceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.intentionSpaceLab.mas_bottom).offset(35);
        make.left.equalTo(self.clientNameLab.mas_left);
        make.width.equalTo(self.clientNameLab.mas_width);
    }];
    [self.specificSourceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.clientSourceLab.mas_bottom).offset(35);
        make.left.equalTo(self.clientNameLab.mas_left);
        make.width.equalTo(self.clientNameLab.mas_width);
    }];
    [self.intentionStarLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.specificSourceLab.mas_bottom).offset(35);
        make.left.equalTo(self.clientNameLab.mas_left);
        make.width.equalTo(self.clientNameLab.mas_width);
    }];
    
    [self.clientNameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.clientNameLab.mas_centerY);
        make.left.equalTo(self.clientNameLab.mas_right).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(35);
    }];
    [self.clientTelText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.clientTelLab.mas_centerY);
        make.left.equalTo(self.clientTelLab.mas_right).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(35);
    }];
    [self.clientCompanyText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.clientCompanyLab.mas_centerY);
        make.left.equalTo(self.clientCompanyLab.mas_right).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(35);
    }];
    [self.intentionSpaceText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.intentionSpaceLab.mas_centerY);
        make.left.equalTo(self.intentionSpaceLab.mas_right).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(35);
    }];
    [self.clientSourceText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.clientSourceLab.mas_centerY);
        make.left.equalTo(self.clientNameLab.mas_right).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(35);
    }];
    [self.specificSourceText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.specificSourceLab.mas_centerY);
        make.left.equalTo(self.clientCompanyLab.mas_right).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(35);
    }];
    [self.star1Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.intentionStarLab.mas_centerY);
        make.left.equalTo(self.clientCompanyLab.mas_right).offset(15);
//        make.right.equalTo(self.view.mas_right).offset(-20);
//        make.height.mas_equalTo(35);
    }];
    [self.star2Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.intentionStarLab.mas_centerY);
        make.left.equalTo(self.star1Btn.mas_right).offset(10);
        //        make.right.equalTo(self.view.mas_right).offset(-20);
        //        make.height.mas_equalTo(35);
    }];
    [self.star3Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.intentionStarLab.mas_centerY);
        make.left.equalTo(self.star2Btn.mas_right).offset(10);
        //        make.right.equalTo(self.view.mas_right).offset(-20);
        //        make.height.mas_equalTo(35);
    }];
    [self.star4Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.intentionStarLab.mas_centerY);
        make.left.equalTo(self.star3Btn.mas_right).offset(10);
        //        make.right.equalTo(self.view.mas_right).offset(-20);
        //        make.height.mas_equalTo(35);
    }];
    
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.bottom.equalTo(self.view.mas_bottom).offset(-40);
        make.height.mas_equalTo(45);
    }];
}

#pragma mark - action
-(void)starBtnClick:(UIButton *)sender
{
    for (int i =1001; i<=1004; i++) {
        UIButton *btn = [self.view viewWithTag:i];
        if (btn.tag<=sender.tag) {
            btn.selected = YES;
        }
        else {
            btn.selected = NO;
        }
    }
}

-(void)saveBtnClick:(UIButton *)sender
{
    if (strIsEmpty(self.clientNameText.textField.text)) {
        [MBProgressHUDUtil showMessage:@"请输入客户姓名！" toView:self.view];
        return;
    }
    else if (strIsEmpty(self.clientTelText.textField.text)) {
        [MBProgressHUDUtil showMessage:@"请输入客户电话号码！" toView:self.view];
        return;
    }
    else if (strIsEmpty(self.clientSourceText.textField.text)) {
        [MBProgressHUDUtil showMessage:@"请选择客户来源！" toView:self.view];
        return;
    }
    else if (strIsEmpty(self.specificSourceText.textField.text)) {
        [MBProgressHUDUtil showMessage:@"请输入具体来源！" toView:self.view];
        return;
    }
    else if (!self.star1Btn.isSelected) {
        [MBProgressHUDUtil showMessage:@"请选择客户意向！" toView:self.view];
        return;
    }
    
    NSMutableDictionary *params = [@{@"clientName":self.clientNameText.textField.text,
                                     @"contacts":self.clientNameText.textField.text,
                                     @"tel":self.clientNameText.textField.text,
                                     @"source":self.clientSourceText.textField.text,
                                     @"specificSource":self.specificSourceText.textField.text,
                                     @"will":[self getClientIntention],
                                     @"stage":@"客户咨询",
                                     @"leaderId":[WOTUserSingleton shared].userInfo.staffId,
                                     @"leaderName":[WOTUserSingleton shared].userInfo.realName,
                             } mutableCopy];
    if (!strIsEmpty(self.spaceName)) {
        [params setValue:self.spaceId   forKey:@"spaceId"];
        [params setValue:self.spaceName forKey:@"spaceName"];
    }
    if (!strIsEmpty(self.clientCompanyText.textField.text)) {
        [params setValue:self.clientCompanyText.textField.text forKey:@"companyName"];
    }
    
    [WOTHTTPNetwork addSalesOrderWithParam:params success:^(id bean) {
        [MBProgressHUD showMessage:@"添加成功！" toView:self.view hide:YES afterDelay:0.8f complete:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [MBProgressHUDUtil showMessage:errorMessage toView:self.view];
    }];
    
}



#pragma mark - other
-(UIButton *)createStarButtonWithTag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"star_big_gray"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"star_big_yellow"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(starBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    return button;
}

-(NSString *)getClientIntention
{
    NSString *result = nil;
    if (self.star1Btn.isSelected) {
        result = SalesOrderIntentionList[0];
    }
     if (self.star2Btn.isSelected) {
        result = SalesOrderIntentionList[1];
    }
     if (self.star3Btn.isSelected) {
        result = SalesOrderIntentionList[2];
    }
     if (self.star4Btn.isSelected) {
        result = SalesOrderIntentionList[3];
    }
    
    return result;
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
