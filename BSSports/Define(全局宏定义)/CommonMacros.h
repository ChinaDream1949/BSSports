//
//  CommonMacros.h
//  MiAiApp
//
//  Created by __ on 2017/5/31.
//  Copyright © 2017年 __. All rights reserved.
//

//全局标记字符串，用于 通知 存储

#ifndef CommonMacros_h
#define CommonMacros_h

#pragma mark - ——————— 用户相关 ————————
//登录状态改变通知
#define KNotificationLoginStateChange @"loginStateChange"

//自动登录成功
#define KNotificationAutoLoginSuccess @"KNotificationAutoLoginSuccess"

//被踢下线
#define KNotificationOnKick @"KNotificationOnKick"

//用户信息缓存 名称
#define KUserCacheName @"KUserCacheName"

//用户model缓存
#define KUserModelCache @"KUserModelCache"

//公钥
#define RSAPublickey @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC5S456hcCgbmoGen0gFLdHerV1ww2HcW0PqonoqixADuy4XWH+2gvoF0nN3bbpaNpLbV4Rq9l+j1PBOKAhmB6hqJ05Us2Z7TM6lrPGnXqipbnvB5karI7uPYT4dktLEwktziKulcU1f0VyLd+qSmh8/coGEig2RsHcnY80uJIt7QIDAQAB"


//支付通知
#define updateAply @"__updateAply__"
//支付通知
#define updateWeCatSogin  @"__updateWeCatSogin__"
#define updateWeCatPayUpdate @"__updateWeCatPayUpdate__"

#pragma mark - ——————— 网络状态相关 ————————

//网络状态变化
#define KNotificationNetWorkStateChange @"KNotificationNetWorkStateChange"

#define  DocumentPath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//接口状态码
/**自定义状态码 --- 数据格式错误code码*/
#define cp_request_dataErrorCode 909090
/**自定义状态码 --- 接口报误code码*/
#define cp_request_RequErrorCode 909091


//通知
#define NotiCenter(name,data) [[NSNotificationCenter defaultCenter]postNotificationName:name object:data]

#endif /* CommonMacros_h */
