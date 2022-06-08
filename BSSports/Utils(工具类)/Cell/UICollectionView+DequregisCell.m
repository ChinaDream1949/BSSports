//
//  UICollectionView+DequregisCell.m
//  HxdProject
//
//  Created by __ on 2021/4/6.
//

#import "UICollectionView+DequregisCell.h"
#import <objc/runtime.h>

static NSString *cp_indexPath_collCell_key = @"cp_indexPath_collCell_key";

@implementation UICollectionView (DequregisCell)

-(id)dequClass:(id)cellClass indexPath:(NSIndexPath*)indexpath
{
    UICollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:NSStringFromClass(cellClass) forIndexPath:indexpath];
    cell.cp_indexpath = indexpath;
    return cell;
}


@end

@implementation UICollectionViewCell (SetCellData)

-(void)extion_cellhModel:(id __nullable)data
{
    
}

/**
 runtime
 setter方法
 */
- (void)setCp_indexpath:(NSIndexPath *)cp_indexpath{
    objc_setAssociatedObject(self, &cp_indexPath_collCell_key, cp_indexpath, OBJC_ASSOCIATION_COPY);
}

/**
 runtime
 getter方法
 */
- (NSIndexPath *)cp_indexpath {
    return objc_getAssociatedObject(self, &cp_indexPath_collCell_key);
}

@end
