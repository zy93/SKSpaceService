//
//  SKOrderInfoVC.m
//  SKSpaceService
//
//  Created by wangxiaodong on 2018/1/29.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKOrderInfoVC.h"
#import "SKUserOrderInfoView.h"
#import "DetailImageInfoView.h"
#import "ButtonView.h"
#import "TZTestCell.h"

#import "TZImagePickerController.h"
#import "TZTestCell.h"
#import "TZImageManager.h"
#import <Photos/Photos.h>
#import "NSArray+ImageArray.h"
#import "MBProgressHUD+Extension.h"

@interface SKOrderInfoVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,TZImagePickerControllerDelegate>
@property(nonatomic,strong)NSMutableArray *userImageArray;
@property(nonatomic,strong)NSMutableArray *servicingImageArray;
@property(nonatomic,strong)NSMutableArray *finishedImageArray;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)SKUserOrderInfoView *userOrderInfoView;
@property(nonatomic,strong)DetailImageInfoView *servicingImageInfoView;
@property(nonatomic,strong)DetailImageInfoView *finishedImageInfoView;
@property(nonatomic,strong)ButtonView *bottomButtonView;
@property(nonatomic,strong)UIView *constView;
@property(nonatomic,strong)UIView *addImageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(strong, nonatomic)UICollectionView *collectionView;
@property(strong, nonatomic)UICollectionViewFlowLayout *layout;
@property(nonatomic,strong)NSMutableArray *selectedPhotos;
@property(nonatomic,strong)NSMutableArray *selectedAssets;
@property(nonatomic,assign)int bottomButtomHeight;
@property(nonatomic,assign)int servicingImageInfoHeight;
@property(nonatomic,assign)int finishedImageInfoHeight;
@property(nonatomic,assign)int addImageHeight;

@end

@implementation SKOrderInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"报修详情";
    if ([WOTSingtleton shared].orderType == ORDER_TYPE_ACCEPTEDORDER) {
        self.userImageArray = [NSArray imageArrayWithString:self.orderInfoModel.pictureOne];
//        self.servicingImageArray = [NSArray imageArrayWithString:self.orderInfoModel.pictureTwo];
//        self.finishedImageArray = [NSArray imageArrayWithString:self.orderInfoModel.pictureThree];
    }else if ([WOTSingtleton shared].orderType == ORDER_TYPE_SERVICINGORDER)
    {
        self.userImageArray = [NSArray imageArrayWithString:self.orderInfoModel.pictureOne];
        self.servicingImageArray = [NSArray imageArrayWithString:self.orderInfoModel.pictureTwo];
        //self.finishedImageArray = [NSArray imageArrayWithString:self.orderInfoModel.pictureThree];
    }else
    {
        self.userImageArray = [NSArray imageArrayWithString:self.orderInfoModel.pictureOne];
        self.servicingImageArray = [NSArray imageArrayWithString:self.orderInfoModel.pictureTwo];
        self.finishedImageArray = [NSArray imageArrayWithString:self.orderInfoModel.pictureThree];
    }
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.userOrderInfoView];
    [self.scrollView addSubview:self.servicingImageInfoView];
    [self.scrollView addSubview:self.finishedImageInfoView];
    [self.scrollView addSubview:self.bottomButtonView];
    [self.scrollView addSubview:self.addImageView];
    [self.addImageView addSubview:self.titleLabel];
    [self.addImageView addSubview:self.collectionView];
    [self.collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    [self.bottomButtonView.disposeButton addTarget:self action:@selector(startService) forControlEvents:UIControlEventTouchDown];
    [self isShow];
    [self layoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)isShow
{
    
    if ([WOTSingtleton shared].orderType == ORDER_TYPE_ACCEPTEDORDER) {
        self.servicingImageInfoView.hidden = YES;
        self.finishedImageInfoView.hidden = YES;
        self.servicingImageInfoHeight = 0;
        self.finishedImageInfoHeight = 0;
        return;
        
    }
    
    if ([WOTSingtleton shared].orderType == ORDER_TYPE_SERVICINGORDER) {
        self.finishedImageInfoView.hidden = YES;
        self.finishedImageInfoHeight = 0;
        return;
    }
    
    if ([WOTSingtleton shared].orderType == ORDER_TYPE_FINISHEDORDER) {
        self.bottomButtonView.hidden = YES;
        self.bottomButtomHeight = 0;
        self.addImageView.hidden = YES;
        self.addImageHeight = 0;
        return;
    }
    
    
}

-(void)layoutSubviews
{
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomButtonView.mas_bottom).with.offset(10);
    }];
    
    [self.userOrderInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView).with.offset(15);
        make.left.equalTo(self.scrollView).with.offset(15);
        make.right.equalTo(self.scrollView).with.offset(-15);
        make.height.mas_offset(270);
    }];
    
    [self.servicingImageInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userOrderInfoView.mas_bottom).with.offset(15);
        make.left.equalTo(self.scrollView).with.offset(15);
        make.right.equalTo(self.scrollView).with.offset(-15);
        make.height.mas_offset(120*self.servicingImageInfoHeight);
    }];
    
    [self.finishedImageInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.servicingImageInfoView.mas_bottom).with.offset(15);
        make.left.equalTo(self.scrollView).with.offset(15);
        make.right.equalTo(self.scrollView).with.offset(-15);
        make.height.mas_offset(120*self.finishedImageInfoHeight);
    }];
    
    [self.addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.finishedImageInfoView.mas_bottom).with.offset(15);
        make.left.equalTo(self.scrollView).with.offset(15);
        make.right.equalTo(self.scrollView).with.offset(-15);
        make.height.mas_offset(120*self.addImageHeight);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addImageView).with.offset(5);
        make.left.equalTo(self.addImageView).with.offset(20);
        make.right.equalTo(self.addImageView).with.offset(-10);
        make.height.mas_offset(20);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.left.equalTo(self.addImageView).with.offset(20);
        make.right.equalTo(self.addImageView).with.offset(-10);
        make.bottom.equalTo(self.addImageView);
    }];
    
    [self.bottomButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addImageView.mas_bottom).with.offset(5);
        make.left.equalTo(self.scrollView.mas_left).with.offset(10);
        make.right.equalTo(self.scrollView.mas_right).with.offset(-10);
        make.centerX.equalTo(self.scrollView);
        make.height.mas_offset(48*self.bottomButtomHeight);
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"addImage"];
        cell.deleteBtn.hidden = YES;
        cell.gifLable.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.asset = self.selectedAssets[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    cell.imageView.contentMode = UIViewContentModeScaleToFill;
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(75, 75);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count) {
        BOOL showSheet = YES;
        if (showSheet) {
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择", nil];
            [sheet showInView:self.view];
        } else {
            [self pushTZImagePickerController];
        }
    }

}

