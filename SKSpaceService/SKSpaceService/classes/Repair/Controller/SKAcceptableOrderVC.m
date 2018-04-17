//
//  SKAcceptableOrderVC.m
//  SKSpaceService
//
//  Created by wangxiaodong on 2018/1/26.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKAcceptableOrderVC.h"
#import "SKOrderIncludeButtonCell.h"
#import "SKOrderInfoModel.h"

@interface SKAcceptableOrderVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray <SKOrderInfoModel*>*infoModelArray;

@end

@implementation SKAcceptableOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[SKOrderIncludeButtonCell class] forCellReuseIdentifier:@"cell"];
    [self layoutSubviews];
    [self AddRefreshHeader];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self queryAcceptableOrderMethod];
}

-(void)layoutSubviews
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-0);
    }];
}

#pragma mark -- Refresh method
/**
 *  添加下拉刷新事件
 */
- (void)AddRefreshHeader
{
    __weak UIScrollView *pTableView = self.tableView;
    ///添加刷新事件
    pTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(StartRefresh)];
    pTableView.mj_header.automaticallyChangeAlpha = YES;
}

- (void)StartRefresh
{
    __weak UIScrollView *pTableView = self.tableView;
    if (pTableView.mj_footer != nil && [pTableView.mj_footer isRefreshing])
    {
        [pTableView.mj_footer endRefreshing];
    }
    [self queryAcceptableOrderMethod];
}

- (void)StopRefresh
{
    __weak UIScrollView *pTableView = self.tableView;
    if (pTableView.mj_header != nil && [pTableView.mj_header isRefreshing])
    {
        [pTableView.mj_header endRefreshing];
    }
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infoModelArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
}

#pragma mark - UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier= @"cell";
    SKOrderIncludeButtonCell *cell = (SKOrderIncludeButtonCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = (SKOrderIncludeButtonCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.disposeButton.tag = indexPath.row;
    [cell.disposeButton addTarget:self action:@selector(acceptAnOrderMethod:) forControlEvents:UIControlEventTouchDown];
    NSLog(@"维修地点：%@",self.infoModelArray[indexPath.row].address);
    cell.serviceAddressInfoLabel.text = self.infoModelArray[indexPath.row].address;
    cell.serviceArticleInfoLabel.text = self.infoModelArray[indexPath.row].type;
    cell.serviceCauseInfoLabel.text = self.infoModelArray[indexPath.row].info;
    cell.serviceTimeInfoLabel.text = self.infoModelArray[indexPath.row].sorderTime;
    return cell;
}

#pragma mark - 接单方法
-(void)acceptAnOrderMethod:(UIButton *)button
{
    [WOTHTTPNetwork acceptAnOrderWithUserName:[WOTUserSingleton shared].userInfo.realName infoId:self.infoModelArray[button.tag].infoId pickUpUserID:[WOTUserSingleton shared].userInfo.staffId success:^(id bean) {
        [MBProgressHUDUtil showMessage:@"接单成功！" toView:self.view];
        [self queryAcceptableOrderMethod];
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [MBProgressHUDUtil showMessage:@"接单失败！" toView:self.view];
    }];
}

#pragma mark - 查询可接订单方法
-(void)queryAcceptableOrderMethod
{
    [WOTHTTPNetwork queryRepairsOrderWithSpaceList:[WOTUserSingleton shared].userInfo.spaceList statuscode:@"1" pickUpUserID:@0 success:^(id bean) {
        SKOrderInfoModel_result *model_result = (SKOrderInfoModel_result *)bean;
        SKOrderInfoModel_msg *model_msg = model_result.msg;
        self.infoModelArray = [NSMutableArray arrayWithArray:model_msg.list];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        [self StopRefresh];
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [self.infoModelArray removeAllObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self StopRefresh];
        });
        [MBProgressHUDUtil showMessage:@"没有订单！" toView:self.view];
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

-(NSMutableArray<SKOrderInfoModel*>*)infoModelArray
{
    if (_infoModelArray == nil) {
        _infoModelArray = [[NSMutableArray alloc] init];
    }
    return _infoModelArray;
}
@end
