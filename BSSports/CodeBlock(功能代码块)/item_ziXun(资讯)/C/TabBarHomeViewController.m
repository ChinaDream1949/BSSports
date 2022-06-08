//
//  TabBarHomeViewController.m
//  baseXCode
//
//  Created by cp on 2021/8/3.
//

#import "TabBarHomeViewController.h"
#import "ExampleViewController.h"
#import "ShawThinsVController.h"

@interface TabBarHomeViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>

@property (nonatomic,strong)JXCategoryTitleView *categoryView;
@property (nonatomic,strong)JXCategoryListContainerView *listContainerView;
@property (nonatomic,strong)NSArray *listArray;
@property (nonatomic,strong)NSArray *titlesArray;

@end

@implementation TabBarHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = self.mainTwoview.frame;
    UIEdgeInsets safe = kScreenSafeAreaInset();
    frame.size.height = self.mainTwoview.bounds.size.height - safe.top;
    self.mainTwoview.frame = frame;
    
    self.isShowLiftBack = NO;//每个根视图需要设置该属性为NO，否则会出现导航栏异常
    self.isHidenNaviBar=YES;
    
    ShawThinsVController *list1 =[[ShawThinsVController alloc] init];
    ShawThinsVController *list2 =[[ShawThinsVController alloc] init];
    ShawThinsVController *list3 =[[ShawThinsVController alloc] init];
    ShawThinsVController *list4 =[[ShawThinsVController alloc] init];
    ShawThinsVController *list5 =[[ShawThinsVController alloc] init];
    ShawThinsVController *list6 =[[ShawThinsVController alloc] init];
    ShawThinsVController *list7 =[[ShawThinsVController alloc] init];
    self.listArray = @[list1,list2,list3,list4,list5,list6,list7];
    self.titlesArray = @[@"全部", @"足球", @"篮球", @"电竞", @"网球", @"棒球", @"娱乐"];
    
    [self.mainview addSubview:self.categoryView];
    [self.mainTwoview addSubview:self.listContainerView];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryView.mas_bottom).offset(ksW(10));
        make.left.right.bottom.equalTo(self.mainTwoview);
    }];
    
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
