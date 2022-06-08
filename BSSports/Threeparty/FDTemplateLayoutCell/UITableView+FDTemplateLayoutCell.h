// The MIT License (MIT)
//
// Copyright (c) 2015-2016 forkingdog ( https://github.com/forkingdog )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import <UIKit/UIKit.h>
#import "UITableView+FDKeyedHeightCache.h"
#import "UITableView+FDIndexPathHeightCache.h"
#import "UITableView+FDTemplateLayoutCellDebug.h"

@interface UITableView (FDTemplateLayoutCell)

/// Access to internal template layout cell for given reuse identifier.
/// Generally, you don't need to know these template layout cells.
///
/// @param identifier Reuse identifier for cell which must be registered.
///
/** 这个方法用来获取模板cell，此cell职责就是用来计算高度 */
- (__kindof UITableViewCell *)fd_templateCellForReuseIdentifier:(NSString *)identifier;

/// Returns height of cell of type specifed by a reuse identifier and configured
/// by the configuration block.
///
/// The cell would be layed out on a fixed-width, vertically expanding basis with
/// respect to its dynamic content, using auto layout. Thus, it is imperative that
/// the cell was set up to be self-satisfied, i.e. its content always determines
/// its height given the width is equal to the tableview's.
///
/// @param identifier A string identifier for retrieving and maintaining template
///        cells with system's "-dequeueReusableCellWithIdentifier:" call.
/// @param configuration An optional block for configuring and providing content
///        to the template cell. The configuration should be minimal for scrolling
///        performance yet sufficient for calculating cell's height.
///
/** 获取cell高度的方法，不使用高度缓存 */
- (CGFloat)fd_heightForCellWithIdentifier:(NSString *)identifier configuration:(void (^)(id cell))configuration;

/// This method does what "-fd_heightForCellWithIdentifier:configuration" does, and
/// calculated height will be cached by its index path, returns a cached height
/// when needed. Therefore lots of extra height calculations could be saved.
///
/// No need to worry about invalidating cached heights when data source changes, it
/// will be done automatically when you call "-reloadData" or any method that triggers
/// UITableView's reloading.
///
/// @param indexPath where this cell's height cache belongs.
///
/** 获取cell高度的方法，根据IndexPath缓存高度 */
- (CGFloat)fd_heightForCellWithIdentifier:(NSString *)identifier cacheByIndexPath:(NSIndexPath *)indexPath configuration:(void (^)(id cell))configuration;

/// This method caches height by your model entity's identifier.
/// If your model's changed, call "-invalidateHeightForKey:(id <NSCopying>)key" to
/// invalidate cache and re-calculate, it's much cheaper and effective than "cacheByIndexPath".
///
/// @param key model entity's identifier whose data configures a cell.
///
/** 获取cell高度的方法，根据Key缓存高度，这个key是啥呢，就是你从服务器获取的获取的model列表，这个model中的可以唯一标示这个model的key */
- (CGFloat)fd_heightForCellWithIdentifier:(NSString *)identifier cacheByKey:(id<NSCopying>)key configuration:(void (^)(id cell))configuration;

@end

@interface UITableView (FDTemplateLayoutHeaderFooterView)

/// Returns header or footer view's height that registered in table view with reuse identifier.
///
/// Use it after calling "-[UITableView registerNib/Class:forHeaderFooterViewReuseIdentifier]",
/// same with "-fd_heightForCellWithIdentifier:configuration:", it will call "-sizeThatFits:" for
/// subclass of UITableViewHeaderFooterView which is not using Auto Layout.
///
/** 这个方法是用来获取UITableView的footer和header的高度的。这个方法是没有缓存高度的。 */
- (CGFloat)fd_heightForHeaderFooterViewWithIdentifier:(NSString *)identifier configuration:(void (^)(id headerFooterView))configuration;

@end

@interface UITableViewCell (FDTemplateLayoutCell)

/// Indicate this is a template layout cell for calculation only.
/// You may need this when there are non-UI side effects when configure a cell.
/// Like:
///   - (void)configureCell:(FooCell *)cell atIndexPath:(NSIndexPath *)indexPath {
///       cell.entity = [self entityAtIndexPath:indexPath];
///       if (!cell.fd_isTemplateLayoutCell) {
///           [self notifySomething]; // non-UI side effects
///       }
///   }
///
/** 这个属性为YES表示此cell是模板cell，模板cell只是用来计算的，不需要为它做UI方面的配置。你用第一个方法得到的cell就是模板cell */
@property (nonatomic, assign) BOOL fd_isTemplateLayoutCell;

/// Enable to enforce this template layout cell to use "frame layout" rather than "auto layout",
/// and will ask cell's height by calling "-sizeThatFits:", so you must override this method.
/// Use this property only when you want to manually control this template layout cell's height
/// calculation mode, default to NO.
///
/** 这个属性默认为NO，为YES的话就是告诉第2，3，4个方法获取高度的时候不要使用-systemLayoutSizeFittingSize:方法，直接使用-sizeThatFits:方法。如果为NO则获取高度首选-systemLayoutSizeFittingSize:方法，如果-systemLayoutSizeFittingSize:方法获取的高度为0再使用-sizeThatFits:方法获取
 */
@property (nonatomic, assign) BOOL fd_enforceFrameLayout;

@end
