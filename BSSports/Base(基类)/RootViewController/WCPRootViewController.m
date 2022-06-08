//
//  WCPRootViewController.m
//  HxdProject
//
//  Created by __ on 2020/12/21.
//

#import "WCPRootViewController.h"

@interface WCPRootViewController ()

@end

@implementation WCPRootViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self removeLostView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isShowLiftBack = NO;//每个根视图需要设置该属性为NO，否则会出现导航栏异常
    self.isHidenNaviBar=YES;
    if (@available(iOS 13.0, *)) {
        self.StatusBarStyle = UIStatusBarStyleDarkContent;
    } else {
        // Fallback on earlier versions
        self.StatusBarStyle = UIStatusBarStyleDefault;
    }
    
    [self MainUI];
}

-(void)MainUI
{
    UIView * mainview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    mainview.userInteractionEnabled=YES;
    mainview.backgroundColor=RGBColor(247, 247, 247);
    [self.view addSubview:mainview];
    self.mainview = mainview;
    
    UIEdgeInsets safe = kScreenSafeAreaInset();
    
    UIView * mainTwoview = [[UIView alloc]initWithFrame:CGRectMake(0, kTopHeight, KScreenWidth, KScreenHeight - kTopHeight-safe.bottom)];
    mainTwoview.userInteractionEnabled=YES;
//    mainTwoview.backgroundColor=[UIColor redColor];
    [mainview addSubview:mainTwoview];
    self.mainTwoview=mainTwoview;
    
}
-(void)navAddleftIcon:(NSString* __nullable)leftIcon
             leftStr:(NSString* __nullable)leftStr
           centerStr:(NSString* )centerStr
            rightStr:(NSString* __nullable)rightStr
{
    UIView * navigationItemview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, kTopHeight)];
    navigationItemview.backgroundColor=[UIColor whiteColor];
    navigationItemview.userInteractionEnabled=YES;
    self.navView = navigationItemview;
    [self.mainview addSubview:navigationItemview];
    
    //top = ktopheight-60
    UIView * iconbackView=[[UIView alloc]init];
    iconbackView.userInteractionEnabled=YES;
