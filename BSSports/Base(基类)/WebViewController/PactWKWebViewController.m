//
//  PactWKWebViewController.m
//  CargoSteward_CarrierShipper
//
//  Created by 华尚 on 2021/6/11.
//

#import "PactWKWebViewController.h"
#import <WebKit/WebKit.h>
@interface PactWKWebViewController ()
@property (nonatomic,strong)WKWebView * webView;
@property (nonatomic, strong) UIProgressView *myProgressView;
@property (nonatomic,assign)BOOL isFirst;
@property (nonatomic,assign)BOOL needUpdate;

@end

@implementation PactWKWebViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.webView.frame = self.mainTwoview.bounds;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navAddleftIcon:@"normal_navleft" leftStr:nil centerStr:[emptyjudge ObjectVlaue:self.titleStr] rightStr:nil];
    
    [self loadWebView];
    
//    [self requestData];
    if (self.urlStr.length>0) {
        [self lostNetwork:self.urlStr];
    }
}
-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)loadWebView
{
    //注册方法给h5调用
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userContentController = [[WKUserContentController alloc]init];
//    [userContentController addScriptMessageHandler:self name:@"yuezishuo_back"];
//    [userContentController addScriptMessageHandler:self name:@"yuezishuo_hideTitle"];
//    [userContentController addScriptMessageHandler:self name:@"publishShare"];
//    [userContentController addScriptMessageHandler:self name:@"toQuestionDetail"];
//    [userContentController addScriptMessageHandler:self name:@"toQaIndex"];
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
//    self.webView.UIDelegate = self;
//
//    self.webView.navigationDelegate = self;
    [self.mainTwoview addSubview:self.webView];
//    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.mainTwoView.top).offset(0);
//        make.left.mas_equalTo(self.mainTwoView.left).offset(0);
//        make.right.mas_equalTo(self.mainTwoView.right).offset(0);
//        make.bottom.mas_equalTo(self.mainTwoView.bottom).offset(0);
//    }];
    
    [self.mainTwoview addSubview:self.myProgressView];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
}
-(void)lostNetwork:(NSString*)urlStr
{
    NSURL *url = [NSURL URLWithString:[emptyjudge ObjectVlaue:urlStr]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
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

    [[NSNotificationCenter defaultCenter]removeObserver:self];
    QQNSLog(@"释放网页");
}
-(void)requestData
{
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setValue:[emptyjudge ObjectVlaue:self.type] forKey:@"type"];
//    kWeakSelf(self);
//    [MBProgressHUD showtoView:weakself.mainTwoview];
//    [PPHTTPRequest getGoodsClassFreightContractParameters:dic success:^(id response) {
//        [MBProgressHUD hideHUDview:weakself.mainTwoview];
//        if ([emptyjudge responseDataVerification:response]) {
////            "result": {
////                    "templateContentUrl": "http://qiniu.ppjava.top/webcarrier_e61acad330004af88b5424accf3f269e.pdf"
////                },
//            NSString * url = [NSString stringWithFormat:@"%@",[response[_data_]objectForKey:@"templateContentUrl"]];
//            [self lostNetwork:url];
//        }else{
//            [MBProgressHUD showMessageText:@"数据格式错误" toView:weakself.mainTwoview afterDelay:1.5];
//        }
//    } failure:^(NSInteger code, NSString *error) {
//        [MBProgressHUD hideHUDview:weakself.mainTwoview];
//        [MBProgressHUD showMessageText:error toView:weakself.mainTwoview afterDelay:1.5];
//    }];
}
@end
