//
//  WebViewController.m
//  baseXCode
//
//  Created by __ on 2021/4/23.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()<WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate>
@property (nonatomic,strong)WKWebView * webView;
@property (nonatomic, strong) UIProgressView *myProgressView;
@property (nonatomic,assign)BOOL isFirst;
@property (nonatomic,assign)BOOL needUpdate;
@end

@implementation WebViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.webView.frame = self.mainTwoview.bounds;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    if (!_isFirst) {
        [self.webView reload];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self navAddleftIcon:@"acc" leftStr:nil centerStr:self.titleStr rightStr:nil];
    
    [self clearWkwebView];
    
    [self lostNetwork];
//    if (_NONav) {
//        [self loadAllWebView];
//    }
}
#pragma mark - c清除h5的h缓存
-(void)clearWkwebView
{
    WKWebsiteDataStore *dateStore = [WKWebsiteDataStore defaultDataStore];
    
    [dateStore fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes]
                     completionHandler:^(NSArray * __nonnull records) {
        for (WKWebsiteDataRecord *record in records){
            
            //               if ( [record.displayName containsString:@"baidu"]) //取消备注，可以针对某域名清除，否则是全清
            
            //               {
            [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:record.dataTypes
                                                      forDataRecords:@[record]
                                                   completionHandler:^{
                NSLog(@"Cookies for %@ deleted successfully",record.displayName);
            }];
            
            //               }
        }
        
    }];
}

-(void)leftClick
{
    if ([self.webView canGoBack]) {
        if (self.needUpdate) {
            self.needUpdate = NO;
//            self.backNavitation = [self.webView goBack];
        }else{
            [self.webView goBack];
        }
        
        
//        if (self.needUpdate) {
//            self.needUpdate = NO;
//            [self.webView reload];
//        }
    }else{
        if (self.navigationController) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}
-(void)loadWebView
{
    //注册方法给h5调用
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userContentController = [[WKUserContentController alloc]init];
    [userContentController addScriptMessageHandler:self name:@"yuezishuo_back"];
    [userContentController addScriptMessageHandler:self name:@"yuezishuo_hideTitle"];
    [userContentController addScriptMessageHandler:self name:@"publishShare"];
    [userContentController addScriptMessageHandler:self name:@"toQuestionDetail"];
    [userContentController addScriptMessageHandler:self name:@"toQaIndex"];
    configuration.userContentController = userContentController;
    
    // 自适应屏幕宽度js
//    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
//    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    // 添加js调用
//    [userContentController addUserScript:wkUserScript];
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 10.0;
    configuration.preferences = preferences;
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero
                                      configuration:configuration];
    //    self.webView.UIDelegate = self;
    //    self.webView.navigationDelegate = self;
    
//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];
        self.webView.UIDelegate = self;
    
    self.webView.navigationDelegate = self;
    [self.mainTwoview addSubview:self.webView];
//    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.mainTwoView.top).offset(0);
//        make.left.mas_equalTo(self.mainTwoView.left).offset(0);
//        make.right.mas_equalTo(self.mainTwoView.right).offset(0);
//        make.bottom.mas_equalTo(self.mainTwoView.bottom).offset(0);
//    }];
    
    [self.mainTwoview addSubview:self.myProgressView];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    //    要区分打开H5是在本地APP还是在手机浏览器，前端伙伴说需要配合修改默认的 UserAgent,以便区分。
        //    修改全局UserAgent值（这里是在原有基础上拼接自定义的字符串）
    [self setUserAgent];
}
- (void)setUserAgent
{
    [self.webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
        NSString *oldUserAgent = result;
        NSString *newUserAgent = [NSString stringWithFormat:@"%@ yuezishuo?",oldUserAgent];
        self.webView.customUserAgent = newUserAgent;
    }];
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    
    NSURL *URL = navigationAction.request.URL;
    
