//
//  SKSalesMainVC.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/24.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKSalesMainVC.h"
#import "WOTButton.h"
#import "SKSalesOrderVC.h"
#import "SKCreateSalesVC.h"
#import "SKQuestionListVC.h"
#import "SKLogListVC.h"

@interface SKSalesMainVC ()
@property (nonatomic, strong) UIImageView *topBGIV;
@property (nonatomic, strong) WOTButton *createBtn;
@property (nonatomic, strong) WOTButton *questionBtn;
@property (nonatomic, strong) WOTButton *logBtn;
@end

@implementation SKSalesMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    self.pageTabView.selectedColor = UICOLOR_MAIN_ORANGE;
    self.pageTabView.bottomOffLine = NO;
    [self loadViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self configNav];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self clearNav];
}

-(void)loadViews {
    [self configNaviRightItemWithImage:[UIImage imageNamed:@"top_my"]];
    
    self.topBGIV = [[UIImageView alloc] init];
    self.topBGIV.backgroundColor = UICOLOR_MAIN_ORANGE;
    [self.topBGIV setImage:[UIImage imageNamed:@"top_rectangle"]];
    [self.view addSubview:self.topBGIV];
    
    self.createBtn = [WOTButton buttonWithType:UIButtonTypeCustom];
    [self.createBtn setImage:[UIImage imageNamed:@"top_add"] forState:UIControlStateNormal];
    [self.createBtn setTitle:@"添加客户" forState:UIControlStateNormal];
    [self.createBtn.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
    [self.createBtn addTarget:self action:@selector(createBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.createBtn];
    
    self.questionBtn = [WOTButton buttonWithType:UIButtonTypeCustom];
    [self.questionBtn setImage:[UIImage imageNamed:@"top_question"] forState:UIControlStateNormal];
    [self.questionBtn setTitle:@"问题记录" forState:UIControlStateNormal];
    [self.questionBtn.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
    [self.questionBtn addTarget:self action:@selector(questionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.questionBtn];
    
    self.logBtn = [WOTButton buttonWithType:UIButtonTypeCustom];
    [self.logBtn setImage:[UIImage imageNamed:@"top_log"] forState:UIControlStateNormal];
    [self.logBtn setTitle:@"回访日志" forState:UIControlStateNormal];
    [self.logBtn.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
    [self.logBtn addTarget:self action:@selector(logBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.logBtn];
    
    [self setupView];
}

-(void)setupView
{
    [self.topBGIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(215*[WOTUitls GetLengthAdaptRate]);
    }];
    
    [self.questionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64+20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo((SCREEN_WIDTH-20)/3);
        make.bottom.equalTo(self.topBGIV.mas_bottom);
    }];
    [self.createBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.questionBtn.mas_top);
        make.left.mas_equalTo(10);
        make.right.equalTo(self.questionBtn.mas_left);
        make.width.equalTo(self.questionBtn.mas_width);
        make.bottom.equalTo(self.topBGIV.mas_bottom);
    }];
    [self.logBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.questionBtn.mas_top);
        make.left.equalTo(self.questionBtn.mas_right);
        make.right.mas_equalTo(-10);
        make.width.equalTo(self.questionBtn.mas_width);
        make.bottom.equalTo(self.topBGIV.mas_bottom);
    }];
    
    
    
    
    
    [self.pageTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBGIV.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

-(NSArray *)createTitles{
    return SalesOrderStateList;
}


-(NSArray<__kindof UIViewController *> *)createViewControllers{
    SKSalesOrderVC *vc1 = [[SKSalesOrderVC alloc]init];
    vc1.type = SKSalesOrderVCTYPE_ALL;
    SKSalesOrderVC *vc = [[SKSalesOrderVC alloc]init];
    vc.type = SKSalesOrderVCTYPE_CLIENT_CONSULTING;
    SKSalesOrderVC *vc2 = [[SKSalesOrderVC alloc]init];
    vc2.type = SKSalesOrderVCTYPE_PRELIMINARY_CONTACT;
    SKSalesOrderVC *vc3 = [[SKSalesOrderVC alloc]init];
    vc3.type = SKSalesOrderVCTYPE_FURTHER_CONTACT;
    SKSalesOrderVC *vc4 = [[SKSalesOrderVC alloc]init];
    vc4.type = SKSalesOrderVCTYPE_FINISHED;
    SKSalesOrderVC *vc5 = [[SKSalesOrderVC alloc]init];
    vc5.type = SKSalesOrderVCTYPE_UNFINISHED;

    
    [self addChildViewController:vc1];
    [self addChildViewController:vc ];
    [self addChildViewController:vc2];
    [self addChildViewController:vc3];
    [self addChildViewController:vc4];
    [self addChildViewController:vc5];

    
    return self.childViewControllers;
}

-(void)configNav{
    self.navigationItem.title = @"主页";
    
    //navi颜色
    self.navigationController.navigationBar.translucent = YES;
    UIColor *color = [UIColor clearColor];
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
}

-(void)clearNav {
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = NO;
}


#pragma mark - action
-(void)rightItemAction
{
    
}

-(void)createBtnClick:(id)sender
{
    SKCreateSalesVC *vc = [[SKCreateSalesVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)questionBtnClick:(id)sender
{
    SKQuestionListVC *vc = [[SKQuestionListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)logBtnClick:(id)sender
{
    SKLogListVC *vc = [[SKLogListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
