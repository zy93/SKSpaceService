//
//  DetailImageInfoView.m
//  ScrollViewClickDemo
//
//  Created by wangxiaodong on 2017/12/19.
//  Copyright © 2017年 wangxiaodong. All rights reserved.
//

#import "DetailImageInfoView.h"
#import "DetailInfoCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "ClickImageShowArtwork.h"
#import "Masonry.h"

static NSString * const identifier = @"DetailInfoCollectionViewCell";

@interface DetailImageInfoView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSArray *iconArray;

@property (strong,nonatomic)UICollectionView *collectionView;

@property (strong,nonatomic)UILabel *titleLabel;

@end

@implementation DetailImageInfoView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //[self setUpView];
//        [self loadData];
//        [self setUpView];
    }
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [self loadData];
    [self setUpView];
}

-(void)loadData
{
    _iconArray = self.imageUrlStrArray;
}


-(void)setUpView{
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = self.titleString;
    [self addSubview:self.titleLabel];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(75, 75);
    // item距离view的边距
    layout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 20);
    // 最小行间距
    layout.minimumLineSpacing = 20;
    // 最小列间距
    layout.minimumInteritemSpacing = 20;
    // 创建collectionView，绑定layout
    //CGFloat *x =self.bounds.origin.x;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, 100)  collectionViewLayout:layout];
    
    [self.collectionView registerClass:[DetailInfoCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionView];
    [self setCollectionLayout];
}

-(void)setCollectionLayout
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.left.equalTo(self).with.offset(20);
        make.width.equalTo(self);
        make.height.mas_offset(20);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.left.equalTo(self).with.offset(20);
        make.right.equalTo(self).with.offset(-10);
        make.height.equalTo(@80);
    }];
    
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.iconArray.count;
}

#pragma mark - 代理方法
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailInfoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    //[cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.iconArray[indexPath.item]] ];
    [cell.imageView sd_setImageWithURL:self.iconArray[indexPath.item] placeholderImage:[UIImage imageNamed:@"Notloaded"]];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailInfoCollectionViewCell * cell = (DetailInfoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [ClickImageShowArtwork scanBigImageWithImageView:cell.imageView alpha:1];
}

#pragma mark - UICollectionViewDelegateFlowLayoutd
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(75, 75);
}

-(NSArray *)iconArray
{
    if (_iconArray == nil) {
        _iconArray = [[NSArray alloc] init];
    }
    return _iconArray;
}


@end
