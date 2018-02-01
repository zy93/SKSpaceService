//
//  SKServicingOrderVC.m
//  SKSpaceService
//
//  Created by wangxiaodong on 2018/1/29.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKServicingOrderVC.h"
#import "SKOrderTableViewCell.h"
#import "SKOrderInfoModel.h"
#import "SKOrderInfoVC.h"

@interface SKServicingOrderVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray<SKOrderInfoModel*>*servicingOrderArray;
@end

@implementation SKServicingOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[SKOrderTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self layoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self queryAcceptedOrder];
}

-(void)layoutSubviews
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.servicingOrderArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 165;
}

#pragma mark - UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier= @"cell";
    SKOrderTableViewCell *cell = (SKOrderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = (SKOrderTableViewCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.serviceAddressInfoLabel.text = self.servicingOrderArray[indexPath.row].address;
    cell.serviceArticleInfoLabel.text = self.servicingOrderArray[indexPath.row].type;
    cell.serviceCauseInfoLabel.text = self.servicingOrderArray[indexPath.row].info;
    cell.serviceTimeInfoLabel.text = self.servicingOrderArray[indexPath.row].sorderTime;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKOrderInfoVC *orderInfoVC = [[SKOrderInfoVC alloc] init];
    orderInfoVC.titleStr = @"维修完成";
    orderInfoVC.orderInfoModel = self.servicingOrderArray[indexPath.row];
    [self.navigationController pushViewController:orderInfoVC animated:YES];
}

#pragma mark - 查询已经接受的订单
-(void)queryAcceptedOrder
{
    
    [WOTHTTPNetwork queryRepairsOrderWithSpaceList:[WOTUserSingleton shared].userInfo.spaceList statuscode:@"3" pickUpUserID:[WOTUserSingleton shared].userInfo.staffId success:^(id bean) {
        SKOrderInfoModel_result *model_result = (SKOrderInfoModel_result *)bean;
        SKOrderInfoModel_msg *model_msg = model_result.msg;
        self.servicingOrderArray = [NSMutableArray arrayWithArray:model_msg.list];
        //model_msg.list;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [self.servicingOrderArray removeAllObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        [MBProgressHUDUtil showMessage:@"没有接受的订单！" toView:self.view];
    }];
}

-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
    }
    return _tableView;
}

-(NSMutableArray<SKOrderInfoModel*>*)servicingOrderArray
{
    if (_servicingOrderArray == nil) {
        _servicingOrderArray = [[NSMutableArray alloc] init];
    }
    return _servicingOrderArray;
}

@end