//    NSString *scheme = [URL scheme];
    NSMutableURLRequest *mutableRequest = [navigationAction.request mutableCopy];
    if (!_isFirst) {
        _isFirst = YES;
        NSLog(@"--有吗");
        [self setToken:mutableRequest];
        decisionHandler(WKNavigationActionPolicyCancel);
        [webView loadRequest:mutableRequest];
    }
}
#pragma mark - 字符串转字典
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
#pragma mark - 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.myProgressView.alpha = 1.0f;
        [self.myProgressView setProgress:newprogress animated:YES];
        if (newprogress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                self.myProgressView.alpha = 0.0f;
            }
                             completion:^(BOOL finished) {
                [self.myProgressView setProgress:0 animated:NO];
            }];
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
#pragma mark - getter and setter
- (UIProgressView *)myProgressView
{
    if (_myProgressView == nil) {
        _myProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10)];
        _myProgressView.tintColor = RGBColor(89, 201, 245);
        _myProgressView.trackTintColor = [UIColor whiteColor];
    }
    
    return _myProgressView;
}
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView.configuration.userContentController
     removeScriptMessageHandlerForName:@"yuezishuo_back"];
    [self.webView.configuration.userContentController
     removeScriptMessageHandlerForName:@"yuezishuo_hideTitle"];
    [self.webView.configuration.userContentController
     removeScriptMessageHandlerForName:@"publishShare"];
    [self.webView.configuration.userContentController
     removeScriptMessageHandlerForName:@"toQuestionDetail"];
    [self.webView.configuration.userContentController
     removeScriptMessageHandlerForName:@"toQaIndex"];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    QQNSLog(@"释放网页");
}
-(void)lostNetwork
{
    NSURL *url = [NSURL URLWithString:[emptyjudge ObjectVlaue:self.urlStr]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}
-(void)updateViewWang
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self lostNetwork];
    });
    
}
#pragma mark 分享
-(void)righttviewBtn
{
    
    if ([PPNetworkHelper isNetwork])
    {
        if ([emptyjudge Values:self.urlStr])
        {
            [self shareToTree];
//            kWeakSelf(self);
//            HXDShareUIViewController * vc = [[HXDShareUIViewController alloc]init];
//            vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//            //        [self presentViewController:vc animated:NO completion:nil];
//            //        kWeakSelf(self);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [weakself presentViewController:vc animated:NO completion:nil];
//            });
//            vc.ShareUIBlock = ^(HXDShareModel * _Nonnull Model) {
//                [weakself ShareModel:Model];
//            };
        }
        
        
    }
    else
    {
         [MBProgressHUD hideHUDview:self.mainTwoview];
        [MBProgressHUD showMessageText:@"网络异常" toView:self.mainTwoview afterDelay:NSTimeIntervaltext];
    }
    
}
#pragma mark - 分享模块
-(void)shareToTree
{
//    if (self.ShareModel) {
//
//        SharePopView *popView = [[SharePopView alloc] initWidthType:ShareNore];
//        popView.ID = [emptyjudge ObjectVlaue:_ID];
//        popView.shareModel = _ShareModel;
//        popView.table_type = @"13";
//        [popView show];
//        popView.superV = self;
//    }
}

//-(void)ShareToPlatformType:(UMSocialPlatformType)platformType
//{
//
//    kWeakSelf(self);
//    //调用分享面板
//    //    [self shareWithUI];
//    UIImage * midimg = [[TJLongImgCut manager] screenShotForTableView:self.tableView screenRect:UIEdgeInsetsMake(0, 0, 0, 0) imageKB:1024];//获取图片小于等于1M
//    //     [self alert:img];
//
//    /*
//     masterImage  主图片，生成的图片的宽度为masterImage的宽度
//     slaveImage   从图片，拼接在masterImage的下面
//     */
//    UIImage * topimg = [[TJLongImgCut manager] addSlaveImage:midimg toMasterImage:[UIImage imageNamed:@"share_up_icon"] directionType:directionTypeUpAndDown];
//
//    UIImage * botimg = [[TJLongImgCut manager] addSlaveImage:[UIImage imageNamed:@"share_down_icon"] toMasterImage:topimg directionType:directionTypeUpAndDown];
//
//
//    UIViewController * rootVc = [UIApplication sharedApplication].delegate.window.rootViewController;
//    WCPShareViewController *vc = [[WCPShareViewController alloc]init];
//    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    [rootVc presentViewController:vc
//                         animated:NO
//                       completion:nil];
//    [vc showImge:botimg];
//
//    [vc setCallBack:^(BOOL cose) {
//
//
//        // weakself.navfxbut.userInteractionEnabled=YES;
//
//        if (cose ==YES) {
//
//            [weakself shareImageToPlatformType:platformType botimg:botimg];
//
//
//        }
//
//
//    }];
//}

