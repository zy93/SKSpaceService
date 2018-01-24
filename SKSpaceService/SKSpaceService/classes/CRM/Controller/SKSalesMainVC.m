//
//  SKSalesMainVC.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/24.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKSalesMainVC.h"

@interface SKSalesMainVC ()
@property (nonatomic, strong) UIImageView *topBGIV;
@end

@implementation SKSalesMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.topBGIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 1125, 200)];
    self.topBGIV.backgroundColor = UICOLOR_MAIN_ORANGE;
    [self.view addSubview:self.topBGIV];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)createTitles{
    return [[NSArray alloc]initWithObjects:@"工位订单",@"会议室订单",@"场地订单", nil];
}


-(NSArray<__kindof UIViewController *> *)createViewControllers{
    UIViewController *vc1 = [[UIViewController alloc]init];
    UIViewController *vc2 = [[UIViewController alloc]init];
    UIViewController *vc3 = [[UIViewController alloc]init];

    
    [self addChildViewController:vc1];
    [self addChildViewController:vc2];
    [self addChildViewController:vc3];
    return self.childViewControllers;
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
