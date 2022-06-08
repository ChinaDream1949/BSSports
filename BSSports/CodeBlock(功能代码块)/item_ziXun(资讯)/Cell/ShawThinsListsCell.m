//
//  ShawThinsListsCell.m
//  BSSports
//
//  Created by shaw on 2022/6/1.
//

#import "ShawThinsListsCell.h"

@interface ShawThinsListsCell ()
@property (nonatomic , strong) UIView  *backgroundV;
@property (nonatomic , strong) UILabel *thinsName;
@property (nonatomic , strong) UILabel *timeLab;
@property (nonatomic , strong) UIView  *lineV;
@property (nonatomic , strong) UILabel *vsLab;
@property (nonatomic , strong) UILabel *leftScoreLab;
@property (nonatomic , strong) UILabel *rightScoreLab;
@property (nonatomic , strong) UILabel *leftTeamLab;
@property (nonatomic , strong) UILabel *rightTeamLab;
@property (nonatomic , strong) UIImageView *stateIcon;
@end

@implementation ShawThinsListsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)initSubViews{
    self.contentView.backgroundColor = RGBColor(247, 247, 247);
    
    _backgroundV = [[UIView alloc]init];
    _backgroundV.backgroundColor = DarkCorWhithe;
    _backgroundV.layer.masksToBounds = YES;
    _backgroundV.layer.cornerRadius = ksW(6);
    [self.contentView addSubview:_backgroundV];
    [_backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.left.equalTo(self.contentView.mas_left).offset(ksW(16));
        make.right.equalTo(self.contentView.mas_right).offset(-ksW(16));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-ksW(10));
    }];
    
    _thinsName = [ViewConstructor LableInitTitle:@"哥加仑（秋季）附加赛A组   " font:PFReFONT(14) textColor:DarkCorWhithe alignment:NSTextAlignmentCenter];
    _thinsName.backgroundColor = UIColor.purpleColor;
    _thinsName.layer.masksToBounds = YES;
    _thinsName.layer.cornerRadius = ksW(2);
    [self.backgroundV addSubview:_thinsName];
    [_thinsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backgroundV.mas_left).offset(ksW(4));
        make.top.equalTo(self.backgroundV.mas_top).offset(ksW(8));
        make.height.mas_equalTo(ksW(20));
    }];
    
    _timeLab = [ViewConstructor LableInitTitle:@"7:00" font:PFReFONT(14) textColor:DarkCor515151 alignment:NSTextAlignmentLeft];
    [self.backgroundV addSubview:_timeLab];
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.thinsName.mas_right).offset(ksW(8));
        make.centerY.equalTo(self.thinsName);
        make.right.lessThanOrEqualTo(self.backgroundV.mas_right).offset(-ksW(16));
    }];
    
    _lineV = [[UIView alloc]init];
    _lineV.backgroundColor = CLineColor;
    [self.backgroundV addSubview:_lineV];
    [_lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backgroundV);
        make.top.equalTo(self.thinsName.mas_bottom).offset(ksW(8));
        make.height.mas_equalTo(ksW(0.8));
    }];
    
    _vsLab = [ViewConstructor LableInitTitle:@"未 " font:PFReFONT(13) textColor:DarkCorWhithe alignment:NSTextAlignmentCenter];
    _vsLab.backgroundColor = DarkCor153153153;
    _vsLab.layer.masksToBounds = YES;
    _vsLab.layer.cornerRadius = ksW(2);
    [self.backgroundV addSubview:_vsLab];
    [_vsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundV.mas_centerX).offset(-ksW(16));
        make.top.equalTo(self.lineV.mas_bottom).offset(ksW(12));
    }];
    
    _leftScoreLab = [ViewConstructor LableInitTitle:@"0" font:PFBoFONT(16) textColor:UIColor.orangeColor alignment:NSTextAlignmentRight];
    [self.backgroundV addSubview:_leftScoreLab];
    [_leftScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.vsLab);
        make.right.equalTo(self.vsLab.mas_left).offset(-ksW(10));
    }];
    
    _rightScoreLab = [ViewConstructor LableInitTitle:@"0" font:PFBoFONT(16) textColor:UIColor.orangeColor alignment:NSTextAlignmentLeft];
    [self.backgroundV addSubview:_rightScoreLab];
    [_rightScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.vsLab);
        make.left.equalTo(self.vsLab.mas_right).offset(ksW(10));
    }];
    
    _leftTeamLab = [ViewConstructor LableInitTitle:@"山鸡队特遣小分队" font:PFBoFONT(16) textColor:DarkCor515151 alignment:NSTextAlignmentRight];
    [self.backgroundV addSubview:_leftTeamLab];
    [_leftTeamLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftScoreLab);
        make.right.equalTo(self.leftScoreLab.mas_left).offset(-ksW(10));
        make.left.greaterThanOrEqualTo(self.backgroundV.mas_left).offset(ksW(16));
    }];
    
    _rightTeamLab = [ViewConstructor LableInitTitle:@"阿尔法坏孩子" font:PFBoFONT(16) textColor:DarkCor515151 alignment:NSTextAlignmentLeft];
    [self.backgroundV addSubview:_rightTeamLab];
    [_rightTeamLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.rightScoreLab);
        make.left.equalTo(self.rightScoreLab.mas_right).offset(ksW(10));
        make.right.lessThanOrEqualTo(self.backgroundV.mas_right).offset(-ksW(46));
    }];
    
    _stateIcon = [ViewConstructor loadImgViewRadius:ksW(2) model:UIViewContentModeScaleAspectFit backCor:UIColor.purpleColor];
    [self.backgroundV addSubview:_stateIcon];
    [_stateIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.vsLab);
        make.width.mas_equalTo(ksW(20));
        make.height.mas_equalTo(ksW(15));
        make.right.lessThanOrEqualTo(self.backgroundV.mas_right).offset(-ksW(16));
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
