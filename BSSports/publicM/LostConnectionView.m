//
//  LostConnectionView.m
//  yuezishui
//
//  Created by __ on 2019/9/25.
//  Copyright © 2019 HeXiaoDi. All rights reserved.
//

#import "LostConnectionView.h"
#import "FL_Button.h"
//#import "YYText.h"
@interface LostConnectionView()
@property (nonatomic,strong)UIImageView *bgView;
//@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)FL_Button *updateBtn;
@end
@implementation LostConnectionView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
//        [self loadNoNetUI];
    }
    
    return self;
}
-(void)loadNoNetUI
{
    UIImage *img = [UIImage imageNamed:@"norData_Bg"];
    self.bgView = [[UIImageView alloc]initWithImage:img];
    [self addSubview:self.bgView];
    float topConst = ksW(120) - _navHight;
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).offset(0);
//        make.bottom.mas_equalTo(self.mas_top).offset(-ksW(471));
        make.top.mas_equalTo(self.mas_top).offset(topConst);
    }];
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.font =PFReFONT(14);
    self.titleLab.textColor = rgba(102, 102, 102, 1);
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.text = @"网络不可用，网络或服务器异常";
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).offset(0);
        make.top.mas_equalTo(self.bgView.mas_bottom).offset(ksW(10));
    }];
    
    self.updateBtn = [[FL_Button alloc]init];
    self.updateBtn.backgroundColor = [UIColor whiteColor];
    self.updateBtn.layer.masksToBounds =YES;
    self.updateBtn.layer.cornerRadius = ksW(5);
    self.updateBtn.layer.borderColor = BtnLeftColor.CGColor;
    self.updateBtn.layer.borderWidth = ksW(1);
    [self.updateBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [self.updateBtn.titleLabel setFont:PFReFONT(14)];
    [self.updateBtn setTitleColor:BtnLeftColor forState:UIControlStateNormal];
    [self addSubview:self.updateBtn];
    [self.updateBtn addTarget:self action:@selector(updateLClick) forControlEvents:UIControlEventTouchUpInside];
    [self.updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ksW(80));
        make.height.mas_equalTo(ksW(30));
        make.centerX.mas_equalTo(self.mas_centerX).offset(0);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(ksW(15));
    }];
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
//    CGRect r = self.bounds;
}
-(void)updateLClick
{
    if (self.delegate) {
        [self.delegate updateViewWang];
        [self removeFromSuperview];
    }
}
-(void)loadNoDataUI
{
    
    UIImage *img = [UIImage imageNamed:@"norData_Bg"];
    self.bgView = [[UIImageView alloc]initWithImage:img];
    [self addSubview:self.bgView];
    float topConst = ksW(120) - _navHight;
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).offset(0);
//        make.bottom.mas_equalTo(self.bottom).offset(-ksW(530));
        make.top.mas_equalTo(self.mas_top).offset(topConst);
    }];
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.font =PFReFONT(14);
    self.titleLab.textColor = rgba(102, 102, 102, 1);
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.text = @"暂无数据";
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).offset(0);
        make.top.mas_equalTo(self.bgView.mas_bottom).offset(ksW(10));
    }];
    
    self.updateBtn = [[FL_Button alloc]init];
    self.updateBtn.backgroundColor = [UIColor whiteColor];
    self.updateBtn.layer.masksToBounds =YES;
    self.updateBtn.layer.cornerRadius = ksW(10);
    self.updateBtn.layer.borderColor = BtnLeftColor.CGColor;
    self.updateBtn.layer.borderWidth = ksW(1);
    [self.updateBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [self.updateBtn setTitleColor:BtnLeftColor forState:UIControlStateNormal];
    [self addSubview:self.updateBtn];
    [self.updateBtn addTarget:self action:@selector(updateLClick) forControlEvents:UIControlEventTouchDown];
    [self.updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ksW(80));
        make.height.mas_equalTo(ksW(30));
        make.centerX.mas_equalTo(self.mas_centerX).offset(0);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(ksW(25));
    }];
}
-(void)hiddenUpdateBtn:(BOOL)isHidden
{
    self.updateBtn.hidden = isHidden;
}
@end
