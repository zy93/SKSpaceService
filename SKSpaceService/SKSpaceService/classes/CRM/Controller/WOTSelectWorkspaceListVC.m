//
//  WOTWorkspaceListVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/17.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTSelectWorkspaceListVC.h"//1
#import "WOTSpaceModel.h"


@interface WOTSelectWorkspaceListVC () <UITableViewDelegate, UITableViewDataSource>//1
{
    NSIndexPath *selectPath;
    NSDictionary *tableDic;
    NSDictionary *params;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation WOTSelectWorkspaceListVC//1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self config];
    [self createRequest];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)config{
    self.navigationItem.title = @"选择空间";
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

#pragma mark - action
-(void)rightItemAction
{
    
    if (!params) {
        [MBProgressHUDUtil showMessage:@"请选空间！" toView:self.view];
        return;
    }
    
    [WOTHTTPNetwork updateSalesOrderInfoWithParam:params success:^(id bean) {
        [MBProgressHUD showMessage:@"修改成功！" toView:self.view hide:YES afterDelay:0.8f complete:^{
            self.model.spaceId = params[@"spaceId"];
            self.model.spaceName = params[@"spaceName"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [MBProgressHUDUtil showMessage:errorMessage toView:self.view];
    }];
}

#pragma mark - request
-(void)createRequest
{
    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork getSapaceFromGroupBlockSuccess:^(id bean) {
        WOTSpaceModel_msg *spaceMoedel = bean;
        tableDic = [self sortByCity:spaceMoedel.msg.list];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [MBProgressHUDUtil showMessage:errorMessage toView:self.view];
    }];
}

//将返回的数据，按照城市从新组合
-(NSDictionary *)sortByCity:(NSArray *)array
{
    //先看有哪些
    NSMutableArray *cityList = [NSMutableArray new];
    
    for (WOTSpaceModel *model in array) {
        //
        BOOL isHaveCity = NO;
        for (NSString *city in cityList) {
            if ([model.city isEqualToString:city]) {
                isHaveCity = YES;
                break;
            }
        }
        if (!isHaveCity) {
            [cityList addObject:model.city];
        }
        [cityList addObject:model.city];
    }
    
    NSMutableDictionary *resultDic = [NSMutableDictionary new];
    for (NSString *cityKey in cityList) {
        [resultDic setObject:[NSMutableArray new] forKey:cityKey];
    }
    
    for (WOTSpaceModel *model in array) {
        NSMutableArray *arr = resultDic[model.city];
        [arr addObject:model];
        [resultDic setObject:arr forKey:model.city];
    }
    return resultDic;
}


#pragma mark - table delegate & dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return tableDic.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arrKey = [tableDic allKeys];
    NSString *key = arrKey[section];
    NSArray *modelList = tableDic[key];
    return modelList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectSpaceCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectSpaceCell"];
    }
    NSArray *arrKey = [tableDic allKeys];
    NSString *key = arrKey[indexPath.section];
    NSArray *modelList = tableDic[key];
    
    WOTSpaceModel *model = modelList[indexPath.row];
    [cell.textLabel setText:model.spaceName];
    
    return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *arrKey = [tableDic allKeys];
    NSString *key = arrKey[section];
    return key;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_isChangeSpace) {
        UITableViewCell *cell;
        if (selectPath) {
            cell =[tableView cellForRowAtIndexPath:selectPath];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.accessoryView = nil;
        }
        cell =[tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"select_round_blue"]];
        selectPath = indexPath;
        NSArray *arrKey = [tableDic allKeys];
        NSString *key = arrKey[indexPath.section];
        NSArray *modelList = tableDic[key];
        
        WOTSpaceModel *model = modelList[indexPath.row];
        params = @{@"sellId":self.model.sellId,
                   @"spaceId":model.spaceId,
                   @"spaceName":model.spaceName,
                   };
    }
    else {
        NSArray *arrKey = [tableDic allKeys];
        NSString *key = arrKey[indexPath.section];
        NSArray *modelList = tableDic[key];
        
        WOTSpaceModel *model = modelList[indexPath.row];
        if (self.selectSpaceBlock) {
            self.selectSpaceBlock(model);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - other
-(void)setIsChangeSpace:(BOOL)isChangeSpace
{
    _isChangeSpace = isChangeSpace;
    if (isChangeSpace) {
        [self configNaviRightItemWithTitle:@"保存" textColor:UICOLOR_MAIN_ORANGE];
    }
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
