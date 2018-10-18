//
//  SKAllReserveOrderVC.m
//  SKSpaceService
//
//  Created by wangxiaodong on 18/10/2018.
//  Copyright © 2018 张雨. All rights reserved.
//

#import "SKAllReserveOrderVC.h"
#import "SKOperationmanageViewController.h"
#import "XXPageTabView.h"
#import "XXPageTabItemLable.h"
#import "SKMyVC.h"
@interface SKAllReserveOrderVC ()<XXPageTabViewDelegate>
@property (nonatomic,strong)XXPageTabView *pageTabView;
@end

@implementation SKAllReserveOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"预定信息";
    [self configNaviRightItemWithImage:[UIImage imageNamed:@"top_my"]];
    SKOperationmanageViewController *vc1 = [[SKOperationmanageViewController alloc]init];
    vc1.orderlisttype = WOTPageMenuVCTypeStation;
    [self addChildViewController:vc1];
    
    SKOperationmanageViewController *vc2 = [[SKOperationmanageViewController alloc]init];
    vc2.orderlisttype = WOTPageMenuVCTypeMeeting;
    [self addChildViewController:vc2];
    
    SKOperationmanageViewController *vc3 = [[SKOperationmanageViewController alloc]init];
    vc3.orderlisttype = WOTPageMenuVCTypeLongTimeStation;
    [self addChildViewController:vc3];
    
    self.pageTabView = [[XXPageTabView alloc] initWithChildControllers:self.childViewControllers childTitles:@[@"工位",@"会议室",@"长租工位"]];
    self.pageTabView.delegate = self;
    self.pageTabView.bottomOffLine = YES;
    self.pageTabView.selectedColor = UICOLOR_MAIN_ORANGE;
    [self.pageTabView addIndicatorViewWithStyle];
    [self.pageTabView layoutSubviews];
    self.pageTabView.titleStyle = XXPageTabTitleStyleDefault;
    self.pageTabView.indicatorStyle = XXPageTabIndicatorStyleDefault;
    self.pageTabView.indicatorWidth = 20;
    [self.view addSubview:self.pageTabView];
    
    [self.pageTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.equalTo(self.view.mas_top);
        }
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)pageTabViewDidEndChange {
    
}

-(void)rightItemAction
{
    SKMyVC *vc = [[SKMyVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
