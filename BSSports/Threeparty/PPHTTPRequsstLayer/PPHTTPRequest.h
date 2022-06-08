//
//  PPHTTPRequest.h
//  PPNetworkHelper
//
//  Created by AndyPang on 2017/4/10.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 以下Block的参数你根据自己项目中的需求来指定, 这里仅仅是一个演示的例子
 */

/**
 请求成功的block
 

 @param response 响应体数据
 */
typedef void(^PPRequestSuccess)(id response);
/**
 请求失败的block
 
 @param error 扩展信息
 */
typedef void(^PPRequestFailure)(NSError *error);

/**
 请求失败的block
 
 @param error 扩展信息
 @param code 失败code码 909090_数据格式错误
 */
typedef void(^WCPRequestFailure)(NSInteger code,NSString *error);


@interface PPHTTPRequest : NSObject

#pragma mark - 登陆退出

/**用户未读数量统计*/
+ (NSURLSessionTask *)postKMessageUnreadParameters:(id)parameters success:(PPRequestSuccess)success failure:(WCPRequestFailure)failure;
@end
