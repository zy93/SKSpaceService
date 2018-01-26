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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)loadData
{
    NSArray *baseList = @[@"客户姓名：", @"电话号码：", @"公司名称", @"意向空间：", @"客户来源：", @"具体来源：", @"创建时间：", @"客户意向："];
    self.tableList = [NSMutableArray new];
    NSArray *logList = @[@"客户想要一个独立版送死客户想要一个独立版送死客户想要一个独立版送死客户想要一个独立版送死客户想要一个独立版送死",@"萨克雷锋骄傲了时代峻峰可连接阿斯顿离开家"];
    [self.tableList addObject:baseList];
    [self.tableList addObject:logList];
}


#pragma mark - cell delegate
-(void)logContentCell:(SKLogContentCell *)cell addBtnClick:(id)sender
{
    SKTextViewVC *vc = [[SKTextViewVC alloc] init];
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
        NSString *str = arr[indexPath.row];
        CGFloat h = [str heightWithFont:[UIFont systemFontOfSize:15.f] maxWidth:(SCREEN_WIDTH-60)];
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
    return 7;
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
        NSArray *detailList = @[@"张三", @"18812345678", @"初次沟通", @"中介介绍", @"链家王老五介绍", @"2018/01/01", @"3"];
        NSArray *arr = self.tableList[indexPath.section];
        cell.textLabel.text =arr[indexPath.row];
        if (indexPath.row==7) {
            UIButton *btn = [self createStarButtonWithTag:1001];
            [cell addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.offset(-40);
                make.centerY.equalTo(cell.mas_centerY);
            }];
        }
        else {
            cell.detailTextLabel.text = detailList[indexPath.row];
        }
        return  cell;
    }
    else {
        SKLogContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKLogContentCell"];
        NSArray *arr = self.tableList[indexPath.section];
        NSString *str = arr[indexPath.row];
        cell.contentTextView.text = str;
        cell.delegate = self;
        if (indexPath.row==0) {
            cell.topLine.hidden = YES;
            cell.addLogBtn.hidden = YES;
        }
        else if (indexPath.row == arr.count-1) {
            cell.bottomLine.hidden = YES;
            cell.addLogBtn.hidden = NO;
        }
        else {
            cell.topLine.hidden = NO;
            cell.bottomLine.hidden = NO;
            cell.addLogBtn.hidden = YES;
        }
        return  cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==3) {
            //选择空间
            
            WOTSelectWorkspaceListVC *vc = [[WOTSelectWorkspaceListVC alloc] init];
            vc.isChangeSpace = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row==4) {
            //客户来源
        }
        else {
            SKTextViewVC *vc = [[SKTextViewVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
}

#pragma mark - other
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
