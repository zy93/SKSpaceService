//
//  SKOperationmanageViewController.m
//  SKSpaceService
//
//  Created by wangxiaodong on 10/10/2018.
//  Copyright © 2018 张雨. All rights reserved.
//

#import "SKOperationmanageViewController.h"
#import "WOTWorkStationHistoryModel.h"
#import "SKOrderNotificationCell.h"


@interface SKOperationmanageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray <WOTWorkStationHistoryModel*>*infoModelArray;
@property (nonatomic,assign) int pageNum;
@end

@implementation SKOperationmanageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //self.title = @"工位预定信息";
    self.pageNum = 1;
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[SKOrderNotificationCell class] forCellReuseIdentifier:@"cell"];
    [self layoutSubviews];
    [self AddRefreshHeader];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self queryBookStationOrder];//查询订单
}

-(void)layoutSubviews
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-0);
    }];
}

/**
 *  添加下拉刷新事件
 */
- (void)AddRefreshHeader
{
    __weak UIScrollView *pTableView = self.tableView;
    ///添加刷新事件
    pTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(StartRefresh)];
    pTableView.mj_header.automaticallyChangeAlpha = YES;
    
    pTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];

}

- (void)StartRefresh
{
    self.pageNum = 1;
    __weak UIScrollView *pTableView = self.tableView;
    if (pTableView.mj_footer != nil && [pTableView.mj_footer isRefreshing])
    {
        [pTableView.mj_footer endRefreshing];
    }
    [self queryBookStationOrder];
}

- (void)StopRefresh
{
    __weak UIScrollView *pTableView = self.tableView;
    if (pTableView.mj_header != nil && [pTableView.mj_header isRefreshing])
    {
        [pTableView.mj_header endRefreshing];
    }
}

#pragma mark - 停止刷新
- (void)stoploadMoreTopic
{
    __weak UIScrollView *pTableView = self.tableView;
    if (pTableView.mj_footer != nil && [pTableView.mj_footer isRefreshing])
    {
        [pTableView.mj_footer endRefreshing];
    }
}



#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infoModelArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

#pragma mark - UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier= @"cell";
    SKOrderNotificationCell *cell = (SKOrderNotificationCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = (SKOrderNotificationCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.clientNameInfoLabel.text = self.infoModelArray[indexPath.row].userName;
    if ([self.infoModelArray[indexPath.row].commodityKind isEqualToString:@"长租工位"]) {
        cell.presetTimeInfoLabel.text = self.infoModelArray[indexPath.row].commodityNumList;
        cell.spaceInfoLabel.text =[NSString stringWithFormat:@"%@·%@",self.infoModelArray[indexPath.row].spaceName,self.infoModelArray[indexPath.row].commodityName];// self.infoModelArray[indexPath.row].spaceName;
    }else
    {
        cell.presetTimeInfoLabel.text = self.infoModelArray[indexPath.row].starTime;
        cell.spaceInfoLabel.text = self.infoModelArray[indexPath.row].spaceName;
    }
    
    return cell;
}

#pragma mark - 查询用户工位下单
-(void)queryBookStationOrder
{
    NSArray *arr = @[@"工位",@"会议室",@"长租工位"];
    NSDictionary *dict = @{@"pageNo":@(self.pageNum),@"pageSizev":@10,@"spaceList":[WOTUserSingleton shared].userInfo.spaceList,@"commodityKind":arr[self.orderlisttype],@"orderState":@"SUCCESS"};
     __weak typeof(self) weakSelf = self;
    if (self.pageNum == 1) {
        [weakSelf.infoModelArray removeAllObjects];
    }
    [WOTHTTPNetwork getReserveBookStationOrderWithPict:dict success:^(id bean) {
        WOTWorkStationHistoryModel_msg *model = bean;
        [self StopRefresh];
        if ([model.code isEqualToString:@"200"]) {
            
            weakSelf.infoModelArray = [[NSMutableArray alloc] initWithArray:model.msg.list];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
            });
        }
        else {
            [MBProgressHUDUtil showMessage:model.result toView:self.view];
        }
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [MBProgressHUDUtil showMessage:@"订单查询失败" toView:self.view];
        return ;
    }];
}


#pragma mark - 上拉刷新
-(void)loadMoreTopic
{
    __weak typeof(self) weakSelf = self;
    self.pageNum++;
     NSArray *arr = @[@"工位",@"会议室",@"长租工位"];
    NSDictionary *dict = @{@"pageNo":@(self.pageNum),@"pageSizev":@10,@"spaceList":[WOTUserSingleton shared].userInfo.spaceList,@"commodityKind":arr[self.orderlisttype],@"orderState":@"SUCCESS"};
    [WOTHTTPNetwork getReserveBookStationOrderWithPict:dict success:^(id bean) {
        WOTWorkStationHistoryModel_msg *model = bean;
        [self StopRefresh];
        if ([model.code isEqualToString:@"200"]) {
            
            [weakSelf.infoModelArray addObjectsFromArray:model.msg.list];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf stoploadMoreTopic];
                [weakSelf.tableView reloadData];
            });
        }
        else {
            [weakSelf stoploadMoreTopic];
            [MBProgressHUDUtil showMessage:model.result toView:self.view];
        }
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [weakSelf stoploadMoreTopic];
        if (errorCode == 202) {
            [MBProgressHUDUtil showMessage:@"没有订单了" toView:self.view];
        }
        
        return ;
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

-(NSMutableArray<WOTWorkStationHistoryModel*>*)infoModelArray
{
    if (_infoModelArray == nil) {
        _infoModelArray = [[NSMutableArray alloc] init];
    }
    return _infoModelArray;
}


@end
