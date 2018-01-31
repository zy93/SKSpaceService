//
//  SKMyCollectionReusableView.m
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/31.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "SKMyCollectionReusableView.h"
#import "UIImage+Blur.h"

@implementation SKMyCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIImage *image = [UIImage imageNamed:@"default_header"];
    image = [image blurWithDegree:1];
    [self.bgIV setImage:image];
}

@end