#pragma mark - TZImagePickerController
- (void)pushTZImagePickerController {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 columnNumber:3 delegate:self pushPhotoPickerVc:YES];
    //imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
   
        // 1.设置目前已经选中的图片数组
    imagePickerVc.selectedAssets = self.selectedAssets; // 目前已经选中的图片数组
    
    //imagePickerVc.allowTakePicture = self.showTakePhotoBtnSwitch.isOn;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) { // take photo / 去拍照
        [self takePhoto];
    } else if (buttonIndex == 1) {
        [self pushTZImagePickerController];
    }
}

#pragma mark - UIImagePickerController
- (void)takePhoto {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    //判断是否可以打开照相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else
    {
        [MBProgressHUDUtil showMessage:@"摄像头不可用" toView:self.view];
    }
}

- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
}
- (void)imagePickerController:(UIImagePickerController *)aPicker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [aPicker dismissViewControllerAnimated:YES completion:nil];
    __block UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    PHFetchOptions*options = [[PHFetchOptions alloc]init];
    options.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"creationDate"ascending:NO]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    [self.selectedPhotos addObject:image];
    [self.selectedAssets addObject:[assetsFetchResults firstObject]];
    [self viewDidLayoutSubviews];
    [_collectionView reloadData];
    
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    [self viewDidLayoutSubviews];
    [_collectionView reloadData];
    if (iOS8Later) {
        for (PHAsset *phAsset in assets) {
            NSLog(@"location:%@",phAsset.location);
        }
    }
}

//图片删除方法
- (void)deleteBtnClik:(UIButton *)sender {
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_collectionView reloadData];
    }];
}

