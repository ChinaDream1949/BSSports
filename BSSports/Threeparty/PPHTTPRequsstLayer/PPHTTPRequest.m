//
//  PPHTTPRequest.m
//  PPNetworkHelper
//
//  Created by AndyPang on 2017/4/10.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import "PPHTTPRequest.h"
#import "PPInterfacedConst.h"
#import "PPNetworkHelper.h"

@implementation PPHTTPRequest

/** 协议/规则*/
+ (NSURLSessionTask *)postAgreementParameters:(id)parameters success:(PPRequestSuccess)success failure:(WCPRequestFailure)failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiPrefix,@""];
    return [self POSTrequestWithURL:url parameters:parameters success:success failure:failure];
}
///** 登录*/
//+ (NSURLSessionTask *)getLoginWithParameters:(id)parameters success:(PPRequestSuccess)success failure:(WCPRequestFailure)failure
//{
//    // 将请求前缀与请求路径拼接成一个完整的URL
//    NSString *url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kLogin];
//    return [self GETrequestWithURL:url parameters:parameters success:success failure:failure];
//}
///** 退出*/
//+ (NSURLSessionTask *)getExitWithParameters:(id)parameters success:(PPRequestSuccess)success failure:(WCPRequestFailure)failure
//{
//    NSString *url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kExit];
//    return [self GETrequestWithURL:url parameters:parameters success:success failure:failure];
//    
//}


/*
 配置好PPNetworkHelper各项请求参数,封装成一个公共方法,给以上方法调用,
 相比在项目中单个分散的使用PPNetworkHelper/其他网络框架请求,可大大降低耦合度,方便维护
 在项目的后期, 你可以在公共请求方法内任意更换其他的网络请求工具,切换成本小
 */

+ (int)statusCodeForDict:(NSDictionary *)dict {
    return [NSString stringWithFormat:@"%@", [dict objectForKey:@"code"]].intValue;
}
#pragma mark - 请求的公共方法

+ (NSURLSessionTask *)POSTrequestWithURL:(NSString *)URL parameters:(NSDictionary *)parameter success:(PPRequestSuccess)success failure:(WCPRequestFailure)failure
{
    // 在请求之前你可以统一配置你请求的相关参数 ,设置请求头, 请求参数的格式, 返回数据的格式....这样你就不需要每次请求都要设置一遍相关参数
//    if(![PPNetworkHelper isNetwork]){
//        failure(statusCode,@"网络异常");
//        return nil;
//    }
    [self setHTTPHeaderField];
    parameter = [self setCommParmater:parameter];
    NSString *json = [parameter mj_JSONString];
    NSLog(@"文本内容参数==%@",json);
    // 发起请求
    return [PPNetworkHelper POST:URL parameters:parameter success:^(id responseObject) {
        
        // 在这里你可以根据项目自定义其他一些重复操作,比如加载页面时候的等待效果, 提醒弹窗....
        NSDictionary *dict = responseObject;
        if (dict) {
            
            int statusCode = [PPHTTPRequest statusCodeForDict:dict];
            if (statusCode == 200){//成功
                success(responseObject);
            }
            else if (statusCode == 700) {//token失效
                failure(statusCode,@"请重新登录");
                [UserM clearInfo];
                [[NSNotificationCenter defaultCenter]postNotificationName:KNotificationLoginStateChange object:@NO];
                [MBProgressHUD showMessageText:@"登录失效,请重新登录" toView:[UIApplication sharedApplication].keyWindow afterDelay:1.5];
            }
//            else if (statusCode == 400) {
//                success(responseObject);
//            }
            else
            {
                if ([dict objectForKey:_msg_]) {
                    failure(statusCode,[emptyjudge ObjectVlaue:[dict objectForKey:_msg_]]);
                }else{
                    failure(statusCode,@"返回数据格式错误1");
                }
            }
        }else {
            failure(cp_request_dataErrorCode,@"返回数据格式错误2");
        }
    } failure:^(NSError *error) {
        // 同上
        NSInteger codeint = error.code;
        NSString * tishiStr = @"";
        if (codeint == (-999)) {
            tishiStr = @"网络请求已取消";
        }
        else if(codeint == (-1001)){
            tishiStr = @"网络请求超时";
        }
        else {
            tishiStr = @"网络或者服务器异常";
        }
        failure(cp_request_RequErrorCode,tishiStr);
//        NSLog(@"%@", [error localizedDescription]);
//        if ([error localizedDescription].length>0) {
//            failure(statusCode,[error localizedDescription]);
//        }else{
//            failure(statusCode,@"网络或者服务器异常");
//        }
    }];
}

