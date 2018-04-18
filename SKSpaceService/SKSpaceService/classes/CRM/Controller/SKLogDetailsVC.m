//
//  SKLogDetailsVC.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/26.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKLogDetailsVC.h"
#import "SKLogContentCell.h"
#import "SKTextViewVC.h"
#import "WOTSelectWorkspaceListVC.h"
#import "SKSalesMainVC.h"
#import "SKSelectTypeVC.h"
#import "SKSalesOrderLogModel.h"

@interface SKLogDetailsVC () <UITableViewDelegate, UITableViewDataSource, SKLogContentCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableList;


@end

@implementation SKLogDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"日志详情";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"SKLogContentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SKLogContentCell"];

    [self setupViews];
    [self loadData];
    [self AddRefreshHeader];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self StartRefresh];
}

-(void)setupViews
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.bottom.mas_offset(0);
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

-(void)loadData
{
    NSArray *baseList = @[@"客户姓名：", @"电话号码：", @"订单进度：", @"公司名称", @"意向空间：", @"客户来源：", @"具体来源：", @"创建时间：", @"客户意向："];
    self.tableList = [NSMutableArray new];
    [self.tableList addObject:baseList];
}

#pragma mark - request
-(void)createRequest
{
    [WOTHTTPNetwork getSalesOrderLogWithSellId:self.model.sellId success:^(id bean) {
        SKSalesOrderLog_msg *model = bean;
        if (self.tableList.count>=2) {
            [self.tableList removeLastObject];
        }
        [self.tableList addObject:model.msg.list];
        [self.tableView reloadData];
        [self StopRefresh];
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [self StopRefresh];
        if (errorCode == 202) {
            //无数据，补充一个空数据吧！
            [self.tableList addObject:@[]];
            [self.tableView reloadData];
        }
        else
        [MBProgressHUDUtil showMessage:errorMessage toView:self.view];
    }];
}

