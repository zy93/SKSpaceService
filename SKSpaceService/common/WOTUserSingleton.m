//
//  WOTUserSingleton.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/12.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTUserSingleton.h"
#import <objc/runtime.h>
static WOTUserSingleton *shareUser;
static dispatch_once_t token;
@implementation WOTUserSingleton

-(id)initSingleton{
    if ((self = [super init])) {
        [self setValues];
    }
    return self;
}


+(instancetype)shared{
    
    dispatch_once(&token, ^{
        shareUser = [[self alloc] initSingleton];
    });
    
    return shareUser;
}

+ (void)destroyInstance {
    shareUser=nil;
    token=0l;
}
-(void)setValues{
    NSDictionary *dic = [self readUserInfoFromPlist];
    NSError *error;
    //刷新逻辑
    if (_userInfo) {
        [self removeObserver:self forKeyPath:@"_userInfo.currentPermission" context:nil];
    }
    _userInfo = [[SKLoginModel alloc] initWithDictionary:dic error:&error];
    if (_userInfo) {
        _login = YES;
        //监听currentStatus，实时保存启动页面
        [self addObserver:self forKeyPath:@"_userInfo.currentPermission" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    
}

-(void)saveUserInfoToPlistWithModel:(SKLoginModel *)model
{
    NSDictionary *dic = [self buildDictionayByModel:model];
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];

    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"userInfo.plist"];
    //输入写入
//    NSLog(@"fileName:%@",filename);
    [dic writeToFile:filename atomically:YES];

    [self setValues];
    
}

-(void)updateUserInfoToPlist
{
    [self saveUserInfoToPlistWithModel:self.userInfo];
}

-(void)updateUserInfoByServer
{
    if (!_userInfo) {
        return;
    }
    //更新用户信息
    [WOTHTTPNetwork updateUserInfoUserId:_userInfo.staffId success:^(id bean) {
        SKLoginModel_msg *model = bean;
        model.msg.currentPermission = _userInfo.currentPermission;
        [self saveUserInfoToPlistWithModel:model.msg];
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        //失败
    }];
}

-(NSArray *)getUserPermissions
{
    NSMutableArray *arr = [NSMutableArray new];
    for (NSString * systemPermission in permissionList) {
        if ([self.userInfo.jurisdiction containsString:systemPermission]) {
            [arr addObject:systemPermission];
        }
    }
    return [arr copy];
}

-(void)userLogout
{
    self.login = NO;
    self.userInfo = nil;
    [self deletePlistFile];
}

-(void)deletePlistFile{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    //文件名
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"userInfo.plist"];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
//        NSLog(@"no  have");
        return ;
    }else {
//        NSLog(@" have");
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDele) {
//            NSLog(@"dele success");
        }else {
//            NSLog(@"dele fail");
        }
        
    }
}

-(NSDictionary *)readUserInfoFromPlist{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"userInfo.plist"];
    NSMutableDictionary *user = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    
    NSLog(@"%@", user);
    return user;
}

-(NSDictionary *)buildDictionayByModel:(SKLoginModel *)model
{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    unsigned int outCount = 0;
    Class cl = [model class];
    objc_objectptr_t *properties = class_copyPropertyList(cl, &outCount);
    
    for (int i = 0; i<outCount; i++) {
        SEL selector;
        objc_objectptr_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        selector = NSSelectorFromString(propertyName);
        id propertyValue;
        if (![model respondsToSelector:selector]) {
            continue;
        }
        propertyValue = [model performSelector:selector];
        [dic setValue:propertyValue forKey:propertyName];
    }
    return [dic copy];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == nil) {
        if ([keyPath isEqualToString:@"_userInfo.currentPermission"]) {
            [self updateUserInfoToPlist];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


@end
