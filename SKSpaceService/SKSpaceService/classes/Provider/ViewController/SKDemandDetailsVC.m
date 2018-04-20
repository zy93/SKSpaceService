//
//  SKDemandDetailsVC.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/3/2.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKDemandDetailsVC.h"
#import "SKLogContentCell.h"
#import "SKDemandeCell.h"
#import "SKDemandeLogModel.h"
#import "SKBottomTextView.h"

@interface SKDemandDetailsVC () <SKDemandeCellDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray * tableList;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SKBottomTextView * textView;
@end

@implementation SKDemandDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
    self.navigationItem.title = @"需求详情";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"SKLogContentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SKLogContentCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SKDemandeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SKDemandeCell"];
    if (self.vcType == SKDemandDetailsVCTYPE_INTREATED) {
        [self loadBottomTextView];
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.bottom.equalTo(self.textView?self.textView.mas_top:self.view.mas_bottom);
    }];
    
    [self AddRefreshHeader];
    [self createRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadBottomTextView
{
    __weak typeof(self) weakSelf = self;
    self.textView = [[SKBottomTextView alloc] init];
    self.textView.editingText = ^(NSString *string) {
        if (strIsEmpty(string)) {
            [MBProgressHUDUtil showMessage:@"日志内容不能为空！" toView:weakSelf.view];
            return ;
        }
        [WOTHTTPNetwork addDemandLogWithDemandId:weakSelf.model.demandId content:string success:^(id bean) {
            weakSelf.textView.textView.text = nil;
            //应该手动加一个model到list尾部
            [weakSelf StartRefresh];
        } fail:^(NSInteger errorCode, NSString *errorMessage) {
            if (errorCode != 202) {
                [MBProgressHUDUtil showMessage:errorMessage toView:weakSelf.view];
            }
        }];
        
    };
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.left.mas_offset(0);
        make.right.equalTo(self.tableView.mas_right);
        make.height.mas_offset(52);
    }];
}

#pragma mark - request
-(void)createRequest
{
    [WOTHTTPNetwork getDemandLogWithDemandId:self.model.demandId success:^(id bean) {
        self.tableList = ((SKDemandeLogModel_msg *)bean).msg;
        [self StopRefresh];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [self StopRefresh];
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

#pragma mark - cell delegate
-(void)demandeCell:(SKDemandeCell *)cell buttonClick:(NSIndexPath *)index
{
    NSDictionary *parameters = @{@"demandId":self.model.demandId,
                                 @"dealState":@"已处理",
                                 };
    [WOTHTTPNetwork setDemandWithParams:parameters success:^(id bean) {
        [MBProgressHUDUtil showMessage:@"状态已变更为处理完成！" toView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [MBProgressHUDUtil showMessage:@"修改失败！请稍后再试！" toView:self.view];
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 230;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKDemandeLogModel *model = self.tableList[indexPath.row];
    CGFloat h = [model.log heightWithFont:[UIFont systemFontOfSize:15.f] maxWidth:(SCREEN_WIDTH-60)];
    return h+90;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SKDemandeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKDemandeCell"];
    cell.addrValueLab.text = self.model.spaceName;
    cell.nameValueLab.text = self.model.userName;
    cell.telValueLab.text  = self.model.tel;
    cell.createValueLab.text = self.model.putTime;
    cell.delegate = self;
    if ([self.model.needType isEqualToString:@"服务商"]) {
        cell.demandeValueLab.text= self.model.firmName;
    }
    else {
        cell.demandeValueLab.text= self.model.demandContent;
    }
    cell.bgViewBottomConstraints.constant = 20;
    [cell.btn setTitle:@"完成" forState:UIControlStateNormal];
    if (self.vcType == SKDemandDetailsVCTYPE_TREATED) {
        cell.btn.hidden = YES;
    }
    return cell;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SKLogContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKLogContentCell"];
    SKDemandeLogModel *model = self.tableList[indexPath.row];
    cell.contentTextView.text = model.log;
    cell.timeLab.text = [NSString stringWithFormat:@"创建时间：%@",[model.time substringToIndex:16]];
    cell.backgroundColor = UICOLOR_CLEAR;
//    cell.delegate = self;
    if (self.tableList.count<=1) {
        cell.topLine.hidden = YES;
        cell.bottomLine.hidden = YES;
    }
    else if (indexPath.row==0) {
        cell.topLine.hidden = YES;
        cell.bottomLine.hidden = NO;
    }
    else if (indexPath.row == self.tableList.count-1) {
        cell.topLine.hidden = NO;
        cell.bottomLine.hidden = YES;
    }
    else {
        cell.topLine.hidden = NO;
        cell.bottomLine.hidden = NO;
    }
    return  cell;
    
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
