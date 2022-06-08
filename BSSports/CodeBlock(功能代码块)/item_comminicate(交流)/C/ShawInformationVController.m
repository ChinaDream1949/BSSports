//
//  ShawInformationVController.m
//  BSSports
//
//  Created by shaw on 2022/6/1.
//

#import "ShawInformationVController.h"
#import "ShawInformationV.h"
#import "ShawInfomationCell.h"

@interface ShawInformationVController ()<CPTableCustDelegate>

@property (nonatomic , strong) WCPRootTabView *tableview;
@property (nonatomic , strong) ShawInformationV *bannerView;

@property (nonatomic , strong) NSMutableArray *dataArray;

@end

@implementation ShawInformationVController

- (instancetype)init:(ShawInformationStatus)status{
    self = [super init];
    if (self) {
        self.status = status;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = [[NSMutableArray alloc]init];
    [self.view addSubview:self.tableview];
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableview.frame = self.view.bounds;
}
-(void)cctvClick{
    TableUIModel *cellModel = [[TableUIModel alloc]initWidthClass:ShawInfomationCell.class cellheight:ksW(100) callbackCell:^(UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
    }];
    cellModel.mAuto = YES;
    [self.dataArray addObject:cellModel];
    NSMutableArray *arr = [[NSMutableArray alloc]initWithObjects:self.dataArray, nil];
    self.tableview.cellDataArry = arr;
    [self.tableview reloadData];
}
#pragma arguments WCPRootTabView
-(WCPRootTabView *)tableview{
    if (!_tableview) {
        _tableview = [[WCPRootTabView alloc]initStyle:UITableViewStylePlain setCoustDelegate:self];
//        CGRect frame = self.view.bounds;
//        frame.size.height = self.view.bounds.size.height - kTopHeight - ksW(10) - kHXDTabBarHeight();
//        self.view.frame = frame;
//        _tableview.frame = self.view.bounds;
        if (self.status == ShawInformation_All) {
            _tableview.tableHeaderView = self.bannerView;
        }else{
            _tableview.tableHeaderView = nil;
        }
        _tableview.tabCoustDelegate = self;
        _tableview.errorUpdate = YES;
    }
    return _tableview;
}
#pragma arguments bannerView
-(ShawInformationV *)bannerView{
    if (!_bannerView) {
        _bannerView = [[ShawInformationV alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, ksW(200))];
    }
    return _bannerView;
}
-(NSArray<Class>*)regisTabCell{
    return @[ShawInfomationCell.class];
}
-(void)headerRereshing{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [self cctvClick];
        [self.tableview.mj_header endRefreshing];
    });
}
-(void)footerRereshing{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [self cctvClick];
        [self.tableview.mj_footer endRefreshing];
        self.tableview.mj_footer = nil;
    });
}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}
@end
