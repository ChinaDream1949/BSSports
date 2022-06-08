//
//  WCPRootCollView.h
//  baseXCode
//
//  Created by huashang on 2021/6/21.
//

#import <UIKit/UIKit.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

NS_ASSUME_NONNULL_BEGIN

@class CollUIModel;
typedef void (^CPCust_CollCell)(UICollectionViewCell* cell,NSIndexPath *indexPath);

//tabbaleView点击代理事件转移
@protocol CPCollCustDelegate <NSObject>

/**需要注册的cell数组*/
-(NSArray<Class>*)regisCollCell;

@optional
/**header下啦刷新*/
-(void)headerRereshing;
/**foot上啦刷新*/
-(void)footerRereshing;
/**cell点击事件*/
-(void)didSelectRowAtIndexPath:(NSIndexPath*)indexPath;

@end

@interface WCPRootCollView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

/**构造方法
 @param delegateVC 需要实现代理的控制器
 */
-(instancetype)initLayout:(UICollectionViewLayout *)layout setCoustDelegate:(UIViewController*)delegateVC;

-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
-(instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout NS_UNAVAILABLE;

/**tableview数据封装 第一层数组为section 第二层为row*/
@property (nonatomic,strong)NSMutableArray <NSArray <CollUIModel*> *> *cellDataArry;
@property (nonatomic,weak)id <CPCollCustDelegate> custDelegate;
/**接口返回状态码 接口报错时cp_request_dataErrorCode显示刷新按钮
 根据实际情况，不同状态码展示不同缺省图，需要自己在.m 搜索requestCode去做判断。
 */
@property (nonatomic,assign)NSInteger requestCode;
/** 控制页面无数据时是否需要刷新按钮 默认为no*/
@property (nonatomic,assign)BOOL errorUpdate;
@end

@interface CollUIModel : WCPBaseModel

-(instancetype)init NS_UNAVAILABLE;
-(instancetype)new NS_UNAVAILABLE;
-(instancetype)initWidthClass:(Class)classN
                   cellSize:(CGSize)cellSize
                 callbackCell:(CPCust_CollCell __nullable)call;

//不允许外部赋值
@property (nonatomic,assign,readonly)Class cell;
@property (nonatomic,copy,readonly)CPCust_CollCell callBack;
@property (nonatomic,assign,readonly)CGSize cellSize;
@end

NS_ASSUME_NONNULL_END
