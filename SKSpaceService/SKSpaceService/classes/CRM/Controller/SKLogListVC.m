//
//  SKLogListVC.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/26.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKLogListVC.h"
#import "SKLogListCell.h"
#import "SKLogDetailsVC.h"
#import "SKSalesOrderModel.h"
#import "SKSalesMainVC.h"

@interface SKLogListVC ()
@property (nonatomic, strong) NSArray *tableList;
@end

@implementation SKLogListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"回访日志";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"SKLogListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SKLogListCell"];
    [self AddRefreshHeader];
    [self StartRefresh];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - request
-(void)createRequest
{
    [WOTHTTPNetwork getSalesOrderWithState:nil success:^(id bean) {
        SKSalesOrder_msg *model = bean;
        self.tableList = model.msg.list;
        [self.tableView reloadData];
        [self StopRefresh];
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [self StopRefresh];
        [MBProgressHUDUtil showMessage:errorMessage toView:self.view];
    }];
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
    return 175;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SKLogListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKLogListCell" forIndexPath:indexPath];
    
    // Configure the cell...
    SKSalesOrderModel *model = self.tableList[indexPath.row];
    
    cell.clientNameLab.text =[NSString stringWithFormat:@"客户姓名：%@",model.clientName];
    cell.clientTelLab.text = [NSString stringWithFormat:@"客户电话：%@",model.tel];
    cell.createTimeLab.text = [NSString stringWithFormat:@"创建时间：%@",[model.createTime substringToIndex:16]];
    cell.stateLab.text = model.stage ;
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
    if ([model.will isEqualToString:SalesOrderIntentionList[0]]) {
        cell.star1Btn.selected = YES;
        cell.star2Btn.selected = NO;
        cell.star3Btn.selected = NO;
        cell.star4Btn.selected = NO;
    }
    else if ([model.will isEqualToString:SalesOrderIntentionList[1]]) {
        cell.star1Btn.selected = YES;
        cell.star2Btn.selected = YES;
        cell.star3Btn.selected = NO;
        cell.star4Btn.selected = NO;
    }
    else if ([model.will isEqualToString:SalesOrderIntentionList[2]]) {
        cell.star1Btn.selected = YES;
        cell.star2Btn.selected = YES;
        cell.star3Btn.selected = YES;
        cell.star4Btn.selected = NO;
    }
    else if ([model.will isEqualToString:SalesOrderIntentionList[3]]) {
        cell.star1Btn.selected = YES;
        cell.star2Btn.selected = YES;
        cell.star3Btn.selected = YES;
        cell.star4Btn.selected = YES;
    }
    else
    {
        cell.star1Btn.selected = NO;
        cell.star2Btn.selected = NO;
        cell.star3Btn.selected = NO;
        cell.star4Btn.selected = NO;
    }
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SKLogDetailsVC *vc = [[SKLogDetailsVC alloc] init];
    vc.model = self.tableList[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

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
