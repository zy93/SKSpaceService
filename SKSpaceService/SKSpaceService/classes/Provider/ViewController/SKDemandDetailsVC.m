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

@interface SKDemandDetailsVC () <SKDemandeCellDelegate>

@end

@implementation SKDemandDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.view.backgroundColor = UICOLOR_MAIN_BACKGROUND;
    self.navigationItem.title = @"需求详情";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"SKLogContentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SKLogContentCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SKDemandeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SKDemandeCell"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - request
-(void)createRequest
{
    
}

#pragma mark - cell delegate
-(void)demandeCell:(SKDemandeCell *)cell buttonClick:(NSIndexPath *)index
{
    NSDictionary *parameters = @{@"demandId":self.model.demandId,
                                 @"dealState":@"处理中",
                                 };
    [WOTHTTPNetwork setDemandWithParams:parameters success:^(id bean) {
        [MBProgressHUDUtil showMessage:@"状态已变更为处理完成！" toView:self.view];
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [MBProgressHUDUtil showMessage:@"修改失败！请稍后再试！" toView:self.view];
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SKDemandeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKDemandeCell"];
    cell.addrValueLab.text = self.model.spaceName;
    cell.nameValueLab.text = self.model.userName;
    cell.telValueLab.text  = self.model.tel;
    cell.demandeValueLab.text= self.model.demandContent;
    cell.createValueLab.text = self.model.putTime;
    cell.delegate = self;
    [cell.btn setTitle:@"完成" forState:UIControlStateNormal];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 180;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKLogContentCell" forIndexPath:indexPath];
    
    
    
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