#pragma mark - action
-(void)addLogBtnClick:(UIButton *)sender
{
    SKTextViewVC *vc = [[SKTextViewVC alloc] init];
    vc.type = SKTextViewVCTYPE_EDIT_LOG;
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - cell delegate
-(void)logContentCell:(SKLogContentCell *)cell addBtnClick:(id)sender
{
    SKTextViewVC *vc = [[SKTextViewVC alloc] init];
    vc.type = SKTextViewVCTYPE_EDIT_LOG;
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - table delegate & dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.tableList[section];
    return arr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 45;
    }
    else {
        NSArray *arr = self.tableList[indexPath.section];
        SKSalesOrderLogModel *model = arr[indexPath.row];
        CGFloat h = [model.content heightWithFont:[UIFont systemFontOfSize:15.f] maxWidth:(SCREEN_WIDTH-60)];
        return h+90;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 33;
    }
    return 7;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return section==1? 45: 7;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UILabel *lb = [[UILabel alloc] init];
        lb.backgroundColor = UICOLOR_WHITE;
        lb.text = @"   日志";
        return lb;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"添加日志" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addLogBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn.layer setCornerRadius:5.f];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
        [btn setBackgroundColor:UICOLOR_MAIN_ORANGE];
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(35);
            make.width.mas_equalTo(100);
            make.centerY.equalTo(view.mas_centerY);
        }];
        return view;
    }
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (cell==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = UICOLOR_MAIN_LINE;
            [cell addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(15);
                make.bottom.mas_offset(0);
                make.right.mas_offset(0);
                make.height.mas_offset(1);
            }];
        }
        //数据value
        NSArray *detailList = @[self.model.clientName, self.model.tel, self.model.stage, self.model.companyName, self.model.spaceName, self.model.source, self.model.specificSource, self.model.createTime];
        NSArray *arr = self.tableList[indexPath.section];
        cell.textLabel.text =arr[indexPath.row];
        if (indexPath.row == ((NSArray *)self.tableList[indexPath.section]).count-1) {
            [self setStarWithCell:cell state:self.model.will];
        }
        else {
            cell.detailTextLabel.text = detailList[indexPath.row];
        }
        return  cell;
    }
    else {
        SKLogContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKLogContentCell"];
        NSArray *arr = self.tableList[indexPath.section];
        SKSalesOrderLogModel *model = arr[indexPath.row];
        cell.contentTextView.text = model.content;
        cell.timeLab.text = [NSString stringWithFormat:@"创建时间：%@",[model.time substringToIndex:16]];
        cell.delegate = self;
        if (arr.count<=1) {
            cell.topLine.hidden = YES;
            cell.bottomLine.hidden = YES;
        }
        else if (indexPath.row==0) {
            cell.topLine.hidden = YES;
            cell.bottomLine.hidden = NO;
        }
        else if (indexPath.row == arr.count-1) {
            cell.topLine.hidden = NO;
            cell.bottomLine.hidden = YES;
        }
        else {
            cell.topLine.hidden = NO;
            cell.bottomLine.hidden = NO;
        }
        return  cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
         if (indexPath.row==2) {
            //订单进度
             __weak typeof(self) weakSelf = self;
             SKSelectTypeVC *vc = [[SKSelectTypeVC alloc] init];
             vc.tableList = [SalesOrderStateList subarrayWithRange:NSMakeRange(1, SalesOrderStateList.count-3)];
             vc.model = self.model;
             vc.type = SKSelectTypeVCTYPE_ORDER_STATE;
             [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row==4) {
            //选择空间
            WOTSelectWorkspaceListVC *vc = [[WOTSelectWorkspaceListVC alloc] init];
            vc.isChangeSpace = YES;
            vc.model = self.model;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row==5) {
            //客户来源
            __weak typeof(self) weakSelf = self;
            SKSelectTypeVC *vc = [[SKSelectTypeVC alloc] init];
            vc.tableList = SalesClientSource;
            vc.model = self.model;
            vc.type = SKSelectTypeVCTYPE_CLIENT_SOURCE;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row==7) {
            //创建时间
        }
        else if (indexPath.row==8) {
            //客户意向
        }
        else {
            SKTextViewVC *vc = [[SKTextViewVC alloc] init];
            if (indexPath.row==0) {
                vc.type = SKTextViewVCTYPE_EDIT_CLIENT_NAME;
            } else if (indexPath.row==1) {
                vc.type = SKTextViewVCTYPE_EDIT_CLIENT_TEL;
            } else if (indexPath.row==3) {
                vc.type = SKTextViewVCTYPE_EDIT_CLIENT_COMPANY;
            } else if (indexPath.row==6) {
                vc.type = SKTextViewVCTYPE_EDIT_CLIENT_SPECIFIC_SOURCE;
            }
            vc.model = self.model;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
}

#pragma mark - other
-(void)setStarWithCell:(UITableViewCell *)cell state:(NSString *)state
{
    UIButton *btn1 = [self createStarButtonWithTag:1001];
    UIButton *btn2 = [self createStarButtonWithTag:1002];
    UIButton *btn3 = [self createStarButtonWithTag:1003];
    UIButton *btn4 = [self createStarButtonWithTag:1004];
    if ([state isEqualToString:SalesOrderIntentionList[0]]) {
        btn1.selected = YES;
        btn2.selected = NO;
        btn3.selected = NO;
        btn4.selected = NO;
    }
    else if ([state isEqualToString:SalesOrderIntentionList[1]]) {
        btn1.selected = YES;
        btn2.selected = YES;
        btn3.selected = NO;
        btn4.selected = NO;
    }
    else if ([state isEqualToString:SalesOrderIntentionList[2]]) {
        btn1.selected = YES;
        btn2.selected = YES;
        btn3.selected = YES;
        btn4.selected = NO;
    }
    else if ([state isEqualToString:SalesOrderIntentionList[3]]) {
        btn1.selected = YES;
        btn2.selected = YES;
        btn3.selected = YES;
        btn4.selected = YES;
    }
    else
    {
        btn1.selected = NO;
        btn2.selected = NO;
        btn3.selected = NO;
        btn4.selected = NO;
    }
    
    [cell addSubview:btn1];
    [cell addSubview:btn2];
    [cell addSubview:btn3];
    [cell addSubview:btn4];
    
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-35*[WOTUitls GetLengthAdaptRate]);
        make.centerY.equalTo(cell.mas_centerY);
    }];
    
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btn4.mas_left).offset(-2);
        make.centerY.equalTo(cell.mas_centerY);
    }];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btn3.mas_left).offset(-2);
        make.centerY.equalTo(cell.mas_centerY);
    }];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btn2.mas_left).offset(-2);
        make.centerY.equalTo(cell.mas_centerY);
    }];
}

-(UIButton *)createStarButtonWithTag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"star_small_gray"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"star_small_yellow"] forState:UIControlStateSelected];
    button.tag = tag;
    return button;
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