//请求设置token等数据给h5
-(void)setToken:(NSMutableURLRequest*)muQuest
{
    // 在请求之前你可以统一配置你请求的相关参数 ,设置请求头, 请求参数的格式, 返回数据的格式....这样你就不需要每次请求都要设置一遍相关参数
    /**
     *  设置请求超时时间:默认为30S
     *
     *  @param time 时长
     */


//    [muQuest addValue:[emptyjudge ObjectVlaue:UserM.] forHTTPHeaderField:@"token"];
    
    NSString * UUIDString = [NSString stringWithFormat:@"%@", [[NSUUID UUID] UUIDString]];
    QQNSLog(@"获取UUIDString==%@",UUIDString);
    if ([emptyjudge Values:UUIDString]) {
        [muQuest addValue:[emptyjudge ObjectVlaue:UUIDString] forHTTPHeaderField:@"uuid"];
    }
    //获取手机系统版本
//   // [emptyjudge ObjectVlaue:UUIDString]
//    NSString * osversionString = [NSString stringWithFormat:@"%@",[BQYUserDefaultsmanager objectForKey:phoneVersionStr identifier:nil]];
//    HXDNSLog(@"获取手机系统版本==%@",osversionString);
//    if ([emptyjudge Values:osversionString])
//    {
//        [muQuest addValue:[emptyjudge ObjectVlaue:osversionString] forHTTPHeaderField:@"os-version"];
//    }
    
    //获取用户手机型号
//    NSString * modelString = [NSString stringWithFormat:@"%@",[BQYUserDefaultsmanager objectForKey:Mobilephonemodels identifier:nil]];
//    HXDNSLog(@"获取用户手机型号==%@",modelString);
//    if ([emptyjudge Values:modelString])
//    {
//        [muQuest addValue:[emptyjudge ObjectVlaue:modelString] forHTTPHeaderField:@"model"];
//    }
    //获取app版本
    NSString * appssenstr=[NSString stringWithFormat:@"%@",[emptyjudge appVersion]];
    QQNSLog(@"获取app版本==%@",appssenstr);
    if ([emptyjudge Values:appssenstr]) {
        [muQuest addValue:[emptyjudge ObjectVlaue:appssenstr] forHTTPHeaderField:@"version"];
    }
    
    //手机品牌
    NSString * phoneBrandstr=[NSString stringWithFormat:@"%@",[emptyjudge phoneBrand]];
    QQNSLog(@"手机品牌==%@",phoneBrandstr);
    if ([emptyjudge Values:phoneBrandstr]) {
        [muQuest addValue:[emptyjudge ObjectVlaue:phoneBrandstr] forHTTPHeaderField:@"brand"];
    }
    
    //哪个端
    NSString * os_typestr=[NSString stringWithFormat:@"%@",[emptyjudge os_type]];
    QQNSLog(@"哪个端==%@",os_typestr);
    if ([emptyjudge Values:os_typestr]) {
        [muQuest addValue:[emptyjudge ObjectVlaue:os_typestr] forHTTPHeaderField:@"os-type"];
    }
    
}


#pragma mark - WKScriptMessageHandler
/**
 * JS 调用 OC 触发此方法
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"body:%@",message.body);
    if ([message.name isEqualToString:@"yuezishuo_back"]) {
        NSLog(@"点击了返回按钮");
        //do something
        [self.navigationController popViewControllerAnimated:YES];
    }else if([message.name isEqualToString:@"yuezishuo_hideTitle"]) {
        NSLog(@"隐藏导航栏");
        //do something
//        [self.navigationController popViewControllerAnimated:YES];
//        [self loadAllWebView];
        
    }else if([message.name isEqualToString:@"publishShare"]) {
        NSLog(@"跳转发布");

        [self jumpFabu:message.body];
    }else if([message.name isEqualToString:@"toQuestionDetail"]) {
        NSLog(@"跳转问题详情");
//        [self jumpWentiDelte:message.body];
    }else if([message.name isEqualToString:@"toQaIndex"]) {
        NSLog(@"跳转问题首页");
//        [self jumpWenDaHome];
    }
}
#pragma mark - 全屏url

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    NSLog(@"hhahahahha");
    NSString * TokenString = @"";
    completionHandler([emptyjudge ObjectVlaue:TokenString]);
    
}

-(void)jumpFabu:(id)body
{
    
}



@end
