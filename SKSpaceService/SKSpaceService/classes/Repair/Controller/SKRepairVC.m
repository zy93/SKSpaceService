//
//  SKRepairVC.m
//  SKSpaceService
//
//  Created by wangxiaodong on 2018/1/25.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKRepairVC.h"

@interface SKRepairVC ()<XXPageTabViewDelegate>

@end

@implementation SKRepairVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"主页";
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
//    [self.view addSubview:nav.view];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setpageMenu{
    NSArray<__kindof UIViewController *> *controllers = [self createViewControllers];
    self.pageTabView = [[XXPageTabView alloc] initWithChildControllers:controllers childTitles:[self createTitles]];
    self.pageTabView.bottomOffLine = YES;
    self.pageTabView.selectedColor = UICOLOR_MAIN_ORANGE;
    [self.pageTabView addIndicatorViewWithStyle];
    [self.pageTabView layoutSubviews];
    self.pageTabView.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-60);
    NSLog(@"ok:%f",self.view.frame.size.height-60);
    self.pageTabView.delegate = self;
    self.pageTabView.titleStyle = XXPageTabTitleStyleDefault;
    self.pageTabView.indicatorStyle = XXPageTabIndicatorStyleDefault;
    self.pageTabView.indicatorWidth = 20;
    
    [self.view addSubview:self.pageTabView];
}

-(NSArray *)createTitles{
    return [[NSArray alloc]initWithObjects:@"可接订单",@"已接订单",@"维修中",@"已完成",nil];
}
-(NSArray<__kindof UIViewController *> *)createViewControllers{
    UIViewController *VC1 = [[UIViewController alloc] init];
    [self addChildViewController:VC1];
    
    UIViewController *VC2 = [[UIViewController alloc] init];
    [self addChildViewController:VC2];
    
    UIViewController *VC3 = [[UIViewController alloc] init];
    [self addChildViewController:VC3];
    
    UIViewController *VC4 = [[UIViewController alloc] init];
    [self addChildViewController:VC4];
//    WOTNearCirclesVC *circle = [[UIStoryboard storyboardWithName:@"Socialcontact" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTNearCirclesVCID"];
//    [self addChildViewController:circle];
//
//    SKFocusListViewController *circle1 = [[SKFocusListViewController alloc]init];
//    circle1.view.backgroundColor = UICOLOR_WHITE;
//    [self addChildViewController:circle1];
//
//    SKCommentViewController *circle2 = [[SKCommentViewController alloc]init];
//    circle2.view.backgroundColor = UICOLOR_WHITE;
//    [self addChildViewController:circle2];
    
    
    return self.childViewControllers;
}

@end
