//
//  UITableView+DequRegisCell.m
//  HxdProject
//
//  Created by __ on 2021/4/6.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>
#import "UIViewController+AlertViewAndActionSheet.h"
/**
 VC 基类
 */
@interface RootViewController : UIViewController

/**
 *  修改状态栏颜色
 */
@property (nonatomic, assign) UIStatusBarStyle StatusBarStyle;


//@property (nonatomic, strong) UITableView * tableView;
//@property (nonatomic, strong) UICollectionView * collectionView;
///**
// 如使用_tableview-使用下面注册class类cell
// */
//-(NSArray<Class>*)regisTabCell;
///**
// 如使用_collectionView-使用下面注册class类cell
// */
//-(NSArray<Class>*)regisCollCell;


/**
 *  加载视图
 */
- (void)showLoadingAnimation;

/**
 *  停止加载
 */
- (void)stopLoadingAnimation;

/**
 *  是否显示返回按钮,默认情况是YES
 */
@property (nonatomic, assign) BOOL isShowLiftBack;

/**
 是否隐藏导航栏
 */
@property (nonatomic, assign) BOOL isHidenNaviBar;

//取消网络请求
- (void)cancelRequest;

@property (nonatomic,strong) UICollectionViewFlowLayout *flow;


@end
