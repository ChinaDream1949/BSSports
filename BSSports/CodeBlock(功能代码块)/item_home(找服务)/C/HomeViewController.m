//
//  HomeViewController.m
//  CargoSteward
//
//  Created by __ on 2021/4/6.
//

#import "HomeViewController.h"
#import "BaseAlertViewController.h"
#import "ShawChildrenVController.h"

@interface HomeViewController () <JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>
@property (nonatomic,strong)WCPRootTabView *tableView;
@property (nonatomic,strong)FL_Button *searchBtn;
@property (nonatomic,strong)JXCategoryTitleView *categoryView;
@property (nonatomic,strong)JXCategoryListContainerView *listContainerView;
@property (nonatomic,strong)NSArray *listArray;
@property (nonatomic,strong)NSArray *titlesArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = self.mainTwoview.frame;
    UIEdgeInsets safe = kScreenSafeAreaInset();
    frame.size.height = self.mainTwoview.bounds.size.height - safe.top;
    self.mainTwoview.frame = frame;
    
    self.isShowLiftBack = NO;//每个根视图需要设置该属性为NO，否则会出现导航栏异常
    self.isHidenNaviBar=NO;
    
    ShawChildrenVController *list1 =[[ShawChildrenVController alloc] init:ShawChildrenVC_All];
    ShawChildrenVController *list2 =[[ShawChildrenVController alloc] init:ShawChildrenVC_Football];
    ShawChildrenVController *list3 =[[ShawChildrenVController alloc] init:ShawChildrenVC_Basketball];
    ShawChildrenVController *list4 =[[ShawChildrenVController alloc] init:ShawChildrenVC_Esports];
    ShawChildrenVController *list5 =[[ShawChildrenVController alloc] init:ShawChildrenVC_Tennis];
    ShawChildrenVController *list6 =[[ShawChildrenVController alloc] init:ShawChildrenVC_Baseball];
    ShawChildrenVController *list7 =[[ShawChildrenVController alloc] init:ShawChildrenVC_Entertainment];
    self.listArray = @[list1,list2,list3,list4,list5,list6,list7];
    self.titlesArray = @[@"全部", @"足球", @"篮球", @"电竞", @"网球", @"棒球", @"娱乐"];
    
//    [self navAddleftIcon:nil leftStr:nil centerStr:@"" rightStr:nil];
    [self createBgImage];
    [self.mainview addSubview:self.categoryView];
    [self.mainTwoview addSubview:self.listContainerView];
    [self createNavUI];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryView.mas_bottom).offset(ksW(10));
        make.left.equalTo(self.mainTwoview.mas_left).offset(ksW(16));
        make.right.equalTo(self.mainTwoview.mas_right).offset(-ksW(16));
        make.height.mas_equalTo(ksW(30));
    }];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchBtn.mas_bottom).offset(ksW(10));
        make.left.right.bottom.equalTo(self.mainTwoview);
    }];
    
}
#pragma arguments bgIMgae
-(void)createBgImage{
    UIImageView *bgIMage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, ksW(200))];
    bgIMage.image = [UIImage imageNamed:@"home_bg_img"];
    bgIMage.contentMode = UIViewContentModeScaleAspectFill;
    [self.mainview insertSubview:bgIMage atIndex:0];
}
#pragma arguments navView
-(void)createNavUI{
    UIEdgeInsets safe = kScreenSafeAreaInset();
    _searchBtn = [[FL_Button alloc]init];
    _searchBtn.status = FLAlignmentStatusLeft;
    _searchBtn.fl_padding = ksW(110);
    _searchBtn.backgroundColor = CLineColor;
    _searchBtn.titleLabel.font = PFReFONT(14);
    _searchBtn.layer.masksToBounds = YES;
    _searchBtn.layer.cornerRadius = ksW(15);
    [_searchBtn setImage:[UIImage imageNamed:@"searchh"] forState:UIControlStateNormal];
    [_searchBtn setTitle:@"   搜索主播名、主播ID、主播间名" forState:UIControlStateNormal];
    [_searchBtn setTitleColor:CFontColor2 forState:UIControlStateNormal];
    [self.mainview addSubview:_searchBtn];
}
#pragma arguments lazy JXCategoryView listContainerView
-(JXCategoryTitleView *)categoryView{
    if (!_categoryView) {
        UIEdgeInsets safe = kScreenSafeAreaInset();
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, safe.top, KScreenWidth, kNavBarHeight)];
        _categoryView.delegate = self;
        _categoryView.titles = self.titlesArray;
        _categoryView.titleColorGradientEnabled = YES;
        _categoryView.backgroundColor = UIColor.clearColor;
        _categoryView.titleColor = CFontColor2;
        _categoryView.titleSelectedColor = CFontColor1;
        // 指示器
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorColor = UIColor.purpleColor;
        lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
        _categoryView.indicators = @[lineView];
    }
    return _categoryView;
}
-(JXCategoryListContainerView *)listContainerView{
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
        // 关联到 categoryView
        self.categoryView.listContainer = _listContainerView;
    }
    return _listContainerView;
}
// 返回列表的数量
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 7;
}
// 根据下标 index 返回对应遵守并实现 `JXCategoryListContentViewDelegate` 协议的列表实例
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    return self.listArray[index];
}
@end
