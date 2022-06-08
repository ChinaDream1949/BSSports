//
//  AppDelegate.h
//  ToAskLive
//
//  Created by __ on 2020/12/7.
//

#import <UIKit/UIKit.h>
#import "MainTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic,strong)UIWindow *window;

@property (strong, nonatomic) MainTabBarController *mainTabBar;

@end

