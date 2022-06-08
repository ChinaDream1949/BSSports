//
//  ShawChildrenVController.m
//  BSSports
//
//  Created by shaw on 2022/5/27.
//

#import "ShawChildrenVController.h"
#import "ShawHomeBannerView.h"
#import "ShawHomeCollCell.h"

@interface ShawChildrenVController ()<CPCollCustDelegate>
@property (nonatomic, strong) WCPRootCollView    *collectionView;
@property (nonatomic, strong) ShawHomeBannerView *bannerView;
@property (nonatomic , strong) NSMutableArray *dataArray;
@end

@implementation ShawChildrenVController
- (instancetype)init:(ShawChildrenStatus)status{
    self = [super init];
    if (self) {
        self.status = status;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.clearColor;
    self.dataArray = [[NSMutableArray alloc]init];
    [self.view addSubview:self.collectionView];
    [self loadData];
}
#pragma mark - 创建collectionView并设置代理
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionView = [[WCPRootCollView alloc]initLayout:flowLayout setCoustDelegate:self];
        _collectionView.frame = self.view.bounds;
        if (self.status == ShawChildrenVC_All) {
            flowLayout.headerReferenceSize = CGSizeMake(KScreenWidth, ksW(200)+ksW(160));//头部大小
            [_collectionView addSubview:self.bannerView];
        }
        //定义每个UICollectionView 的大小
        flowLayout.itemSize = CGSizeMake((KScreenWidth-ksW(42))/2, (KScreenWidth-ksW(42))/2);
        //定义每个UICollectionView 横向的间距
        flowLayout.minimumLineSpacing = ksW(10);
        //定义每个UICollectionView 纵向的间距
        flowLayout.minimumInteritemSpacing = ksW(10);
        //定义每个UICollectionView 的边距距
        flowLayout.sectionInset = UIEdgeInsetsMake(0, ksW(16), 5, ksW(16));//上左下右
        //背景颜色
        _collectionView.backgroundColor = [UIColor clearColor];
        //自适应大小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _collectionView.mj_footer = nil;
        
    }
    return _collectionView;
}
-(NSArray<Class>*)regisCollCell{
    return @[ShawHomeCollCell.class];
}
-(ShawHomeBannerView *)bannerView{
    if (!_bannerView) {
        _bannerView = [[ShawHomeBannerView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, ksW(200)+ksW(160))];
    }
    return _bannerView;
}
#pragma mark - UICollectionView delegate dataSource
-(void)headerRereshing{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [self loadData];
        [self.collectionView.mj_header endRefreshing];
    });
}
-(void)didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    NSLog(@"-------%ld-%ld",(long)indexPath.section,(long)indexPath.row);
}
-(void)loadData{
    CollUIModel *collModel = [[CollUIModel alloc]initWidthClass:ShawHomeCollCell.class cellSize:CGSizeMake((KScreenWidth-ksW(42))/2, (KScreenWidth-ksW(42))/2) callbackCell:^(UICollectionViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
        ShawHomeCollCell *cells = (ShawHomeCollCell *)cell;
        [cells.imgView sd_setImageWithURL:[NSURL URLWithString:@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F1115%2F092621094155%2F210926094155-1-1200.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1656220679&t=203a38f696fa1d9b9ae6869e5a62c0ab"] placeholderImage:[UIImage imageNamed:@"home_bg_img"]];
        cells.text.text = [NSString stringWithFormat:@"Cell %ld",indexPath.item];
        cells.thName.text = [NSString stringWithFormat:@"Cell %ld",indexPath.item];
    }];
    [self.dataArray addObject:collModel];
    NSMutableArray *arr = [[NSMutableArray alloc]initWithObjects:self.dataArray, nil];
    self.collectionView.cellDataArry = arr;
    [self.collectionView reloadData];
}
#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}
@end
