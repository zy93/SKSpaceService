//
//  SKSelectTypeVC.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/25.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKSelectTypeVC.h"

@interface SKSelectTypeVC ()
@property (nonatomic, strong) NSDictionary * params;
@property (nonatomic, strong) NSIndexPath  * index;
@end

@implementation SKSelectTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"选择类型";
    if (self.type != SKSelectTypeVCTYPE_SELECT) {
        [self configNaviRightItemWithTitle:@"保存" textColor:UICOLOR_MAIN_ORANGE];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
-(void)rightItemAction
{
    if (!self.params) {
        [MBProgressHUDUtil showMessage:@"请选择类型！" toView:self.view];
        return;
    }
    
    [WOTHTTPNetwork updateSalesOrderInfoWithParam:self.params success:^(id bean) {
        [MBProgressHUD showMessage:@"修改成功！" toView:self.view hide:YES afterDelay:0.8f complete:^{
            if (self.type == SKSelectTypeVCTYPE_ORDER_STATE) {
                self.model.stage = self.params[@"stage"];
            }
            else {
                self.model.source = self.params[@"source"];
            }
            [WOTHTTPNetwork sendMessageWithUserId:self.model.userId type:@"预约入驻反馈" summary:@"预约入驻申请已有专人负责，请等待工作人员联系。" success:^(id bean) {
                
            } fail:^(NSInteger errorCode, NSString *errorMessage) {
                
            }];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    // Configure the cell...
    cell.textLabel.text = self.tableList[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.accessoryView = nil;
    if (self.type == SKSelectTypeVCTYPE_SELECT) {
        self.selectSpaceBlock(cell.textLabel.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        
//        if (!(self.index.row == indexPath.row)) {
//            cell = [tableView cellForRowAtIndexPath:self.index];
//            cell.accessoryType = UITableViewCellAccessoryNone;
//            cell.accessoryView = nil;
//        }else
//        {
//             UITableViewCell *celled = [tableView cellForRowAtIndexPath:self.index];
//            celled.accessoryType = UITableViewCellAccessoryNone;
//            celled.accessoryView = nil;
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"select_round_blue"]];
//        }
        UITableViewCell *celled = [tableView  cellForRowAtIndexPath:indexPath];
        celled.accessoryType = UITableViewCellAccessoryCheckmark;
        celled.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"select_round_blue"]];
        
       
        
        if (self.type == SKSelectTypeVCTYPE_ORDER_STATE) {
            self.params = @{@"sellId":self.model.sellId,
                            @"stage":celled.textLabel.text,
                            @"leaderId":[WOTUserSingleton shared].userInfo.staffId
                       };
        }
        else {
            self.params = @{@"sellId":self.model.sellId,
                            @"source":celled.textLabel.text,
                            @"leaderId":[WOTUserSingleton shared].userInfo.staffId
                       };
        }
       self.index = indexPath;
    }
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
