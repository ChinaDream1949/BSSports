//
//  UICollectionView+DequregisCell.h
//  HxdProject
//
//  Created by __ on 2021/4/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (DequregisCell)
-(id)dequClass:(id)cellClass indexPath:(NSIndexPath*)indexpath;

@end

@interface UICollectionViewCell (SetCellData)
/**分类方法 cell赋值*/
-(void)extion_cellhModel:(id __nullable)data;
/*使用dequClass注册的Cell可以使用此属性*/
@property (nonatomic,strong)NSIndexPath *cp_indexpath;

@end

NS_ASSUME_NONNULL_END
