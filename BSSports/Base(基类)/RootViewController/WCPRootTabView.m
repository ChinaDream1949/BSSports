//
//  WCPRootTabView.m
//  baseXCode
//
//  Created by huashang on 2021/6/21.
//

#import "WCPRootTabView.h"

@implementation WCPRootTabView

-(instancetype)initStyle:(UITableViewStyle)style setCoustDelegate:(UIViewController*)delegateVC
{
    self = [super initWithFrame:CGRectZero style:style];
    if (self) {
        self.requestCode = -1;
        self.tabCoustDelegate = (id)delegateVC;
        [self loadTableSetting];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadTableSetting];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self loadTableSetting];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadTableSetting];
    }
    return self;
}
-(void)loadTableSetting
{
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    {
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        if (@available(iOS 15.0, *)) {
            self.sectionHeaderTopPadding = 0;
        } else {
            // Fallback on earlier versions
        }
        //头部刷新
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        header.automaticallyChangeAlpha = YES;
        header.lastUpdatedTimeLabel.hidden = YES;
        self.mj_header = header;
        
        //底部刷新
        self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
        
        self.backgroundColor=RGBColor(247, 247, 247);
        self.scrollsToTop = YES;
        self.tableFooterView = [[UIView alloc] init];
        kWeakSelf(self);
        [[self regisTabCell] enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj) {
                [weakself registerClass:obj forCellReuseIdentifier:NSStringFromClass(obj)];
            }
        }];;
    }
    self.cellDataArry = [NSMutableArray array];
//    [self.mainTwoview addSubview:self.tableView];
//    self.tableView.frame = self.mainTwoview.bounds;
}
#pragma mark - tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cellDataArry.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.cellDataArry[section].count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableUIModel *modelCell = self.cellDataArry[indexPath.section][indexPath.row];
    UITableViewCell *cell = [tableView dequClass:modelCell.cell indexPath:indexPath];
    if (modelCell.callBack) {
        modelCell.callBack(cell, indexPath);
    }
    return cell;

}
//使用masrony的自动适应高度
- (void)SectionCellSID:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    //使用Masonry进行布局的话，这里要设置为NO
    cell.fd_enforceFrameLayout = NO;
//    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass(TixianBottomTableCell.class) cacheByIndexPath:indexPath configuration:^(id cell) {
//        [weakself SectionCellSID:cell atIndexPath:indexPath];
//    }];
}
-(float)masonryautoCell:(Class)cellName cell:(NSIndexPath*)indexPath
{
    kWeakSelf(self);
    return  [self fd_heightForCellWithIdentifier:NSStringFromClass(cellName) cacheByIndexPath:indexPath configuration:^(id cell) {
        [weakself SectionCellSID:cell atIndexPath:indexPath];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableUIModel *modelCell = self.cellDataArry[indexPath.section][indexPath.row];
    if (modelCell.mAuto) {
        if (self.tabCoustDelegate &&
            [self.tabCoustDelegate respondsToSelector:@selector(marsonAutoTabHeightClass:indexPath:)])
        {
            return [self.tabCoustDelegate marsonAutoTabHeightClass:modelCell.cell indexPath:indexPath];
        }
    }
    return modelCell.cellHeight;
}
#pragma mrak - footView
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.tabCoustDelegate && [self.tabCoustDelegate respondsToSelector:@selector(heightForFooterInSection:)]) {
        return [self.tabCoustDelegate heightForFooterInSection:section];
    }else{
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.tabCoustDelegate && [self.tabCoustDelegate respondsToSelector:@selector(viewForFooterInSection:)]) {
        return [self.tabCoustDelegate viewForFooterInSection:section];
    }else{
        return nil;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tabCoustDelegate && [self.tabCoustDelegate respondsToSelector:@selector(didSelectRowAtIndexPath:)]) {
        [self.tabCoustDelegate didSelectRowAtIndexPath:indexPath];
    }
}
#pragma mrak - headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.tabCoustDelegate && [self.tabCoustDelegate respondsToSelector:@selector(viewForHeaderInSection:)]) {
        return [self.tabCoustDelegate viewForHeaderInSection:section];
    }else{
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.tabCoustDelegate && [self.tabCoustDelegate respondsToSelector:@selector(heightForHeaderInSection:)]) {
        return [self.tabCoustDelegate heightForHeaderInSection:section];
    }else{
        return 0;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.tabCoustDelegate && [self.tabCoustDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.tabCoustDelegate scrollViewDidScroll:scrollView];
    }
}
-(void)headerRereshing{
    if (self.tabCoustDelegate && [self.tabCoustDelegate respondsToSelector:@selector(headerRereshing)]) {
        [self.tabCoustDelegate headerRereshing];
    }
}

-(void)footerRereshing{
    if (self.tabCoustDelegate && [self.tabCoustDelegate respondsToSelector:@selector(footerRereshing)]) {
        [self.tabCoustDelegate footerRereshing];
    }
}
-(NSArray<Class>*)regisTabCell
{
    if (self.tabCoustDelegate) {
        return [self.tabCoustDelegate regisTabCell];
    }else
    return @[];
}

//取消请求
- (void)cancelRequest
{
    
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

- (void)dealloc
{
    [self.cellDataArry removeAllObjects];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    QQNSLog(@"释放");
}

@end

@implementation TableUIModel
@synthesize cell = _cell;
@synthesize cellHeight = _cellHeight;
@synthesize callBack = _callBack;
-(instancetype)initWidthClass:(Class)classN
                   cellheight:(float)height
                 callbackCell:(CPCust_TabCell _Nullable)call
{
    self = [[TableUIModel alloc]init];
    if (self) {
        _cell = classN;
        _cellHeight = height;
        _callBack = call;
    }
    return self;
}
@end
