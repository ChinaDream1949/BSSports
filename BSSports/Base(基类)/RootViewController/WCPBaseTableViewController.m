//
//  WCPBaseTableViewController.m
//  CargoSteward_CarrierShipper
//
//  Created by __ on 2021/4/15.
//

#import "WCPBaseTableViewController.h"

@interface WCPBaseTableViewController ()<CPTableCustDelegate>

@property (nonatomic,assign)BOOL isFullTab;

@end

@implementation WCPBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navAddleftIcon:@"normal_navleft" leftStr:nil centerStr:@"" rightStr:@""];
    [self Private_loadSuviews];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}
-(void)Private_loadSuviews
{
    self.tableView = [[WCPRootTabView alloc]initStyle:UITableViewStylePlain setCoustDelegate:self];
    [self.mainTwoview addSubview:self.tableView];
    self.tableView.frame = self.mainTwoview.bounds;
}
-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (nonnull NSArray<Class> *)regisTabCell {
    return @[];
}

@end
