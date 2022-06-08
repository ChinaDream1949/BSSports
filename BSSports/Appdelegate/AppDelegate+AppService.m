//
//  AppDelegate+AppService.m
//  MiAiApp
//
//  Created by __ on 2021/4/7.


#import "AppDelegate+AppService.h"
//#import <UMSocialCore/UMSocialCore.h>

#import "OpenUDID.h"

//#import "LoginViewController.h"
//#import <AlipaySDK/AlipaySDK.h>
//#import <UMCommon/UMCommon.h>
//#import <UMShare/UMShare.h>
//#import <WXApi.h>

#import "HXDCYLMainTabBarController.h"
#import "ShiPinBarBtn.h"

@implementation AppDelegate (AppService)


#pragma mark ————— 初始化服务 —————
-(void)initService{
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNotificationLoginStateChange
                                               object:nil];    
    
    //网络状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(netWorkStateChange:)
                                                 name:KNotificationNetWorkStateChange
                                               object:nil];
    NSString *version = [[NSUserDefaults standardUserDefaults]stringForKey:@"__version__"];
    if (![version isEqualToString:APP_VERSION]) {
        [self clearLaunchScreenCache];
        [[NSUserDefaults standardUserDefaults]setValue:APP_VERSION forKey:@"__version__"];
    }
}

#pragma mark ————— 初始化window —————
-(void)initWindow{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = KWhiteColor;
    [self.window makeKeyAndVisible];
    [[UIButton appearance] setExclusiveTouch:YES];
//    [[UIButton appearance] setShowsTouchWhenHighlighted:YES];
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = KWhiteColor;
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
}

#pragma mark ————— 初始化网络配置 —————
-(void)NetWorkConfig{
//    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
//    config.baseUrl = URL_main;

    
    
}

#pragma mark ————— 初始化用户系统 —————
-(void)initUserManager{
    DLog(@"设备IMEI ：%@",[OpenUDID value]);
    
   //根据登录状态判断根视图
//    if ([UserM isLogin]) {
    [ShiPinBarBtn registerPlusButton];
    HXDCYLMainTabBarController *tabBarController = [[HXDCYLMainTabBarController alloc] initWithContext:nil];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:tabBarController];
    nav.navigationBarHidden = YES;
    self.window.rootViewController = nav;
//        [UserM getConfigCos:^(BOOL succes) {
//
//        }];
//    }else{
//
//        LoginViewController *rootViewController = [[LoginViewController alloc] init];
//        RootNavigationController *navC = [[RootNavigationController alloc]
//                                          initWithRootViewController:rootViewController];
//        [self.window setRootViewController:navC];
//    }
    
}

#pragma mark ————— 登录状态处理 —————
- (void)loginStateChange:(NSNotification *)notification
{
    
    
//    BOOL loginSuccess = [notification.object boolValue];
//
//    if (loginSuccess) {//登陆成功加载主窗口控制器
    
    
    [ShiPinBarBtn registerPlusButton];
    HXDCYLMainTabBarController *tabBarController = [[HXDCYLMainTabBarController alloc] initWithContext:nil];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:tabBarController];
    nav.navigationBarHidden = YES;
        self.window.rootViewController = nav;
        [UserM getConfigCos:^(BOOL succes) {
            
        }];
        
//    }else {//登陆失败加载登陆页面控制器
//
//        LoginViewController *rootViewController = [[LoginViewController alloc] init];
//        RootNavigationController *navC = [[RootNavigationController alloc]
//                                          initWithRootViewController:rootViewController];
//        [self.window setRootViewController:navC];
//
//    }
    //展示FPS
//    [AppManager showFPS];
}


#pragma mark ————— 网络状态变化 —————
- (void)netWorkStateChange:(NSNotification *)notification
{
    BOOL isNetWork = [notification.object boolValue];
    
    if (isNetWork) {//有网络

    }else {//登陆失败加载登陆页面控制器
        [MBProgressHUD showTopTipMessage:@"网络状态不佳" isWindow:YES];
    }
}


#pragma mark ————— 友盟 初始化 —————
-(void)initUMeng{
    /* 打开调试日志 */
    //[[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    //初始化友盟
//    [UMConfigure initWithAppkey:UMengKey channel:nil];
//applinks:www.yuezishuo.com
//@"https://www.yuezishuo.com/" =--"e64268ab956098bdc114a7004b6cadaa"
//    https://www.quwenLinks.com/
    [self configUSharePlatforms];
//    BOOL WXRgis = [WXApi registerApp:kAppKey_Wechat
//                       universalLink:@"https://api.tc226.top/"];
//    NSLog(@"微信注册%d,微信版本=%@",WXRgis,[WXApi getApiVersion]);
}
#pragma mark ————— 配置第三方 —————
-(void)configUSharePlatforms{
    
//    [TXLiveBase setLicenceURL:TXPushLicenceURL key:TXPushLicenceKey];
//    NSLog(@"SDK Version = %@", [TXLiveBase getSDKVersionStr]);
//    NSLog(@"Licence == %@",[TXLiveBase getLicenceInfo]);

}

#pragma mark ————— OpenURL 回调 —————

//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
//{
////    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
//    BOOL result = [WXApi handleOpenURL:url delegate:(id)self];
//    if (!result) {
//        if ([url.host isEqualToString:@"safepay"]) {
//            //跳转支付宝钱包进行支付，处理支付结果
//            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//                NSLog(@"result = %@",resultDic);
//                [[NSNotificationCenter defaultCenter]postNotificationName:updateAply object:resultDic];
//            }];
//
//        }
//    }
//
//    return YES;
//}

