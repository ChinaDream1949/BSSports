//
//  WebH5LabelViewController.m
//  baseXCode
//
//  Created by __ on 2021/4/23.
//

#import "WebH5LabelViewController.h"
#import <WebKit/WebKit.h>

@interface WebH5LabelViewController ()
@property (nonatomic,strong)WKWebView *webView;

@end

@implementation WebH5LabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navAddleftIcon:@"back_icon" leftStr:nil centerStr:@"" rightStr:nil];
    
    [self initSubviews];
}

-(void)initSubviews
{
    WKWebView * webView = [[WKWebView alloc]initWithFrame:self.mainTwoview.bounds];
    
//    [webView loadHTMLString:_model.content baseURL:nil];
    [self.mainTwoview addSubview:webView];
    self.webView = webView;
}

//h5标签适配
-(void)zhuanhuaHtmlContent:(NSString*)content
{
    NSString *head = @"<head><meta name='viewport' content='width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no' >" ;
    NSString* headT = @"<style>* {font-size:15px;padding:0;} img{max-width: 100%; width:auto; height: auto;} video{max-width: 100%; width:100%; height: auto;}</style></head>";
    NSString *befor = [NSString stringWithFormat:@"%@%@",head,headT];
    
//    NSString *titleStr = [NSString stringWithFormat:@"<div style='text-align: center'><h3>%@</h3></div>",title];
//    NSString *timeStr = [NSString stringWithFormat:@"<div style='text-align: right;margin-right: 15px;margin-bottom: 15px;'><p>%@</p></div>",titleTime];
    NSString * contStr = [NSString stringWithFormat:@"<html>%@<body style='word-wrap:break-word;'>%@</body></html>",befor,content];
    [self.webView loadHTMLString:contStr baseURL:nil];
    
}
@end
