//
//  MainTabBarController.m
//  CYLTabBarController
//
//  v1.21.x Created by 微博@iOS程序犭袁 ( http://weibo.com/luohanchenyilong/ ) on 10/20/15.
//  Copyright © 2015 https://github.com/ChenYilong . All rights reserved.
//
#import "HXDCYLMainTabBarController.h"
#import <UIKit/UIKit.h>
#import "RootNavigationController.h"
#import "CYLBaseNavigationController.h"
//static CGFloat const CYLTabBarControllerHeight = 40.f;

//View Controllers
//#import "WCPOderViewController.h"
#import "XYTabBar.h"
#import "TabBarHomeViewController.h"
#import "TabBarCommViewController.h"
#import "TabBarMineViewController.h"
#import "TabBarMsgViewController.h"

#define RANDOM_COLOR [UIColor colorWithHue: (arc4random() % 256 / 256.0) saturation:((arc4random()% 128 / 256.0 ) + 0.5) brightness:(( arc4random() % 128 / 256.0 ) + 0.5) alpha:1]

@interface HXDCYLMainTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, weak) UIButton *selectedCover;

@end

@implementation HXDCYLMainTabBarController

- (instancetype)initWithContext:(NSString *)context {
    /**
     * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
     * 等 效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
     * 更推荐后一种做法。
     */
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
    UIOffset titlePositionAdjustment = UIOffsetMake(0, -3.5);
    if (self = [super initWithViewControllers:[self viewControllersForTabBar]
                        tabBarItemsAttributes:[self tabBarItemsAttributesForTabBar]
                                  imageInsets:imageInsets
                      titlePositionAdjustment:titlePositionAdjustment
                                      context:context
                ]) {
        [self customizeTabBarAppearanceWithTitlePositionAdjustment:titlePositionAdjustment];
        self.delegate = self;
        self.navigationController.navigationBar.hidden = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /// 设置Controller支持摇动
//    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];/// 同时让他成为第一相应者：
//    [self becomeFirstResponder];
    
}


- (void)configureMXtabbar {
    XYTabBar *zytabbar = [XYTabBar new];
    zytabbar.delegate = self;
    zytabbar.backgroundColor = [UIColor whiteColor];
     if (@available(iOS 10.0, *)) {
         [zytabbar setTintColor:[UIColor blackColor]];
         zytabbar.unselectedItemTintColor = [UIColor blackColor];
     }else{
         NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
         textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
         textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];

         // 选中时字体颜色和选中图片颜色一致
         NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
         selectedTextAttrs[NSFontAttributeName] = textAttrs[NSFontAttributeName];
         selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];

         // 通过appearance统一设置所有UITabBarItem的文字属性样式
         UITabBarItem *item = [UITabBarItem appearance];
         [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
         [item setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    }
    [self setValue:zytabbar forKeyPath:@"tabBar"];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}
//
- (NSArray *)viewControllersForTabBar {
    TabBarHomeViewController *firstViewController = [[TabBarHomeViewController alloc] init];
    UIViewController *firstNavigationController = [[RootNavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    [firstViewController cyl_setHideNavigationBarSeparator:YES];
    // [firstViewController cyl_setNavigationBarHidden:YES];
    TabBarCommViewController *secondViewController = [[TabBarCommViewController alloc] init];
    UIViewController *secondNavigationController = [[RootNavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    [secondViewController cyl_setHideNavigationBarSeparator:YES];
    // [secondViewController cyl_setNavigationBarHidden:YES];

    TabBarMineViewController *thirdViewController = [[TabBarMineViewController alloc] init];
    UIViewController *thirdNavigationController = [[RootNavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    [thirdViewController cyl_setHideNavigationBarSeparator:YES];

    TabBarMsgViewController *fourthViewController = [[TabBarMsgViewController alloc] init];
    UIViewController *fourthNavigationController = [[RootNavigationController alloc]
                                                    initWithRootViewController:fourthViewController];
    [fourthNavigationController cyl_setHideNavigationBarSeparator:YES];
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController,
                                 fourthNavigationController
                                 ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForTabBar {
    // lottie动画的json文件来自于NorthSea, respect!
    CGFloat firstXOffset = -12/2;
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"首页",
                                                 CYLTabBarItemImage : [UIImage imageNamed:@"tabbar_mesg"],  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemSelectedImage : @"tabbar_mesg_sel",  /* NSString and UIImage are supported*/
                                                 //CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(firstXOffset, -3.5)],
                                                 //第一位 右大，下大
                                                 //CYLTabBarLottieURL : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"green_lottie_tab_home" ofType:@"json"]],
//                                                 CYLTabBarLottieSize: [NSValue valueWithCGSize:CGSizeMake(22, 22)]
                                                 };
    CGFloat secondXOffset = (-25+2)/2;
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"去问",
                                                  CYLTabBarItemImage : [UIImage imageNamed:@"tabbar_mesg"],
                                                  CYLTabBarItemSelectedImage : @"tabbar_mesg_sel",
                                                  //CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(secondXOffset, -3.5)],
                                                 //CYLTabBarLottieURL : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"green_lottie_tab_discover" ofType:@"json"]],
//                                                  CYLTabBarLottieSize: [NSValue valueWithCGSize:CGSizeMake(33, 33)]
                                                  };
    
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"消息",
                                                 CYLTabBarItemImage : [UIImage imageNamed:@"tabbar_mesg"],
                                                 CYLTabBarItemSelectedImage : @"tabbar_mesg_sel",
                                                 //CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(-secondXOffset, -3.5)],
                                                 //CYLTabBarLottieURL : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"green_lottie_tab_news" ofType:@"json"]],
//                                                 CYLTabBarLottieSize: [NSValue valueWithCGSize:CGSizeMake(44, 44)]
                                                 };
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"我的",
                                                  CYLTabBarItemImage :[UIImage imageNamed:@"tabbar_mesg"],
                                                  CYLTabBarItemSelectedImage : @"tabbar_mesg_sel",
                                                 // CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(-firstXOffset, -3.5)],
                                                  //CYLTabBarLottieURL : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"green_lottie_tab_mine" ofType:@"json"]],
//                                                  CYLTabBarLottieSize: [NSValue valueWithCGSize:CGSizeMake(22, 22)]
                                                  };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}
/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearanceWithTitlePositionAdjustment:(UIOffset)titlePositionAdjustment {
    // Customize UITabBar height
    // 自定义 TabBar 高度
    // tabBarController.tabBarHeight = CYL_IS_IPHONE_X ? 65 : 40;
    
    [self rootWindow].backgroundColor = [UIColor cyl_systemBackgroundColor];
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = RGBColor(161, 164, 173);
    //normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = RGBColor(20, 219, 225);
    //selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];

    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    // [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
//     [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set background color
    // 设置 TabBar 背景
    // 半透明
//    [UITabBar appearance].translucent = YES;
    // [UITabBar appearance].barTintColor = [UIColor cyl_systemBackgroundColor];
    // [[UITabBar appearance] setBackgroundColor:[UIColor cyl_systemBackgroundColor]];
    
    
    //     [[UITabBar appearance] setBackgroundImage:[[self class] imageWithColor:[UIColor whiteColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, tabBarController.tabBarHeight ?: (CYL_IS_IPHONE_X ? 65 : 40))]];
    //    [[UITabBar appearance] setUnselectedItemTintColor:[UIColor systemGrayColor]];
    
    //Three way to deal with shadow 三种阴影处理方式：
    // NO.3, without shadow : use -[[CYLTabBarController hideTabBarShadowImageView] in CYLMainRootViewController.m
    
    // NO.2，using layer to add shadow.
    //    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    //    tabBarController.tabBar.layer.shadowColor = [UIColor blackColor].CGColor;
    //    tabBarController.tabBar.layer.shadowRadius = 15.0;
    //    tabBarController.tabBar.layer.shadowOpacity = 1;
    //    tabBarController.tabBar.layer.shadowOffset = CGSizeMake(0, 3);
    //    tabBarController.tabBar.layer.masksToBounds = NO;
    //    tabBarController.tabBar.clipsToBounds = NO;
    
    // NO.1，using Image note:recommended.推荐方式
    // set the bar shadow image
    // without shadow : use -[[CYLTabBarController hideTabBarShadowImageView] in CYLMainRootViewController.m
    if (@available(iOS 13.0, *)) {
        UITabBarItemAppearance *inlineLayoutAppearance = [[UITabBarItemAppearance  alloc] init];
        // fix https://github.com/ChenYilong/CYLTabBarController/issues/456
        inlineLayoutAppearance.normal.titlePositionAdjustment = titlePositionAdjustment;

        // set the text Attributes
        // 设置文字属性
        [inlineLayoutAppearance.normal setTitleTextAttributes:normalAttrs];
        [inlineLayoutAppearance.selected setTitleTextAttributes:selectedAttrs];

        UITabBarAppearance *standardAppearance = [[UITabBarAppearance alloc] init];
        standardAppearance.stackedLayoutAppearance = inlineLayoutAppearance;
        standardAppearance.backgroundColor = [UIColor cyl_systemBackgroundColor];
        //shadowColor和shadowImage均可以自定义颜色, shadowColor默认高度为1, shadowImage可以自定义高度.
        standardAppearance.shadowColor = BtnLeftColor;//[UIColor cyl_systemGreenColor];
        // standardAppearance.shadowImage = [[self class] imageWithColor:[UIColor cyl_systemGreenColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1)];
        self.tabBar.standardAppearance = standardAppearance;
    } else {
        // Override point for customization after application launch.
        // set the text Attributes
        // 设置文字属性
        UITabBarItem *tabBar = [UITabBarItem appearance];
        [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
        [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        
        // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
//        [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
//        [[UITabBar appearance] setShadowImage:[[self class] imageWithColor:[UIColor cyl_systemGreenColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1)]];
    }
}

//- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
//
//    //    NSLog(@"🔴类名与方法名：%@（在第%@行），描述：control : %@ ,tabBarChildViewControllerIndex: %@, tabBarItemVisibleIndex : %@", @(__PRETTY_FUNCTION__), @(__LINE__), control, @(control.cyl_tabBarChildViewControllerIndex), @(control.cyl_tabBarItemVisibleIndex));
//    if ([control cyl_isTabButton]) {
//        //更改红标状态
//        if ([self.selectedViewController cyl_isShowBadge]) {
//            [self.selectedViewController cyl_clearBadge];
//        } else {
//            [self.selectedViewController cyl_showBadge];
//        }
//    }
//    if ([self.tabBarController.selectedViewController cyl_isShowBadge]) {
//        [self.tabBarController.selectedViewController cyl_clearBadge];
//    } else {
//        [self.tabBarController.selectedViewController cyl_setBadgeBackgroundColor:UIColor.blueColor];
//        [self.tabBarController.selectedViewController cyl_showBadge];
//    }
//}

@end

