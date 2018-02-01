//
//  SKQuestionDetailsVC.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/25.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKQuestionDetailsVC.h"
#import "SKQuestionDetailsHeader.h"
#import "SKQuestionSendCell.h"
#import "SKQuestionReplyCell.h"
#import "SKBottomTextView.h"
#import "SKQuestionModel.h"
#import "SKSalesMainVC.h"

@interface SKQuestionDetailsVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SKBottomTextView *textView;
@property (nonatomic, strong) NSArray *tableList;
@end

@implementation SKQuestionDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.view.backgroundColor = UICOLOR_MAIN_BACKGROUND;
    self.navigationItem.title = @"问题详情";
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator=NO;
    self.tableView.backgroundColor = UICOLOR_MAIN_BACKGROUND;
    [self.tableView registerNib:[UINib nibWithNibName:@"SKQuestionSendCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SKQuestionSendCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SKQuestionReplyCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SKQuestionReplyCell"];
    [self.view addSubview:self.tableView];
    
    __weak typeof(self) weakSelf = self;
    self.textView = [[SKBottomTextView alloc] init];
    self.textView.editingText = ^(NSString *string) {
        NSDictionary *param  =@{@"sellId":weakSelf.model.sellId,
                                @"type":@"用户",
                                @"userId":[WOTUserSingleton shared].userInfo.staffId,
                                @"userName":[WOTUserSingleton shared].userInfo.staffName,
                                @"content":string,
                              };
        [WOTHTTPNetwork addSalesOrderQuestionWithParam:param success:^(id bean) {
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
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.bottom.equalTo(self.textView.mas_top);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.left.mas_offset(0);
        make.right.equalTo(self.tableView.mas_right);
        make.height.mas_offset(52);
    }];
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
    [WOTHTTPNetwork getSalesOrderQuestionWithSellId:self.model.sellId success:^(id bean) {
        SKQuestion_msg *model = bean;
        self.tableList = model.msg.list;
        [self.tableView reloadData];
        [self StopRefresh];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.tableList.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
        });
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [self StopRefresh];
        if (errorCode != 202) {
            [MBProgressHUDUtil showMessage:errorMessage toView:self.view];
        }
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
    SKQuestionModel *model = self.tableList[indexPath.row];
    CGFloat height = [model.content heightWithFont:[UIFont systemFontOfSize:15.f] maxWidth:(SCREEN_WIDTH-20-35)];
    
    return height+40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SKQuestionDetailsHeader *header = [[SKQuestionDetailsHeader alloc] init];
    header.clientNameLab.text = [NSString stringWithFormat:@"客户姓名：%@",self.model.clientName];
    header.intentionLab.text = @"意向程度：";
    header.intentionSpaceLab.text = [NSString stringWithFormat:@"意向地点：%@",self.model.spaceName];
    if ([self.model.will isEqualToString:SalesOrderIntentionList[0]]) {
        header.star1Btn.selected = YES;
        header.star2Btn.selected = NO;
        header.star3Btn.selected = NO;
        header.star4Btn.selected = NO;
    }
    else if ([self.model.will isEqualToString:SalesOrderIntentionList[1]]) {
        header.star1Btn.selected = YES;
        header.star2Btn.selected = YES;
        header.star3Btn.selected = NO;
        header.star4Btn.selected = NO;
    }
    else if ([self.model.will isEqualToString:SalesOrderIntentionList[2]]) {
        header.star1Btn.selected = YES;
        header.star2Btn.selected = YES;
        header.star3Btn.selected = YES;
        header.star4Btn.selected = NO;
    }
    else if ([self.model.will isEqualToString:SalesOrderIntentionList[3]]) {
        header.star1Btn.selected = YES;
        header.star2Btn.selected = YES;
        header.star3Btn.selected = YES;
        header.star4Btn.selected = YES;
    }
    else
    {
        header.star1Btn.selected = NO;
        header.star2Btn.selected = NO;
        header.star3Btn.selected = NO;
        header.star4Btn.selected = NO;
    }
    return header;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    SKQuestionModel *model = self.tableList[indexPath.row];
    if ([model.type isEqualToString:@"管理员"]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SKQuestionReplyCell" forIndexPath:indexPath];
        ((SKQuestionReplyCell *)cell).contentTextView.text = model.content;
        //图片拉伸
        UIImage*bubble = [UIImage imageNamed:@"dialogue_left"];
        bubble=[bubble stretchableImageWithLeftCapWidth:10 topCapHeight:25];
        [((SKQuestionReplyCell *)cell).bgIV setImage:bubble];
        //
        
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SKQuestionSendCell" forIndexPath:indexPath];
        
        ((SKQuestionSendCell *)cell).contentTextView.text = model.content;
        //图片拉伸
        UIImage*bubble = [UIImage imageNamed:@"dialogue_right"];
        bubble=[bubble stretchableImageWithLeftCapWidth:10 topCapHeight:25];
        [((SKQuestionSendCell *)cell).bgIV setImage:bubble];
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