//- (BOOL)application:(UIApplication *)application continueUserActivity:(nonnull NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler
//{
//    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
//        NSURL *webUrl = userActivity.webpageURL;
//        NSLog(@"continueUserActivity:%@",webUrl);
//    }
//
//    //处理通用链接
//    //当APP被UniversalLink调起后，
//    BOOL ret = [WXApi handleOpenUniversalLink:userActivity delegate:(id)self];
//    NSLog(@"处理微信通过Universal Link启动App时传递的数据:%d",ret);
//    return ret;
//}
//
//- (void)onReq:(BaseReq*)req
//{
//    NSLog(@"wecat:onReq");
//}
//- (void)onResp:(BaseResp*)resp
//{
//    NSLog(@"wecat返回值=%@",resp);
//    if ([resp isKindOfClass:[PayResp class]]){
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
//        {
//            [[NSNotificationCenter defaultCenter]postNotificationName:updateWeCatPayUpdate object:resp];
//        });
//    }else if ([resp isKindOfClass:[SendAuthResp class]]){//登录或者绑定时
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
//        {
//            [[NSNotificationCenter defaultCenter]postNotificationName:updateWeCatSogin object:resp];
//        });
//    }
//}
#pragma mark ————— 网络状态监听 —————
- (void)monitorNetworkStatus
{
    // 网络状态改变一次, networkStatusWithBlock就会响应一次
    [PPNetworkHelper networkStatusWithBlock:^(PPNetworkStatusType networkStatus) {
        
        switch (networkStatus) {
                // 未知网络
            case PPNetworkStatusUnknown:
                DLog(@"网络环境：未知网络");
                // 无网络
            case PPNetworkStatusNotReachable:
                DLog(@"网络环境：无网络");
                KPostNotification(KNotificationNetWorkStateChange, @NO);
                break;
                // 手机网络
            case PPNetworkStatusReachableViaWWAN:
                DLog(@"网络环境：手机自带网络");
                // 无线网络
            case PPNetworkStatusReachableViaWiFi:
                DLog(@"网络环境：WiFi");
                KPostNotification(KNotificationNetWorkStateChange, @YES);
                break;
        }
        
    }];
    
}

+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


-(UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

-(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [self getCurrentVC];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}

#pragma clang diagnostic pop

/**
 *  设置navigationBar样式
 */
- (void)setUpNavigationBarAppearance {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    UIColor *backgroundColor = [UIColor cyl_systemBackgroundColor];
    NSDictionary *textAttributes = nil;
    UIColor *labelColor =   [UIColor cyl_labelColor];

    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        textAttributes = @{
                           NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName : labelColor,
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        textAttributes = @{
                           UITextAttributeFont : [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor : labelColor,
                           UITextAttributeTextShadowColor : [UIColor clearColor],
                           UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    [navigationBarAppearance setBarTintColor:backgroundColor];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    // 每次进入App都检查一次
    [self checkUpdate];
}
-(void)checkUpdate
{
    
}
//{
//    kWeakSelf(self);
//    [PPHTTPRequest getKPassportAppVersionParameters:nil success:^(id response)
//    {
//
//        if (response[@"data"]) {
//            VersionModel * model = [VersionModel mj_objectWithKeyValues:response[@"data"]];
//            if (model.ios_version.count == 0) {
////                [MBProgressHUD showMessageText:@"暂无可用版本" toView:mainTwoview afterDelay:1.5];
//                return;
//            }
//
//            BOOL contain = NO;
//            for (NSString *ver in model.ios_version) {
//                if ([ver isEqualToString:APP_VERSION]) {
//                    contain = YES;
//                    break;
//                }
//            }
//
//            BOOL isLatest = [model.ios_version.lastObject isEqualToString:APP_VERSION];
//            if (!isLatest) {
//
//                CCUpdateViewController *vc = [[CCUpdateViewController alloc] initWithVersion:model.ios_version.lastObject andUrl:model.ios_wap_url prompt:model.ios_prompt Force:!contain];
//
//                vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
//                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:NO completion:^{
//                    ;
//                }];
//            }else{
////                [MBProgressHUD showMessageText:@"已是最新版本" toView:self.mainTwoview afterDelay:1.0];
//            }
//        }else{
//
//        }
//
//    } failure:^(NSInteger code, NSString *error) {
//        NSLog(@"%@",error);
//    }];
//
//}
//进程杀死时会调用这个
-(void)applicationDidEnterBackground:(UIApplication *)application {
    
    __block UIBackgroundTaskIdentifier identifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        if (identifier != UIBackgroundTaskInvalid) {
            [[UIApplication sharedApplication] endBackgroundTask:identifier];
            identifier = UIBackgroundTaskInvalid;
        }
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"执行进入后台调用的方法...");
        
        //此处写正常进入后台时程序需要执行的动作
        
        if (identifier != UIBackgroundTaskInvalid) {
            [[UIApplication sharedApplication] endBackgroundTask:identifier];
            identifier = UIBackgroundTaskInvalid;
        }
    });
}
//---后台杀进程操作。
-(void)applicationWillTerminate:(UIApplication *)application {
    
    //此方法内写程序将要退出时需要执行的动作
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"__CoseAppCenter__" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)clearLaunchScreenCache {
    NSError *error;
    [NSFileManager.defaultManager removeItemAtPath:[NSString stringWithFormat:@"%@/Library/SplashBoard",NSHomeDirectory()] error:&error];
    if (error) {
        NSLog(@"Failed to delete launch screen cache: %@",error);
    }
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"回到前台");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"__checkLiveOline__" object:nil];
    });
}
@end
