//
//  WCPRootViewController.h
//  HxdProject
//
//  Created by __ on 2020/12/21.
//

#import "RootViewController.h"
//#import "LostConnectionView.h"
NS_ASSUME_NONNULL_BEGIN

@interface WCPRootViewController : RootViewController

@property (nonatomic, weak)UIView * mainview;
@property (nonatomic, weak)UIView * mainTwoview;
@property (nonatomic, weak)UIView * navView;
@property (nonatomic, weak)UIButton  * rightBtn;
@property (nonatomic, weak)UILabel* navCenterLab;
@property (nonatomic, weak)UIView * navLineV;
/**状态页面标记*/
//@property (nonatomic, weak)LostConnectionView *lostView;
-(void)navAddleftIcon:(NSString* __nullable)leftIcon
             leftStr:(NSString* __nullable)leftStr
           centerStr:(NSString* )centerStr
             rightStr:(NSString* __nullable)rightStr;

//状态页使用分类#import "UIViewController+DefaultMapView.h"


-(void)leftClick;
-(void)rightClick;

/** 状态页面 缺省页 way = 1
 @param way 模式 1网络问题  2无数据
 @param height 需要减去的高度
 */
//-(void)showViewWidthStaus:(int)way
//                MinusNavHeight:(float)height
//                addToView:(UIView*)toView;
/**状态页面页面刷新代理*/
-(void)updateViewWang;
/**页面返回时删除缺省页*/
-(void)removeLostView;
@end

NS_ASSUME_NONNULL_END
