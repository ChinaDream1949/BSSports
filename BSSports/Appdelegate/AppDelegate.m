//
//  AppDelegate.m
//  ToAskLive
//
//  Created by __ on 2020/12/7.
//

#import "AppDelegate.h"
//#import <SDImageWebPCoder.h>
//#import <QCloudCOSXML/QCloudCOSXML.h>

@interface AppDelegate ()
//<QCloudSignatureProvider>
//// 一个脚手架实例
//@property (nonatomic) QCloudCredentailFenceQueue* credentialFenceQueue;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//初始化webp的库
//    SDImageWebPCoder *webPCoder = [SDImageWebPCoder sharedCoder];
//    [[SDImageCodersManager sharedManager] addCoder:webPCoder];
//
    [self initWindow];
    //初始化网络请求配置
    [self NetWorkConfig];
    
    //UMeng初始化
    [self initUMeng];
    
    //用户数据
    [UserManger shareManger];
    
    //初始化app服务
    [self initService];
    
    //初始化用户系统
    [self initUserManager];
    
    //网络监听
    [self monitorNetworkStatus];

    return YES;
}



@end
