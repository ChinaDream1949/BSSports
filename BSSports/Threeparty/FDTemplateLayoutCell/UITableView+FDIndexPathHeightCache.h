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
// 类是缓存类，根据IndexPath缓存

#import <UIKit/UIKit.h>

@interface FDIndexPathHeightCache : NSObject

// Enable automatically if you're using index path driven height cache
/** 这个属性的作用就是当你的UITableView调用-reloadDdata，-DeleteSections:withRowAnimation:，-deleteRowsAtIndexPaths:withRowAnimation:之类的操作时，就会自动删除对应的IndexPaths的高度缓存 */
@property (nonatomic, assign) BOOL automaticallyInvalidateEnabled;

// Height cache
/** 是判断缓存是否已经存在 */
- (BOOL)existsHeightAtIndexPath:(NSIndexPath *)indexPath;
/** 是保存高度缓存 */
- (void)cacheHeight:(CGFloat)height byIndexPath:(NSIndexPath *)indexPath;
/** 是取缓存高度，如果缓存高度不存在，返回@(-1) */
- (CGFloat)heightForIndexPath:(NSIndexPath *)indexPath;
/** 用于删除单个特定缓存 */
- (void)invalidateHeightAtIndexPath:(NSIndexPath *)indexPath;
/** 用于删除全部缓存 */
- (void)invalidateAllHeightCache;

@end

@interface UITableView (FDIndexPathHeightCache)
/// Height cache by index path. Generally, you don't need to use it directly.
@property (nonatomic, strong, readonly) FDIndexPathHeightCache *fd_indexPathHeightCache;
@end

@interface UITableView (FDIndexPathHeightCacheInvalidation)
/// Call this method when you want to reload data but don't want to invalidate
/// all height cache by index path, for example, load more data at the bottom of
/// table view.
- (void)fd_reloadDataWithoutInvalidateIndexPathHeightCache;
@end
