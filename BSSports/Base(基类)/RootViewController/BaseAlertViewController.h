//
//  BaseAlertViewController.h
//  baseXCode
//
//  Created by __ on 2021/4/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 在loadSuview 加载视图 控制contentview的大小
 子视图添加到contentView上
 */

@interface BaseAlertViewController : UIViewController

//-(instancetype)init NS_UNAVAILABLE;

/**外部调用视图显示*/
-(void)show;
-(void)coseClick;

/**子类使用构造界面数据方法*/
@property (nonatomic,strong)UIView *contentView;

-(void)loadSuview;

@end

NS_ASSUME_NONNULL_END
