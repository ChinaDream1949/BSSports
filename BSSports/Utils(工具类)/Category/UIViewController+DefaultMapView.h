//
//  UIViewController+DefaultMapView.h
//  baseXCode
//
//  Created by 华尚 on 2021/5/6.
//

#import <UIKit/UIKit.h>
#import "LostConnectionView.h"

NS_ASSUME_NONNULL_BEGIN

#define NotDAtaCode 9090909

@interface UIViewController (DefaultMapView)

/**展示缺省图-不需要缺省图带导航栏
 @param toView 添加的视图
 @param code 根据状态码添加缺省图
 */
-(void)showDefaultMap:(UIView*)toView
                 code:(NSInteger)code;


/**展示缺省图-覆盖整个页面需要导航栏
 @param code 根据状态码添加缺省图
 @param isBack 是否需要返回按钮
 */
-(void)showDefaultMapCode:(NSInteger)code
               isNeedBack:(BOOL)isBack;

///**刷新数据前先删除遮罩层*/
//-(void)removeCorView:(UIView*)toView;
///**显示刷下按钮*/
////-(void)showUpdateBtn:(UIView*)toView;
-(void)removeCor;
@property (nonatomic,strong)LostConnectionView * __nullable corView;

@end

NS_ASSUME_NONNULL_END
