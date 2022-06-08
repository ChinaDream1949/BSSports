//
//  UIViewController+DefaultMapView.m
//  baseXCode
//
//  Created by 华尚 on 2021/5/6.
//

#import "UIViewController+DefaultMapView.h"


#define corVTag 333330
static NSString *cp_view_cor_key = @"cp_view_cor_key";

@interface UIViewController (DefaultMapView)


@end


@implementation UIViewController (DefaultMapView)

/**展示缺省图-不需要缺省图带导航栏
 @param toView 添加的视图
 @param code 根据状态码添加缺省图
 */
-(void)showDefaultMap:(UIView*)toView
                 code:(NSInteger)code
{
    if (self.corView) {
        [self.corView removeFromSuperview];
        self.corView = nil;
    }
    LostConnectionView *view = [[LostConnectionView alloc]init];
    if (code == 400) {
        [view loadNoNetUI];
    }else if(code == NotDAtaCode){
        [view loadNoDataUI];
        [view hiddenUpdateBtn:YES];
    }
    view.delegate = (id)self;
    [toView addSubview:view];
    self.corView = view;
    view.tag = corVTag;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(toView.mas_top).offset(0);
        make.bottom.mas_equalTo(toView.mas_bottom).offset(0);
        make.left.mas_equalTo(toView.mas_left).offset(0);
        make.right.mas_equalTo(toView.mas_right).offset(0);
    }];
}
/**展示缺省图-覆盖整个页面需要导航栏
 @param code 根据状态码添加缺省图
 @param isBack 是否需要返回按钮
 */
-(void)showDefaultMapCode:(NSInteger)code
               isNeedBack:(BOOL)isBack
{
    if (self.corView) {
        [self.corView removeFromSuperview];
        self.corView = nil;
    }
    LostConnectionView *view = [[LostConnectionView alloc]init];
    if (code == 400) {
        [view loadNoNetUI];
    }else if(code == 2){
        [view loadNoDataUI];
        [view hiddenUpdateBtn:YES];
    }
    view.delegate = (id)self;
    [self.view addSubview:view];
    self.corView = view;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
    }];
    if (isBack) {
        UIButton *leftBtn = [ViewConstructor CustButton];
        //        navleftbut.backgroundColor=[UIColor whiteColor];
        [leftBtn setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make)
         {
            make.left.mas_equalTo(view.mas_left).offset(ksW(16));
            make.top.mas_equalTo(view.mas_top).offset(kStatusBarHeight+ksW(15));
            make.height.mas_equalTo(ksW(20));
            make.width.mas_equalTo(ksW(20));
            
            [view addSubview:leftBtn];
        }];
    }
    
}
-(void)removeCorView:(UIView*)toView
{
    UIView *corV = [toView viewWithTag:corVTag];
    if (corV) {
        [corV removeFromSuperview];
    }
}

-(void)setCorView:(LostConnectionView *)corView
{
    objc_setAssociatedObject(self, &cp_view_cor_key, corView, OBJC_ASSOCIATION_RETAIN);
}
-(LostConnectionView *)corView
{
    return objc_getAssociatedObject(self, &cp_view_cor_key);
}

-(void)removeCor
{
    if (self.corView) {
        [self.corView removeFromSuperview];
        self.corView = nil;
    }
}
-(void)updateViewWang
{
    
}
@end
