//
//  WCPRootTabView.h
//  baseXCode
//
//  Created by huashang on 2021/6/21.
//

#import <UIKit/UIKit.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
NS_ASSUME_NONNULL_BEGIN
@class TableUIModel;

typedef void (^CPCust_TabCell)(UITableViewCell* cell,NSIndexPath *indexPath);

//tabbaleView点击代理事件转移
@protocol CPTableCustDelegate <NSObject>

/**需要注册的cell数组*/
-(NSArray<Class>*)regisTabCell;

@optional
/**header下啦刷新*/
-(void)headerRereshing;
/**foot上啦刷新*/
-(void)footerRereshing;
/**cell点击事件*/
-(void)didSelectRowAtIndexPath:(NSIndexPath*)indexPath;
/**使用mason自动更新高度*/
-(float)marsonAutoTabHeightClass:(Class)cellName indexPath:(NSIndexPath*)indexPath;
/**tableview滚动事件*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
/**自定义headerview*/
- (UIView *)viewForHeaderInSection:(NSInteger)section;
/**自定义headerview的高度*/
-(CGFloat)heightForHeaderInSection:(NSInteger)section;
/**自定义footview*/
-(CGFloat)heightForFooterInSection:(NSInteger)section;
/**自定义footview的高度*/
-(UIView *)viewForFooterInSection:(NSInteger)section;
@end
/**使用WCPRootTabView必须在vc里实现CPTableCustDelegate代理*/
@interface WCPRootTabView : UITableView<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/**构造方法
 @param delegateVC 需要实现代理的控制器
 */
-(instancetype)initStyle:(UITableViewStyle)style setCoustDelegate:(UIViewController*)delegateVC;
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
-(instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style NS_UNAVAILABLE;

@property (nonatomic,strong)NSMutableArray <NSArray <TableUIModel*> *> *cellDataArry;

/**构造方法已设置*/
@property (nonatomic,weak)id <CPTableCustDelegate> tabCoustDelegate;

/**接口返回状态码 接口报错时cp_request_dataErrorCode显示刷新按钮
 根据实际情况，不同状态码展示不同缺省图，需要自己在.m 搜索requestCode去做判断。
 */
@property (nonatomic,assign)NSInteger requestCode;
/** 控制页面无数据时是否需要刷新按钮 默认为no*/
@property (nonatomic,assign)BOOL errorUpdate;
@end

@interface TableUIModel : WCPBaseModel

-(instancetype)init NS_UNAVAILABLE;
-(instancetype)new NS_UNAVAILABLE;
-(instancetype)initWidthClass:(Class)classN
                   cellheight:(float)height
                 callbackCell:(CPCust_TabCell __nullable)call;

//不允许外部赋值
@property (nonatomic,assign,readonly)Class cell;
@property (nonatomic,copy,readonly)CPCust_TabCell callBack;
@property (nonatomic,assign,readonly)float cellHeight;

@property (nonatomic,assign)BOOL mAuto;
/***/
//@property (nonatomic,strong)NSIndexPath* indexPath;
@end

NS_ASSUME_NONNULL_END
