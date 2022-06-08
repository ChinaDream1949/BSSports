//
//  PPInterfacedConst.h
//  PPNetworkHelper
//
//  Created by AndyPang on 2017/4/10.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */

/*
测试站管理端访问链接：http://10.0.1.151:6688/admin
超级管理 ： admin
超级管理密码：123456
接口文档：https://www.eolinker.com/#/share/index?shareCode=Im9P8K
新接口 api链接：http://10.0.1.151:4606/
测试数据库：
host = 10.0.1.150
database = question
username = question
password = FPxt2i4KwNAkiFLJ
hostport = 3309
prefix = cmf_
*/

#define DevelopSever 0
#define TestSever    1
#define ProductSever 0

/** 接口前缀-开发服务器*/
UIKIT_EXTERN NSString *const kApiPrefix;

#pragma mark - 详细接口地址

//http响应报文结构码
UIKIT_EXTERN NSString *const _code_;
UIKIT_EXTERN NSString *const _msg_;
UIKIT_EXTERN NSString *const _data_;

/** 登录*/
//UIKIT_EXTERN NSString *const kLogin;
///** 平台会员退出*/
//UIKIT_EXTERN NSString *const kExit;
/**本地设置版本*/

UIKIT_EXTERN NSString *APP_VERSION;
