//
//  WCPRootCollView.m
//  baseXCode
//
//  Created by huashang on 2021/6/21.
//

#import "WCPRootCollView.h"

@implementation WCPRootCollView

-(instancetype)initLayout:(UICollectionViewLayout *)layout setCoustDelegate:(UIViewController*)delegateVC
{
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self) {
        self.requestCode = -1;
        self.custDelegate = (id)delegateVC;
        [self loadCollSetting];
    }
    return self;
}
-(void)loadCollSetting
{
    self.delegate = self;
    self.dataSource = self;
    {
        self.backgroundColor = RGB250;
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//
//        self = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth , KScreenHeight - kTopHeight - kHXDTabBarHeight()) collectionViewLayout:layout];
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        header.automaticallyChangeAlpha = YES;
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        self.mj_header = header;
        
        //底部刷新
        self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];

        self.scrollsToTop = YES;
        kWeakSelf(self);
        [[self regisCollCell] enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj) {
                [weakself registerClass:obj forCellWithReuseIdentifier:NSStringFromClass(obj)];
            }
        }];
    }
}

#pragma mark - collviewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.cellDataArry.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cellDataArry[section].count;
}
-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollUIModel *modelCell = self.cellDataArry[indexPath.section][indexPath.row];
    UICollectionViewCell *cell = [collectionView dequClass:modelCell.cell indexPath:indexPath];
    if (modelCell.callBack) {
        modelCell.callBack(cell,indexPath);
    }
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollUIModel *modelCell = self.cellDataArry[indexPath.section][indexPath.row];
    return modelCell.cellSize;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.custDelegate && [self.custDelegate respondsToSelector:@selector(didSelectRowAtIndexPath:)]) {
        [self.custDelegate didSelectRowAtIndexPath:indexPath];
    }
}


-(NSArray<Class>*)regisCollCell
{
    if (self.custDelegate) {
        return [self.custDelegate regisCollCell];
    }else
    return @[];
}

-(void)headerRereshing{
    if (self.custDelegate &&[self.custDelegate respondsToSelector:@selector(headerRereshing)]) {
        [self.custDelegate headerRereshing];
    }
}

-(void)footerRereshing{
    if (self.custDelegate &&[self.custDelegate respondsToSelector:@selector(footerRereshing)]) {
        [self.custDelegate footerRereshing];
    }
}
#pragma mark - DZNEmptyDataSetSource Methods
//主标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"网络或服务器异常!";
    if (self.requestCode == cp_request_RequErrorCode) {
        text = @"网络或服务器异常!";
    }
    //正确的状态码
    else if (self.requestCode == _code_.intValue){
        text = @"亲，暂时没有数据!";
    }
    
    NSDictionary *attributes = @{NSFontAttributeName: PFReFONT(16),
                                 NSForegroundColorAttributeName: [UIColor grayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//标题详情
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
//    NSString *text = @"标题详情";
//
//    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
//    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraph.alignment = NSTextAlignmentCenter;
//
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
//                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
//                                 NSParagraphStyleAttributeName: paragraph};
    
    return nil;
}

//空数据页面的图片
-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    //根据_requestCode code码不同设置不同的缺省图
    return [UIImage imageNamed:@"zhuangtai_kong"];
    
}

//- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
//{
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
//    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
//    animation.duration = 0.25;
//    animation.cumulative = YES;
//    animation.repeatCount = MAXFLOAT;
//
//    return animation;
//}

//返回点击的按钮 上面带文字
//默认接口报错显示刷新按钮 其他情况需要刷新按钮 需要设置errorUpdate
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    if (self.requestCode == cp_request_dataErrorCode || self.errorUpdate ) {
        NSDictionary *attributes = @{NSFontAttributeName: PFReFONT(15),
                                     NSForegroundColorAttributeName: [UIColor systemBlueColor],
                                     NSStrokeColorAttributeName:[UIColor  redColor],
                                     };
        
        return [[NSAttributedString alloc] initWithString:@"刷新" attributes:attributes];
    }
    return nil;
}

//返回点击的按钮 上面带图片
- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{

    return nil;

}

//返回空白区域的颜色自定义
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{

    return  [UIColor whiteColor];
}


//调整垂直对齐的内容视图(即:有用tableHeaderView时可见):
//返回间距离
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return 0;
    
}

//设置空白页title、description、button等的竖直间隔
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{

    return  16;
}
- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView {
    scrollView.contentOffset = CGPointZero;
}

#pragma mark - DZNEmptyDataSetDelegate Methods

//空白占位视图是否要显示(默认YES)
- (BOOL)emptyDataSetShouldFadeIn:(UIScrollView *)scrollView{

    return  YES;
}

//要求知道空的状态应该渲染和显示 ( 默认YES) :
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    if (self.requestCode == -1) {
        return NO;
    }
    return YES;
    
}
//是否允许点击 (默认YES)
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}
//是否允许滚动 (默认NO)
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return NO;
}

//占位图片是否动态
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    return NO;
}

//空白区域点击事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
}

//按钮响应事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    [self emptyDataButtonClick];
}

#pragma mark 按钮事件
-(void)emptyDataButtonClick
{
    NSLog(@"点击了按钮");
    [self.mj_header beginRefreshing];

}

-(void)dealloc
{
    NSLog(@"collView释放");
}
@end


@implementation CollUIModel

@synthesize cell = _cell;
@synthesize cellSize = _cellSize;
@synthesize callBack = _callBack;
-(instancetype)initWidthClass:(Class)classN cellSize:(CGSize)cellSize callbackCell:(CPCust_CollCell)call
{
    self = [[CollUIModel alloc]init];
    if (self) {
        _cell = classN;
        _cellSize = cellSize;
        _callBack = call;
    }
    return self;
}

@end