//    iconbackView.backgroundColor=[UIColor whiteColor];
    [navigationItemview addSubview:iconbackView];
    [iconbackView mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.left.mas_equalTo(navigationItemview.mas_left).offset(0);
        make.bottom.mas_equalTo(navigationItemview.mas_bottom).offset(-ksW(10));
        make.height.mas_equalTo(ksW(30));
        make.width.mas_equalTo(ksW(70));
    }];
    [iconbackView.superview layoutIfNeeded];
    //添加点击手势
    UITapGestureRecognizer * iconbackclick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftClick)];
    //    click.delegate = self;
    [iconbackView addGestureRecognizer:iconbackclick];
    //左按钮
    if (leftIcon) {
        UIButton  * navleftbut = [UIButton buttonWithType:UIButtonTypeCustom];
        navleftbut.userInteractionEnabled=NO;
//        navleftbut.backgroundColor=[UIColor whiteColor];
        [navleftbut setImage:[UIImage imageNamed:leftIcon] forState:UIControlStateNormal];
        [iconbackView addSubview:navleftbut];
        [navleftbut mas_makeConstraints:^(MASConstraintMaker *make)
         {
            make.left.mas_equalTo(iconbackView.mas_left).offset(ksW(16));
            make.centerY.mas_equalTo(iconbackView.mas_centerY).offset(0);
            make.height.mas_equalTo(ksW(20));
            make.width.mas_equalTo(ksW(20));

        }];
        [navleftbut.superview layoutIfNeeded];
        
        if (leftStr) {
            UILabel * navtitleLabel=[[UILabel alloc]init];
            navtitleLabel.backgroundColor=[UIColor whiteColor];
            //    navtitleLabel.hidden=YES;
            navtitleLabel.font= PFReFONT(18);
            navtitleLabel.textColor=[UIColor blackColor];
            navtitleLabel.text=leftStr;
            navtitleLabel.textAlignment=NSTextAlignmentCenter;
            [iconbackView addSubview:navtitleLabel];
            [navtitleLabel mas_makeConstraints:^(MASConstraintMaker *make)
             {
                make.left.mas_equalTo(navleftbut.mas_right).offset(ksW(13));
                make.centerY.mas_equalTo(navleftbut.mas_centerY).offset(0);
                make.right.mas_equalTo(iconbackView.mas_right).offset(0);

            }];
            [navtitleLabel.superview layoutIfNeeded];
        }
    }

    UILabel * centerLab = [[UILabel alloc]init];
    centerLab.font= PFBoFONT(18);
    centerLab.textColor=rgba(26, 26, 26, 1);
    centerLab.text= centerStr;
    centerLab.textAlignment=NSTextAlignmentCenter;
    [navigationItemview addSubview:centerLab];
    centerLab.tag = 2;
    [centerLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.centerX.mas_equalTo(navigationItemview.mas_centerX).offset(0);
        make.bottom.mas_equalTo(navigationItemview.mas_bottom).offset(-ksW(12));
        make.height.mas_equalTo(ksW(25));
    }];
    self.navCenterLab = centerLab;
    
    if (rightStr) {
        UIButton  * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            rightBtn.backgroundColor = [UIColor redColor];
        [rightBtn setTitle:rightStr forState:UIControlStateNormal];
        rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [rightBtn.titleLabel setFont:PFReFONT(15)];
        UIColor *cor = RGBColor(74, 144, 226);
        [rightBtn setTitleColor:cor
                       forState:UIControlStateNormal];

        [navigationItemview addSubview:rightBtn];
        [rightBtn addTarget:self action:@selector(rightClick)
           forControlEvents:UIControlEventTouchDown];
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(navigationItemview.mas_right).offset(-ksW(17));
//            make.bottom.mas_equalTo(navigationItemview.mas_bottom).offset(-ksW(10));
            make.centerY.mas_equalTo(centerLab.mas_centerY).offset(0);
            make.width.mas_equalTo(ksW(40));
            make.height.mas_equalTo(ksW(30));
        }];
        self.rightBtn = rightBtn;
    }
    
    UIView *navLineV = [[UIView alloc]initWithFrame:CGRectMake(0, kTopHeight-1, KScreenWidth, 1)];
    navLineV.backgroundColor = RGBColor(242, 242, 242);
    [self.navView addSubview:navLineV];
    self.navLineV = navLineV;
    self.navLineV.hidden = YES;
}
-(void)leftClick
{
    
}
-(void)rightClick
{
    
}

//#pragma mark - 页面状态
///** 状态页面 缺省页 way = 1
// @param way 模式 1网络问题  2无数据
// @param height 需要减去的高度
// */
//-(void)showViewWidthStaus:(int)way
//                MinusNavHeight:(float)height
//                addToView:(UIView*)toView
//{
//    if (self.lostView) {
//        [self.lostView removeFromSuperview];
//        self.lostView = nil;
//    }
//
//    LostConnectionView *view = [[LostConnectionView alloc]init];
//    view.navHight = height;
//    if (way == 1) {
//        [view loadNoNetUI];
//    }else if(way == 2){
//        [view loadNoDataUI];
//        [view hiddenUpdateBtn:YES];
//    }
//    self.lostView = view;
//    view.delegate = (id)self;
//    [toView addSubview:view];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(toView.mas_top).offset(height);
//        make.bottom.mas_equalTo(toView.mas_bottom).offset(0);
//        make.left.mas_equalTo(toView.mas_left).offset(0);
//        make.right.mas_equalTo(toView.mas_right).offset(0);
//    }];
//
//}
-(void)updateViewWang
{
    
}
-(void)removeLostView
{
//    if (self.lostView) {
//        [self.lostView removeFromSuperview];
//        self.lostView = nil;
//    }
}
-(void)headerRereshing{
    [self removeLostView];
}
@end