#pragma mark - 处理订单接口
-(void)startService
{
    if (self.selectedPhotos.count == 0) {
        [MBProgressHUDUtil showMessage:@"请选择图片" toView:self.view];
        return;
    }
    if ([WOTSingtleton shared].orderType == ORDER_TYPE_ACCEPTEDORDER) {
        [MBProgressHUDUtil showLoadingWithMessage:@"" toView:self.view whileExcusingBlock:^(MBProgressHUD *hud) {
            [WOTHTTPNetwork startServiceWithInfoId:self.orderInfoModel.infoId imageArray:self.selectedPhotos success:^(id bean) {
                
                [hud setHidden: YES];
                [MBProgressHUDUtil showMessage:SubmitReminding toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
                
            } fail:^(NSInteger errorCode, NSString *errorMessage) {
                [MBProgressHUDUtil showMessage:@"处理失败！" toView:self.view];
            }];
        }];
        
    }
    
    if ([WOTSingtleton shared].orderType == ORDER_TYPE_SERVICINGORDER) {
        [MBProgressHUDUtil showLoadingWithMessage:@"" toView:self.view whileExcusingBlock:^(MBProgressHUD *hud) {
            [WOTHTTPNetwork serviceFinishWithInfoId:self.orderInfoModel.infoId imageArray:self.selectedPhotos success:^(id bean) {
                [hud setHidden: YES];
                [MBProgressHUDUtil showMessage:SubmitReminding toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            } fail:^(NSInteger errorCode, NSString *errorMessage) {
                [MBProgressHUDUtil showMessage:@"处理失败！" toView:self.view];
            }];
        }];
    }
}

-(UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}


-(SKUserOrderInfoView *)userOrderInfoView
{
    if (_userOrderInfoView == nil) {
        _userOrderInfoView = [[SKUserOrderInfoView alloc] init];
        _userOrderInfoView.userInteractionEnabled = YES;
        _userOrderInfoView.backgroundColor = [UIColor whiteColor];
        _userOrderInfoView.layer.shadowOpacity = 0.5;// 阴影透明度
        _userOrderInfoView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        _userOrderInfoView.layer.shadowRadius = 3;// 阴影扩散的范围控制
        _userOrderInfoView.layer.shadowOffset = CGSizeMake(1, 1);// 阴影的范围
        _userOrderInfoView.serviceAddressInfoLabel.text = self.orderInfoModel.address;
        _userOrderInfoView.serviceArticleInfoLabel.text = self.orderInfoModel.type;
        _userOrderInfoView.serviceCauseInfoLabel.text = self.orderInfoModel.info;
        _userOrderInfoView.serviceTimeInfoLabel.text = self.orderInfoModel.sorderTime;
        //[_userOrderInfoView setImageDataArray:self.userImageArray];
        _userOrderInfoView.imageUrlArray = self.userImageArray;
    }
    return _userOrderInfoView;
}

-(DetailImageInfoView *)servicingImageInfoView
{
    if (_servicingImageInfoView == nil) {
        _servicingImageInfoView = [[DetailImageInfoView alloc] init];
        _servicingImageInfoView.backgroundColor = [UIColor whiteColor];
        _servicingImageInfoView.layer.shadowOpacity = 0.5;// 阴影透明度
        _servicingImageInfoView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        _servicingImageInfoView.layer.shadowRadius = 3;// 阴影扩散的范围控制
        _servicingImageInfoView.layer.shadowOffset = CGSizeMake(1, 1);// 阴影的范围
        _servicingImageInfoView.titleString = @"维修中图片";
        self.servicingImageInfoHeight = 1;
        //[_servicingImageInfoView setimageArray:self.servicingImageArray];
        _servicingImageInfoView.imageUrlStrArray = self.servicingImageArray;
    }
    return _servicingImageInfoView;
}

-(DetailImageInfoView *)finishedImageInfoView
{
    if (_finishedImageInfoView == nil) {
        _finishedImageInfoView = [[DetailImageInfoView alloc] init];
        _finishedImageInfoView.backgroundColor = [UIColor whiteColor];
        _finishedImageInfoView.layer.shadowOpacity = 0.5;// 阴影透明度
        _finishedImageInfoView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        _finishedImageInfoView.layer.shadowRadius = 3;// 阴影扩散的范围控制
        _finishedImageInfoView.layer.shadowOffset = CGSizeMake(1, 1);// 阴影的范围
        _finishedImageInfoView.titleString = @"维修完成图片";
        self.finishedImageInfoHeight = 1;

        _finishedImageInfoView.imageUrlStrArray = self.finishedImageArray;
    }
    return _finishedImageInfoView;
}

-(ButtonView *)bottomButtonView
{
    if (_bottomButtonView == nil) {
        _bottomButtonView = [[ButtonView alloc] init];
        _bottomButtonView.buttonTitleStr = self.titleStr;
        self.bottomButtomHeight = 1;
    }
    return _bottomButtonView;
}

-(NSMutableArray *)userImageArray
{
    if (_userImageArray == nil) {
        _userImageArray = [[NSMutableArray alloc] init];
    }
    return _userImageArray;
}

-(UIView *)addImageView
{
    if (_addImageView == nil) {
        _addImageView = [[UIView alloc] init];
        _addImageView.backgroundColor = [UIColor whiteColor];
        _addImageView.layer.shadowOpacity = 0.5;// 阴影透明度
        _addImageView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        _addImageView.layer.shadowRadius = 3;// 阴影扩散的范围控制
        _addImageView.layer.shadowOffset = CGSizeMake(1, 1);// 阴影的范围
        self.addImageHeight = 1;
    }
    return _addImageView;
}

-(UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"上传图片";
    }
    return _titleLabel;
}

-(UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

-(NSMutableArray *)selectedPhotos
{
    if (_selectedPhotos == nil) {
        _selectedPhotos = [[NSMutableArray alloc] init];
    }
    return _selectedPhotos;
}

-(NSMutableArray *)selectedAssets
{
    if (_selectedAssets == nil) {
        _selectedAssets = [[NSMutableArray alloc] init];
    }
    return _selectedAssets;
}

-(NSMutableArray *)servicingImageArray
{
    if (_servicingImageArray == nil) {
        _servicingImageArray = [[NSMutableArray alloc] init];
    }
    return _servicingImageArray;
}

-(NSMutableArray *)finishedImageArray
{
    if (_finishedImageArray == nil) {
        _finishedImageArray = [[NSMutableArray alloc] init];
    }
    return _finishedImageArray;
}

@end
