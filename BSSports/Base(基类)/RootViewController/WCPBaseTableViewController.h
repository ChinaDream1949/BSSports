//
//  WCPBaseTableViewController.h
//  CargoSteward_CarrierShipper
//
//  Created by __ on 2021/4/15.
//

#import "WCPRootViewController.h"

NS_ASSUME_NONNULL_BEGIN


/**⚠️子类必须实现CPTableCustDelegate代理*/
@interface WCPBaseTableViewController : WCPRootViewController

@property (nonatomic,strong)WCPRootTabView *tableView;

@end




NS_ASSUME_NONNULL_END
/**给予masonry约束撑大cell*/
//TableUIModel *model =
//[[TableUIModel alloc]
//initWidthClass:WCPFeedBackTableViewCell.class
//cellheight:[self masonryautoCell:WCPFeedBackTableViewCell.class cell:[NSIndexPath indexPathForRow:i inSection:0]]
//callbackCell:^(UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath)
//{
//WCPFeedBackTableViewCell *curCell = (id)cell;
////            [curCell cellWidthIsMe:indexPath.row%2];
//[self SectionCellSID:curCell atIndexPath:indexPath];
//}];
//
//}
//
//- (void)SectionCellSID:(WCPFeedBackTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
//{
//    //使用Masonry进行布局的话，这里要设置为NO
//    cell.fd_enforceFrameLayout = NO;
//    [cell cellWidthIsMe:indexPath.row%2];
//}
//-(float)masonryautoCell:(Class)cellName cell:(NSIndexPath*)indexPath
//{
//    kWeakSelf(self);
//    return  [self.tableView fd_heightForCellWithIdentifier:NSStringFromClass(cellName) cacheByIndexPath:indexPath configuration:^(id cell) {
//        [weakself SectionCellSID:cell atIndexPath:indexPath];
//    }];
//}
