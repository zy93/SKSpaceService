//
//  SKSalesOrderVC.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/24.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKSalesOrderVC.h"
#import "SKSalesOrderCell.h"
#import "SKLogDetailsVC.h"
#import "SKSalesOrderModel.h"
#import "SKSalesMainVC.h"

@interface SKSalesOrderVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray * tableList;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation SKSalesOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        //.with.offset(-215*[WOTUitls GetLengthAdaptRate]);
        make.left.right.top.equalTo(self.view);
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"SKSalesOrderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SKSalesOrderCell"];
    [self AddRefreshHeader];
    [self StartRefresh];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - request
-(void)createRequest
{
    __weak typeof(self) weakSelf = self;
    NSArray *arr = SalesOrderStateList;
    if (self.type == SKSalesOrderVCTYPE_CLIENT_ORDER) {
        [WOTHTTPNetwork getUntreatedSalesOrderSuccess:^(id bean) {
            SKUntreatedSalesOrder_msg *model = bean;
            weakSelf.tableList = model.msg;
            [weakSelf StopRefresh];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
            });
            
        } fail:^(NSInteger errorCode, NSString *errorMessage) {
            [weakSelf StopRefresh];
            [MBProgressHUDUtil showMessage:errorMessage toView:self.view];
        }];
    }
    else {
        [WOTHTTPNetwork getSalesOrderWithState:self.type==0?nil:arr[self.type] success:^(id bean) {
            SKSalesOrder_msg *model = bean;
            weakSelf.tableList = model.msg.list;
            [weakSelf StopRefresh];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
            });
        } fail:^(NSInteger errorCode, NSString *errorMessage) {
            [weakSelf StopRefresh];
            [MBProgressHUDUtil showMessage:errorMessage toView:self.view];
        }];
    }
    
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
    [self createRequest];
}

- (void)StopRefresh
{
    __weak UIScrollView *pTableView = self.tableView;
    if (pTableView.mj_header != nil && [pTableView.mj_header isRefreshing])
    {
        [pTableView.mj_header endRefreshing];
    }
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SKSalesOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKSalesOrderCell" forIndexPath:indexPath];
    
    // Configure the cell...
    SKSalesOrderModel *model = self.tableList[indexPath.row];
    cell.stateLab.text = model.stage;
    if ([model.stage isEqualToString:@"客户咨询"]) {
        cell.stateLab.backgroundColor = UICOLOR_BLUE_7D;
    }
    else if ([model.stage isEqualToString:@"初步接洽"]) {
        cell.stateLab.backgroundColor = UICOLOR_GREE_B0;
    }
    else if ([model.stage isEqualToString:@"深入沟通"]) {
        cell.stateLab.backgroundColor = UICOLOR_PURPLE_E1;
    }
    else if ([model.stage isEqualToString:@"赢单"]) {
        cell.stateLab.backgroundColor = UICOLOR_RED_DC;
    }
    else
    {
        cell.stateLab.backgroundColor = UICOLOR_GRAY_AA;
    }
    cell.titleLab.text = model.clientName;
    if ([model.will isEqualToString:SalesOrderIntentionList[0]]) {
        cell.star1IV.selected = YES;
        cell.star2IV.selected = NO;
        cell.star3IV.selected = NO;
        cell.star4IV.selected = NO;
    }
    else if ([model.will isEqualToString:SalesOrderIntentionList[1]]) {
        cell.star1IV.selected = YES;
        cell.star2IV.selected = YES;
        cell.star3IV.selected = NO;
        cell.star4IV.selected = NO;
    }
    else if ([model.will isEqualToString:SalesOrderIntentionList[2]]) {
        cell.star1IV.selected = YES;
        cell.star2IV.selected = YES;
        cell.star3IV.selected = YES;
        cell.star4IV.selected = NO;
    }
    else if ([model.will isEqualToString:SalesOrderIntentionList[3]]) {
        cell.star1IV.selected = YES;
        cell.star2IV.selected = YES;
        cell.star3IV.selected = YES;
        cell.star4IV.selected = YES;
    }
    else
    {
        cell.star1IV.selected = NO;
        cell.star2IV.selected = NO;
        cell.star3IV.selected = NO;
        cell.star4IV.selected = NO;
    }
    cell.dateLab.text = [model.createTime substringToIndex:11];
    if ([model.stage isEqualToString:@"客户订单"]) {
        cell.starBGView.hidden = YES;
        cell.detailsLab.hidden = NO;
    }
    else {
        cell.starBGView.hidden = NO;
        cell.detailsLab.hidden = YES;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKLogDetailsVC *vc = [[SKLogDetailsVC alloc] init];
    vc.model = self.tableList[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - other

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
