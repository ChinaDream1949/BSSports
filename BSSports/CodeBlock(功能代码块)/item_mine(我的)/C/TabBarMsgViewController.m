//
//  TabBarMsgViewController.m
//  baseXCode
//
//  Created by cp on 2021/8/3.
//

#import "TabBarMsgViewController.h"


@interface TabBarMsgViewController ()

@end

@implementation TabBarMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect frame = self.mainTwoview.frame;
    UIEdgeInsets safe = kScreenSafeAreaInset();
    frame.size.height = self.mainTwoview.bounds.size.height - safe.top;
    self.mainTwoview.frame = frame;
    
    self.isShowLiftBack = NO;//每个根视图需要设置该属性为NO，否则会出现导航栏异常
    self.isHidenNaviBar=NO;
}



@end