+ (NSURLSessionTask *)GETrequestWithURL:(NSString *)URL parameters:(id)parameter success:(PPRequestSuccess)success failure:(WCPRequestFailure)failure
{

//    [self kHelperSet:5];
//    if(![PPNetworkHelper isNetwork]){
//        failure(statusCode,@"网络异常");
//        return nil;
//    }
    [self setHTTPHeaderField];
    // 发起请求
    parameter = [self setCommParmater:parameter];
    NSString *json = [parameter mj_JSONString];
    NSLog(@"文本内容参数==%@",json);
    return [PPNetworkHelper GET:URL parameters:parameter success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        if (dict) {
            int statusCode = [PPHTTPRequest statusCodeForDict:dict];
            if (statusCode == 200){//成功
                success(responseObject);
            }else if (statusCode == 700) {//token失效
                failure(statusCode,@"请重新登录");
                [UserM clearInfo];
                [[NSNotificationCenter defaultCenter]postNotificationName:KNotificationLoginStateChange object:@NO];
                [MBProgressHUD showMessageText:@"登录失效,请重新登录" toView:[UIApplication sharedApplication].keyWindow afterDelay:1.5];
            }
//            else if (statusCode == 400) {
//                success(responseObject);
//            }
            else {
                if ([dict objectForKey:_msg_]) {
                    failure(statusCode,[emptyjudge ObjectVlaue:[dict objectForKey:_msg_]]);
                }else{
                    failure(statusCode,@"返回数据格式错误1");
                }
            }
        }else {
            failure(cp_request_dataErrorCode,@"返回数据格式错误2");
        }
        
    } failure:^(NSError *error) {
        // 同上
        NSInteger codeint = error.code;
        NSString * tishiStr = @"";
        if (codeint == (-999)) {
            tishiStr = @"网络请求已取消";
        }
        else if(codeint == (-1001)){
            tishiStr = @"网络请求超时";
        }
        else {
            tishiStr = @"网络或者服务器异常";
        }
        failure(cp_request_RequErrorCode,tishiStr);
//        if ([error localizedDescription].length>0) {
//            failure(statusCode,[error localizedDescription]);
//        }else{
//            failure(statusCode,@"网络或者服务器异常");
//        }
        
//        if (error.code == NSURLErrorTimedOut ||error.code == NSURLErrorNotConnectedToInternet)
//        {
//            failure(statusCode,[error localizedFailureReason]);
//        }
    }];
    
}

+(void)setHTTPHeaderField
{
    // 设置请求头
    [PPNetworkHelper setResponseSerializer:PPResponseSerializerJSON];
    [PPNetworkHelper setRequestSerializer:PPRequestSerializerJSON];
    [PPNetworkHelper setRequestTimeoutInterval:10.0];
    [PPNetworkHelper setValue:[emptyjudge ObjectVlaue:@"IOS"] forHTTPHeaderField:@"register-source"];
//    [PPNetworkHelper setValue:@"" forHTTPHeaderField:@"host"];
    
}

+(NSDictionary*)setCommParmater:(id)parameter
{
    NSMutableDictionary * data = ((NSDictionary*)parameter).mutableCopy;
    if (!data) {
        data = [NSMutableDictionary dictionary];
    }
//    [data setValue:[emptyjudge ObjectVlaue:UserM.userInfo.token] forKey:@"token"];
    
    return data;
}
@end
