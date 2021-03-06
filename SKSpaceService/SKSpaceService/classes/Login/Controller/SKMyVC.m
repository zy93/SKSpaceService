//
//  SKMyVC.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/31.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKMyVC.h"
#import "SKMyCell.h"
#import "SKMyCollectionReusableView.h"
#import "AppDelegate.h"
#import "UIDevice+Resolutions.h"
#import "SKSelectIdentityView.h"
#import "CSLoginViewController.h"
#import "JudgmentTime.h"

@interface SKMyVC () < SKSelectIdentityViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIButton * headerBtn;
@property (nonatomic, strong) UILabel * nameLab;
@property (nonatomic, strong) UILabel * telLab;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong)JudgmentTime *jumdgmentTime;
@property (nonatomic, assign)BOOL isShow;

@end

@implementation SKMyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.jumdgmentTime = [[JudgmentTime alloc] init];
    [self judgmentTimeMethod];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat  buff = [[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina58 ? 88: 20;

    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 1; //左右间距
    flowLayout.minimumLineSpacing = 1; //上下间距
    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-4)/3, 90*[WOTUitls GetLengthAdaptRate]); //cell 大小
    flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 280*[WOTUitls GetLengthAdaptRate]+buff);
//    flowLayout.estimatedItemSize = CGSizeMake(SCREEN_HEIGHT/3, 90*[WOTUitls GetLengthAdaptRate]); //估算大小？
//    flowLayout.sectionInset  //cell间内边距
    
    //
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -buff, SCREEN_WIDTH, SCREEN_HEIGHT+buff) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = UICOLOR_MAIN_LINE;
    self.collectionView.delegate= self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
//    self.collectionView.header
//    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.left.mas_equalTo(0);
//        make.bottom.mas_equalTo(0);
//        make.right.mas_equalTo(0);
//    }];
//
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SKMyCell" bundle:nil] forCellWithReuseIdentifier:@"SKMyCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SKMyCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SKMyCollectionReusableView"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self configNaviBackItem];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}


#pragma mark - collection delegate & data source
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    SKMyCollectionReusableView *vi = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SKMyCollectionReusableView" forIndexPath:indexPath];
    vi.titleLab.text = [WOTUserSingleton shared].userInfo.realName;
    vi.subtitleLab.text = [WOTUserSingleton shared].userInfo.tel;
    return vi;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SKMyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SKMyCell" forIndexPath:indexPath];
    if (indexPath.row==0) {
        
    }
    else {
        [cell.iconIV setImage:[UIImage imageNamed:@"logout"]];
        [cell.titleLab setText:@"退出登录"];
    }
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat  buff = [[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina58 ? 88: 20;
    CGFloat height = 280*[WOTUitls GetLengthAdaptRate]+buff;
    return CGSizeMake(320, height);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
//        //跳转登录页
//        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        [appDelegate loadViewController];
        SKSelectIdentityView *select = [[SKSelectIdentityView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, CGRectGetHeight(self.view.frame)) buttonTitles:[[WOTUserSingleton shared] getUserPermissions]];
        select.delegate = self;
        [self.view addSubview:select];
        [select showView];
    }
    else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确认退出？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[WOTUserSingleton shared] userLogout];
            //跳转登录页
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            if (_isShow) {
                [appDelegate loadViewControllerWithName:@"CSLoginViewController"];
            }else
            {
                [appDelegate loadViewControllerWithName:@"LoginViewController"];
            }
            
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];

    }
}


#pragma mark - selectIndentity delegate
-(void)selectIdentityView:(SKSelectIdentityView *)view selectIndentity:(NSString *)indentity
{
    //跳转页面
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate loadViewControllerWithName:permissionVCNameList[indentity]];
    [WOTUserSingleton shared].userInfo.currentPermission = indentity;
}

-(void)judgmentTimeMethod
{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *DateTime = [formatter stringFromDate:date];
    // NSString *aDataTime =@"2017/11/02";
    _isShow = [self.jumdgmentTime compareDate:DateTime withDate:@"2018/5/1"];
    
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
