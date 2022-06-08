//
//  ShawInfomationCell.m
//  BSSports
//
//  Created by shaw on 2022/6/1.
//

#import "ShawInfomationCell.h"

@interface ShawInfomationCell ()
@property (nonatomic , strong) UIView  *backgroundV;
@property (nonatomic , strong) UIImageView *coverIcon;
@property (nonatomic , strong) UILabel     *titleLab;
@property (nonatomic , strong) UILabel     *minLab;
@property (nonatomic , strong) FL_Button   *goodBtn;
@end

@implementation ShawInfomationCell

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
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-ksW(0));
    }];
    
    _coverIcon = [ViewConstructor loadImgViewRadius:ksW(2) model:UIViewContentModeScaleAspectFill backCor:UIColor.purpleColor];
    _coverIcon.image = [UIImage imageNamed:@"kb"];
    _coverIcon.layer.masksToBounds = YES;
    _coverIcon.layer.cornerRadius  = ksW(8);
    [self.backgroundV addSubview:_coverIcon];
    [_coverIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(ksW(120));
        make.height.mas_equalTo(ksW(80));
        make.right.equalTo(self.backgroundV.mas_right).offset(-ksW(4));
    }];
    
    _titleLab = [ViewConstructor LableInitTitle:@"阿尔法坏孩阿尔法坏孩子阿尔法坏孩子阿尔法坏孩子阿尔法坏孩子阿尔法坏孩子阿尔法坏孩子阿尔法坏孩子子" font:PFBoFONT(16) textColor:DarkCor515151 alignment:NSTextAlignmentLeft];
    _titleLab.numberOfLines = 2;
    [self.backgroundV addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.coverIcon.mas_top).offset(0);
        make.left.equalTo(self.backgroundV.mas_left).offset(ksW(10));
        make.right.equalTo(self.coverIcon.mas_left).offset(-ksW(6));
    }];
    
    _minLab = [ViewConstructor LableInitTitle:@"转载NBA    " font:PFReFONT(12) textColor:DarkCorWhithe alignment:NSTextAlignmentCenter];
    _minLab.backgroundColor = UIColor.purpleColor;
    _minLab.layer.masksToBounds = YES;
    _minLab.layer.cornerRadius = ksW(2);
    [self.backgroundV addSubview:_minLab];
    [_minLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab.mas_left).offset(ksW(0));
        make.bottom.equalTo(self.coverIcon.mas_bottom).offset(ksW(0));
        make.height.mas_equalTo(ksW(18));
    }];
    
    _goodBtn = [[FL_Button alloc]init];
    _goodBtn.status = FLAlignmentStatusNormal;
    [_goodBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_goodBtn setTitle:@"6253" forState:UIControlStateNormal];
    [_goodBtn setTitleColor:DarkCor153153153 forState:UIControlStateNormal];
    _goodBtn.titleLabel.font = PFReFONT(12);
    [self.contentView addSubview:_goodBtn];
    [_goodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.minLab);
        make.left.equalTo(self.minLab.mas_right).offset(ksW(10));
        make.height.mas_equalTo(ksW(20));
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
