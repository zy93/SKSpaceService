//
//  SKProviderOrderListVC.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/2/28.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKProviderOrderListVC.h"
#import "SKDemandeCell.h"
#import "SKDemandModel.h"
#import "SKDemandDetailsVC.h"

@interface SKProviderOrderListVC () <SKDemandeCellDelegate>
@property (nonatomic, strong) NSArray * tableList;

@end

@implementation SKProviderOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerNib:[UINib nibWithNibName:@"SKDemandeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SKDemandeCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self createRequest];
    [self AddRefreshHeader];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - request
-(void)createRequest
{
    switch (self.vcType ) {
        case SKProviderOrderListVCTYPE_UNTREATED:
        {
            [WOTHTTPNetwork getDemandWithState:@"未处理" success:^(id bean) {
                self.tableList = ((SKDemandModel_msg*)bean).msg.list;
                [self StopRefresh];
                [self.tableView reloadData];
                
            } fail:^(NSInteger errorCode, NSString *errorMessage) {
                [self StopRefresh];
            }];
        }
            break;
        case SKProviderOrderListVCTYPE_INTREATED:
        {
            [WOTHTTPNetwork getDemandWithState:@"处理中" success:^(id bean) {
                self.tableList = ((SKDemandModel_msg*)bean).msg.list;
                [self StopRefresh];
                [self.tableView reloadData];
            } fail:^(NSInteger errorCode, NSString *errorMessage) {
                
            }];
        }
            break;
        case SKProviderOrderListVCTYPE_TREATED:
        {
            [WOTHTTPNetwork getDemandWithState:@"已处理" success:^(id bean) {
                self.tableList = ((SKDemandModel_msg*)bean).msg.list;
                [self StopRefresh];
                [self.tableView reloadData];
            } fail:^(NSInteger errorCode, NSString *errorMessage) {
                
            }];
        }
            break;
        default:
            break;
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

#pragma mark - delegate
-(void)demandeCell:(SKDemandeCell *)cell buttonClick:(NSIndexPath *)index
{
    switch (self.vcType) {
        case SKProviderOrderListVCTYPE_UNTREATED:
        {
            SKDemandModel *model = self.tableList[index.row];
            NSDictionary *parameters = @{@"demandId":model.demandId,
                                        @"staffId":[WOTUserSingleton shared].userInfo.staffId,
                                         @"staffName":[WOTUserSingleton shared].userInfo.staffName,
                                        @"dealState":@"处理中",
                                         };
            [WOTHTTPNetwork setDemandWithParams:parameters success:^(id bean) {
                [MBProgressHUDUtil showMessage:@"接受成功！状态已更改为沟通中" toView:self.view];
            } fail:^(NSInteger errorCode, NSString *errorMessage) {
                [MBProgressHUDUtil showMessage:@"接受失败！请稍后再试！" toView:self.view];

            }];
        }
            break;
        case SKProviderOrderListVCTYPE_INTREATED:
        {
            SKDemandDetailsVC *vc = [[SKDemandDetailsVC alloc] init];
            vc.model = self.tableList[index.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case SKProviderOrderListVCTYPE_TREATED:
        {
        }
            break;
        default:
            break;
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
    return 180;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SKDemandeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKDemandeCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[SKDemandeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SKDemandeCell"];
    }
    
    SKDemandModel *model = self.tableList[indexPath.row];
    cell.addrValueLab.text = model.spaceName;
    cell.nameValueLab.text = model.userName;
    cell.telValueLab.text  = model.tel;
    cell.createValueLab.text = model.putTime;
    cell.delegate = self;
    cell.index = indexPath;
    if ([model.needType isEqualToString:@"服务商"]) {
        cell.demandeValueLab.text= model.firmName;
    }
    else {
        cell.demandeValueLab.text= model.demandContent;
    }
    switch (self.vcType) {
        case SKProviderOrderListVCTYPE_UNTREATED:
        {
            [cell.btn setTitle:@"接受" forState:UIControlStateNormal];
        }
            break;
        case SKProviderOrderListVCTYPE_INTREATED:
        {
            [cell.btn setTitle:@"查看详情" forState:UIControlStateNormal];
        }
            break;
        case SKProviderOrderListVCTYPE_TREATED:
        {
            [cell.btn setTitle:@"查看详情" forState:UIControlStateNormal];
        }
        default:
            break;
    }
    
    return cell;
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
