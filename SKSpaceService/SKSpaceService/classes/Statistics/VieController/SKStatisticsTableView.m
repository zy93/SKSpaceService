//
//  SKStatisticsTableView.m
//  SKSpaceService
//
//  Created by wangxiaodong on 19/11/2018.
//  Copyright © 2018 张雨. All rights reserved.
//

#import "SKStatisticsTableView.h"
#import "SKPieChartVC.h"
#import "SKBarChartVC.h"
#import "SKLineChartVC.h"
#import "SKMyVC.h"
@interface SKStatisticsTableView ()

@property (nonatomic,copy) NSArray *titlesArray;
@property (nonatomic,copy) NSArray *imagesArray;
@end

@implementation SKStatisticsTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"数据统计";
    [self configNaviRightItemWithImage:[UIImage imageNamed:@"top_my"]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.titlesArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.imagesArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *titleStr = self.titlesArray[indexPath.row];
    if ([titleStr isEqualToString:@"会员人数统计"]||[titleStr isEqualToString:@"订单数量统计"]||[titleStr isEqualToString:@"礼包数量统计"]||[titleStr isEqualToString:@"剩余工位统计"]||[titleStr isEqualToString:@"项目收益"]) {
        SKPieChartVC *pieChartVC = [[SKPieChartVC alloc] init];
        pieChartVC.titleStr = self.titlesArray[indexPath.row];
        [self.navigationController pushViewController:pieChartVC animated:YES];
    }
    
    if ([titleStr isEqualToString:@"空间工位统计"]||[titleStr isEqualToString:@"空间企业统计"]||[titleStr isEqualToString:@"所有空间工位统计"]||[titleStr isEqualToString:@"服务商点击Top10统计"]||[titleStr isEqualToString:@"活动报名统计"]) {
        SKBarChartVC *barChartVC = [[SKBarChartVC alloc] init];
        barChartVC.titleStr = self.titlesArray[indexPath.row];
        [self.navigationController pushViewController:barChartVC animated:YES];
    }
    
    if ([titleStr isEqualToString:@"服务商点击次数统计"]) {
        SKLineChartVC *pieChartVC = [[SKLineChartVC alloc] init];
        [self.navigationController pushViewController:pieChartVC animated:YES];
    }
    
}

-(void)rightItemAction
{
    SKMyVC *vc = [[SKMyVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSArray *)titlesArray
{
    if (!_titlesArray) {
        _titlesArray = @[@"会员人数统计",@"订单数量统计",@"礼包数量统计",@"剩余工位统计",@"空间工位统计",@"项目收益",@"空间企业统计",@"所有空间工位统计",@"服务商点击次数统计",@"服务商点击Top10统计",@"活动报名统计"];
    }
    return _titlesArray;
}

-(NSArray *)imagesArray
{
    if (!_imagesArray) {
        _imagesArray = @[@"statistics1",@"statistics2",@"statistics3",@"statistics4",@"statistics5",@"statistics6",@"statistics7",@"statistics4",@"statistics9",@"statistics10",@"statistics11"];
    }
    return _imagesArray;
}



@end
