//
//  WCPBaseTableViewCell.m
//  HxdProject
//
//  Created by __ on 2021/1/3.
//

#import "WCPBaseTableViewCell.h"

@implementation WCPBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
//        self.backgroundColor = RGB247;
        [self initSubViews];
        
    }
    return self;
    
}
-(void)initSubViews
{
    
}
@end
