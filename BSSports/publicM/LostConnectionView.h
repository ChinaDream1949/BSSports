//
//  LostConnectionView.h
//  yuezishui
//
//  Created by __ on 2019/9/25.
//  Copyright © 2019 HeXiaoDi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol lossUpdateDelegate <NSObject>
/** 刷新页面*/
-(void)updateViewWang;

@end
@interface LostConnectionView : UIView
//无网界面
-(void)loadNoNetUI;
//无数据界面
-(void)loadNoDataUI;


-(void)hiddenUpdateBtn:(BOOL)isHidden;
@property (nonatomic,weak)id <lossUpdateDelegate> delegate;
@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,assign)float navHight;

@end

NS_ASSUME_NONNULL_END
