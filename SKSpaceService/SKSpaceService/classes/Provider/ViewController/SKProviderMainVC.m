//
//  SKProviderMainVC.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/2/28.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKProviderMainVC.h"
#import "SKProviderOrderListVC.h"
#import "SKMyVC.h"

@interface SKProviderMainVC ()

@end

@implementation SKProviderMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"服务商支持";
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self configNaviRightItemWithImage:[UIImage imageNamed:@"top_my"]];

    [self.pageTabView addIndicatorViewWithStyle];
    [self.pageTabView layoutSubviews];
    self.pageTabView.titleStyle = XXPageTabTitleStyleDefault;
    self.pageTabView.selectedColor = UICOLOR_MAIN_ORANGE;
    self.pageTabView.bottomOffLine = YES;
    self.pageTabView.indicatorStyle = XXPageTabIndicatorStyleDefault;
    self.pageTabView.indicatorWidth = 40;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)createTitles{
    return @[@"未处理", @"沟通中", @"处理完成"];
}


-(NSArray<__kindof UIViewController *> *)createViewControllers{

    SKProviderOrderListVC *vc = [[SKProviderOrderListVC alloc]init];
    vc.vcType = SKProviderOrderListVCTYPE_UNTREATED;
    [self addChildViewController:vc ];
    SKProviderOrderListVC *vc1 = [[SKProviderOrderListVC alloc]init];
    vc1.vcType = SKProviderOrderListVCTYPE_INTREATED;
    [self addChildViewController:vc1];
    SKProviderOrderListVC *vc2 = [[SKProviderOrderListVC alloc]init];
    vc2.vcType = SKProviderOrderListVCTYPE_TREATED;
    [self addChildViewController:vc2];
    
    return self.childViewControllers;
}

#pragma mark - action
-(void)rightItemAction
{
    SKMyVC *vc = [[SKMyVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
