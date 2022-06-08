//
//  PPInterfacedConst.m
//  PPNetworkHelper
//
//  Created by YiAi on 2017/7/6.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import "PPInterfacedConst.h"

#if DevelopSever
/** 接口前缀-开发服务器*/ //现在测试环境
NSString *const kApiPrefix = @"http://46.8.178.58:4606/";
NSString *APP_VERSION = @"1.0.0";
#elif TestSever
/** 接口前缀-测试服务器*/
NSString *const kApiPrefix = @"http://10.0.1.151:4606/";
NSString *APP_VERSION = @"1.0.34";
#elif ProductSever
/** 接口前缀-生产服务器*/
NSString *const kApiPrefix = @"https://api.tc226.top/";
NSString *APP_VERSION = @"1.0.0";
#endif

//http响应报文结构码
NSString *const _code_ = @"200";
NSString *const _msg_ = @"message";
NSString *const _data_ = @"result";
//* 登录
//NSString *const kLogin = @"/login";
///** 平台会员退出*/
//NSString *const kExit = @"/exit";

