//
//  ZYIndexView.h
//  Wayii
//
//  Created by zy on 2021/8/16.
//

#import <UIKit/UIKit.h>

@protocol ZYIndexDelegate;

@interface ZYIndexView : UIView

@property (nonatomic, weak) id <ZYIndexDelegate> delegate;
@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) UIColor *selectedTextColor;
@property (nonatomic, strong) UIColor *selectedBackgroundColor;
@property (nonatomic, strong) UIColor *detailViewDrawColor;
@property (nonatomic, strong) UIColor *detailViewTextColor;
@property (nonatomic, assign) BOOL onTouch;
@property (nonatomic, assign) BOOL hideDetailView;

@property (nonatomic, assign) CGFloat sectionHeight;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)setIndexes:(NSArray *)indexes;
- (void)setSelectedLabel:(NSInteger)index;



@end


@protocol ZYIndexDelegate<NSObject>

- (void)indexDidChanged:(ZYIndexView *)indexView index:(NSInteger)index title:(NSString *)title;

@end




@interface ZYCustomView: UIView

@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) UIColor *drawColor;
@property (nonatomic, strong) UIColor *textColor;

@end



