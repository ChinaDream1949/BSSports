//
//  ShawThinsVController.m
//  BSSports
//
//  Created by shaw on 2022/5/31.
//

#import "ShawThinsVController.h"
#import "ShawThinsListsCell.h"

@interface ShawThinsVController ()<CPTableCustDelegate>

@property (nonatomic , strong) WCPRootTabView *tableview;
@property (nonatomic , strong) NSMutableArray *dataArray;

@end

@implementation ShawThinsVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableview];
    
    self.dataArray = [[NSMutableArray alloc]init];
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableview.frame = self.view.bounds;
}
-(void)cctvClick{
    TableUIModel *cellModel = [[TableUIModel alloc]initWidthClass:ShawThinsListsCell.class cellheight:ksW(90) callbackCell:^(UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
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
        _tableview.tabCoustDelegate = self;
    }
    return _tableview;
}
-(NSArray<Class>*)regisTabCell{
    return @[ShawThinsListsCell.class];
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
