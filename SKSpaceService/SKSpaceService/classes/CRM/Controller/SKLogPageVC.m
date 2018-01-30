//
//  SKLogPageVC.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/26.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKLogPageVC.h"
#import "SKLogListVC.h"

@interface SKLogPageVC ()

@end

@implementation SKLogPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"回访日志";
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)createTitles{
    return [[NSArray alloc]initWithObjects:@"全部",@"未完成",@"已完成", nil];
}


-(NSArray<__kindof UIViewController *> *)createViewControllers{
    SKLogListVC *vc1 = [[SKLogListVC alloc]init];
    SKLogListVC *vc2 = [[SKLogListVC alloc]init];
    SKLogListVC *vc3 = [[SKLogListVC alloc]init];
    
    
    [self addChildViewController:vc1];
    [self addChildViewController:vc2];
    [self addChildViewController:vc3];
    return self.childViewControllers;
}

-(void)setupViews
{
    [self.pageTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
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
