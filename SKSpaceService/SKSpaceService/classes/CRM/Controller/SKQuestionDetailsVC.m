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

#define str  @"阿asdf家具家居军不阿斯蒂芬莱卡安防会计说；阿"

@interface SKQuestionDetailsVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SKBottomTextView *textView;
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
    self.tableView.backgroundColor = UICOLOR_MAIN_BACKGROUND;
    [self.tableView registerNib:[UINib nibWithNibName:@"SKQuestionSendCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SKQuestionSendCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SKQuestionReplyCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SKQuestionReplyCell"];
    [self.view addSubview:self.tableView];
    
    self.textView = [[SKBottomTextView alloc] init];
    [self.view addSubview:self.textView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(-42);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tableView.mas_bottom).offset(42);
        make.left.mas_offset(0);
        make.right.equalTo(self.tableView.mas_right);
        make.height.mas_offset(52);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [str heightWithFont:[UIFont systemFontOfSize:15.f] maxWidth:(SCREEN_WIDTH-20-35)];
    
    return height+40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SKQuestionDetailsHeader *header = [[SKQuestionDetailsHeader alloc] init];
    header.clientNameLab.text = @"客户姓名：张三";
    header.intentionLab.text = @"意向程度：";
    header.intentionSpaceLab.text = @"意向地点：方圆大厦";
    header.star1Btn.selected = YES;
    header.star2Btn.selected = YES;
    return header;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.row %2 ==0) {
      cell = [tableView dequeueReusableCellWithIdentifier:@"SKQuestionSendCell" forIndexPath:indexPath];
        
        ((SKQuestionSendCell *)cell).contentTextView.text = str;
        //图片拉伸
        UIImage*bubble = [UIImage imageNamed:@"dialogue_right"];
        bubble=[bubble stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        [((SKQuestionSendCell *)cell).bgIV setImage:bubble];
        
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SKQuestionReplyCell" forIndexPath:indexPath];
        ((SKQuestionReplyCell *)cell).contentTextView.text = str;
        //图片拉伸
        UIImage*bubble = [UIImage imageNamed:@"dialogue_left"];
        bubble=[bubble stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        [((SKQuestionReplyCell *)cell).bgIV setImage:bubble];
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
