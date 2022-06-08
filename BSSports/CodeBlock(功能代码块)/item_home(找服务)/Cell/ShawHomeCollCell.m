//
//  ShawHomeCollCell.m
//  BSSports
//
//  Created by shaw on 2022/5/27.
//

#import "ShawHomeCollCell.h"

@implementation ShawHomeCollCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = ksW(8);
        self.clipsToBounds = YES;
        
        self.imgView = [[UIImageView alloc]init];
        self.imgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:self.imgView];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView.mas_centerY).offset(0);
        }];
        
        self.text = [[UILabel alloc]init];
        self.text.textAlignment = NSTextAlignmentLeft;
        self.text.font = PFReFONT(14);
        [self.contentView addSubview:self.text];
        [self.text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgView.mas_bottom).offset(ksW(10));
            make.left.equalTo(self.contentView.mas_left).offset(ksW(10));
            make.right.equalTo(self.contentView.mas_right).offset(-ksW(10));
        }];
        
        self.iconImage = [[UIImageView alloc]init];
        self.iconImage.backgroundColor = UIColor.purpleColor;
        self.iconImage.layer.masksToBounds = YES;
        self.iconImage.layer.cornerRadius = ksW(15);
        [self.contentView addSubview:self.iconImage];
        [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(ksW(30));
            make.left.equalTo(self.contentView.mas_left).offset(ksW(10));
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-ksW(10));
        }];
        
        self.thName = [[UILabel alloc]init];
        self.thName.backgroundColor = [UIColor brownColor];
        self.thName.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.thName];
        [self.thName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.iconImage);
            make.left.equalTo(self.iconImage.mas_right).offset(ksW(4));
            make.right.equalTo(self.contentView.mas_right).offset(-ksW(10));
        }];
    }
    return self;
}
@end
