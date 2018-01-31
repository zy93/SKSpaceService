//
//  DetailInfoCollectionViewCell.m
//  ScrollViewClickDemo
//
//  Created by wangxiaodong on 2017/12/19.
//  Copyright © 2017年 wangxiaodong. All rights reserved.
//

#import "DetailInfoCollectionViewCell.h"

@interface DetailInfoCollectionViewCell()

@end

@implementation DetailInfoCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _imageView = imageView;
        imageView.frame = self.contentView.bounds;
        [self.contentView addSubview:imageView];
    }
    return self;
}

@end
