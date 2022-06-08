//
//  ShawHomeVController.m
//  BSSports
//
//  Created by shaw on 2022/5/18.
//

#import "ShawHomeVController.h"
#import <WebKit/WebKit.h>

@interface ShawHomeVController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic , strong) WKWebView *webView;
@property (strong , nonatomic) UIProgressView *progressView;

@end

@implementation ShawHomeVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://bsty8.com/"]]];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
}
#pragma mark - WKWebView
- (WKWebView *)webView
{
    if (nil == _webView) {
        // 可以做一些初始化配置定制
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.selectionGranularity = WKSelectionGranularityDynamic;
        configuration.allowsInlineMediaPlayback = YES;
        
        if (@available(iOS 10.0, *)) {
            // WKAudiovisualMediaTypeNone 音视频的播放不需要用户手势触发, 即为自动播放
            configuration.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeNone;
        } else {
            configuration.requiresUserActionForMediaPlayback = NO;
        }
        
        WKPreferences *preferences = [WKPreferences new];
        //是否支持JavaScript
        preferences.javaScriptEnabled = YES;
        //不通过用户交互，是否可以打开窗口
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        configuration.preferences = preferences;
        
        // 初始化WKWebView
        CGRect webframe = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100);
        _webView = [[WKWebView alloc] initWithFrame:webframe configuration:configuration];
        
        // 有两种代理，UIDelegate负责界面弹窗，navigationDelegate负责加载、跳转等
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        
        [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
        [self.webView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:NULL];
        
        // 适配
        if (@available(iOS 11.0,*)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _webView;
}
#pragma mark - UIProgressView
-(UIProgressView *)progressView{
    if (nil == _progressView) {
        _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, 30)];
        //设置进度条的风格
        [_progressView setProgressViewStyle:UIProgressViewStyleDefault];
        //设置进度条的值
        _progressView.progress = 0.0;
        //设置走过部分的颜色
        _progressView.progressTintColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:190/255.0 alpha:1];
        //设置未走过部分的颜色
        _progressView.trackTintColor = [UIColor grayColor];
    }
    return _progressView;
}
#pragma mark - WKNavigationDelegate
/* 页面开始加载 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
}
/* 开始返回内容 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
/* 页面加载完成 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
}
/* 页面加载失败 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}
/* 在发送请求之前，决定是否跳转 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}
/* 在收到响应后，决定是否跳转 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
#pragma mark - 属性监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat estimatedProgress = [change[NSKeyValueChangeNewKey] floatValue];
        NSLog(@"页面加载进度：%f", estimatedProgress);
        [self.progressView setProgress:estimatedProgress];
    }else if ([keyPath isEqualToString:@"loading"]) {
        BOOL loading = [change[NSKeyValueChangeNewKey] boolValue];
        NSLog(@"%@", loading ? @"开始加载" : @"停止加载");
        self.progressView.hidden = !loading;
    }
}

@end
