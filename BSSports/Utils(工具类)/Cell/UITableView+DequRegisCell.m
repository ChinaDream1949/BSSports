//
//  UITableView+DequRegisCell.m
//  HxdProject
//
//  Created by __ on 2021/4/6.
//

#import "UITableView+DequRegisCell.h"
static NSString *cp_indexPath_tabcell_key = @"cp_indexPath_tabcell_key";

@implementation UITableView (DequRegisCell)

-(id)dequClass:(id)cellClass indexPath:(NSIndexPath*)indexpath
{
    UITableViewCell * cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass) forIndexPath:indexpath];
    cell.cp_indexpath = indexpath;
    return cell;
}

@end

@implementation UITableViewCell (SetCellData)

-(void)extion_cellhModel:(id __nullable)data
{
    
}

/**
 runtime
 setter方法
 */
- (void)setCp_indexpath:(NSIndexPath *)cp_indexpath{
    objc_setAssociatedObject(self, &cp_indexPath_tabcell_key, cp_indexpath, OBJC_ASSOCIATION_COPY);
}

/**
 runtime
 getter方法
 */
- (NSIndexPath *)cp_indexpath {
    return objc_getAssociatedObject(self, &cp_indexPath_tabcell_key);
}

@end
