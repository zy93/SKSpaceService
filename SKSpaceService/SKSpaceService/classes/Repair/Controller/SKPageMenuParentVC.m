//
//  SKPageMenuParentVC.m
//  SKSpaceService
//
//  Created by wangxiaodong on 2018/1/25.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKPageMenuParentVC.h"
#import "SKMyVC.h"

@interface SKPageMenuParentVC ()<XXPageTabViewDelegate,UINavigationControllerDelegate>

@end

@implementation SKPageMenuParentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNaviRightItemWithImage:[UIImage imageNamed:@"top_my"]];
    [self setpageMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setpageMenu{
    [self makeVC];
    NSArray<__kindof UIViewController *> *controllers = [self createViewControllers];
    self.pageTabView = [[XXPageTabView alloc] initWithChildControllers:controllers childTitles:[self createTitles]];
    [self.pageTabView addIndicatorViewWithStyle];
    [self.pageTabView layoutSubviews];
    self.pageTabView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.pageTabView.delegate = self;
    self.pageTabView.titleStyle = XXPageTabTitleStyleDefault;
    self.pageTabView.indicatorStyle = XXPageTabIndicatorStyleDefault;
    self.pageTabView.indicatorWidth = 20;
    [self.view addSubview:self.pageTabView];
}

-(void)rightItemAction
{
    SKMyVC *vc = [[SKMyVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(UIViewController *)makeVC {
    UIViewController *basevc = [[UIViewController alloc]init];
    return basevc;
}

-(NSArray *)createTitles{
    return [[NSArray alloc]init];
}
-(NSArray<__kindof UIViewController *> *)createViewControllers{
    return [[NSArray alloc]init];
}
#pragma mark - XXPageTabViewDelegate
- (void)pageTabViewDidEndChange {
    NSLog(@"#####%d", (int)self.pageTabView.selectedTabIndex);
    if (self.pageTabView.selectedTabIndex == 0) {
        [WOTSingtleton shared].orderType = ORDER_TYPE_ACCEPTABLEORDER;
    }
    
    if (self.pageTabView.selectedTabIndex == 1) {
        [WOTSingtleton shared].orderType = ORDER_TYPE_ACCEPTEDORDER;
    }
    
    if (self.pageTabView.selectedTabIndex == 2) {
        [WOTSingtleton shared].orderType = ORDER_TYPE_SERVICINGORDER;
    }
    
    if (self.pageTabView.selectedTabIndex == 3) {
        [WOTSingtleton shared].orderType = ORDER_TYPE_FINISHEDORDER;
    }
    
}

#pragma mark - Event response
- (void)scrollToLast:(id)sender {
    [self.pageTabView setSelectedTabIndexWithAnimation:self.pageTabView.selectedTabIndex-1];
}

- (void)scrollToNext:(id)sender {
    [self.pageTabView setSelectedTabIndexWithAnimation:self.pageTabView.selectedTabIndex+1];
}

- (void)refreshPageTabView:(id)sender {
    //移除原有子控制器
    for(UIViewController *vc in self.childViewControllers) {
        [vc removeFromParentViewController];
    }
    
    UIViewController *test1 = [self makeVC];
    UIViewController *test2 = [self makeVC];
    UIViewController *test3 = [self makeVC];
    UIViewController *test4 = [self makeVC];
    UIViewController *test5 = [self makeVC];
    
    [self addChildViewController:test1];
    [self addChildViewController:test2];
    [self addChildViewController:test3];
    [self addChildViewController:test4];
    [self addChildViewController:test5];
    
    [self.pageTabView reloadChildControllers:self.childViewControllers childTitles:@[@"全部", @"待支付", @"待使用", @"已完成", @"已取消"]];
}

@end
