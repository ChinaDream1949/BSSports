//
//  ShawHomeBannerView.m
//  BSSports
//
//  Created by shaw on 2022/5/27.
//

#import "ShawHomeBannerView.h"
#import "ShawHomeCollCell.h"

@interface ShawHomeBannerView ()<CWCarouselDatasource, CWCarouselDelegate, UICollectionViewDataSource,UICollectionViewDelegate>
// 轮播图
@property (nonatomic, strong) CWCarousel *carousel;
@property (nonatomic, strong) NSArray    *dataArr;
// UICollectionView
@property (nonatomic, strong) UICollectionView *collectionView;
// 正在热播
@property (nonatomic, strong) UILabel    *starLab;
@end

@implementation ShawHomeBannerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = UIColor.clearColor;
        CWFlowLayout *flowLayout = [[CWFlowLayout alloc] initWithStyle:CWCarouselStyle_H_2];
        flowLayout.itemSpace_H = 10;
        flowLayout.itemWidth = KScreenWidth-ksW(32);
        _carousel = [[CWCarousel alloc] initWithFrame:CGRectMake(ksW(16), ksW(10), KScreenWidth-ksW(32), ksW(180))
                                                        delegate:self
                                                      datasource:self
                                                      flowLayout:flowLayout];
        _carousel.backgroundColor = UIColor.clearColor;
        _carousel.isAuto = YES;
        _dataArr = @[@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F1115%2F092621094155%2F210926094155-1-1200.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1656220679&t=203a38f696fa1d9b9ae6869e5a62c0ab",@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F411%2F0PG11G955%2F110PGG955-0-1200.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1656220709&t=7547cf3dffe4be631d3dcca5761f0814",@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F5%2F547812cf0f303.jpg%3Fdown&refer=http%3A%2F%2Fpic1.win4000.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1656220900&t=54dec7076510e122504bc3bc76a56035"];
        [_carousel registerViewClass:[UICollectionViewCell class] identifier:@"cellId"];
        [self addSubview:_carousel];
        [self.carousel freshCarousel];
        
        // 正在热播
        self.starLab = [[UILabel alloc]init];
        self.starLab.font = PFBoFONT(16);
        self.starLab.text = @"正在热播";
        self.starLab.textColor = RGBDarkColor(rgba(24, 10, 10,1),rgba(255, 255, 255,1));
        [self addSubview:self.starLab];
        [self.starLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(ksW(16));
            make.right.equalTo(self.mas_right).offset(-ksW(16));
            make.bottom.equalTo(self.mas_bottom).offset(-ksW(0));
            make.height.mas_equalTo(ksW(40));
        }];
        // collectionView
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(ksW(16));
            make.right.equalTo(self.mas_right).offset(-ksW(16));
            make.bottom.equalTo(self.starLab.mas_top).offset(-ksW(0));
            make.top.equalTo(_carousel.mas_bottom).offset(ksW(10));
        }];
    }
    return self;
}
- (NSInteger)numbersForCarousel {
    return self.dataArr.count;
}
- (UICollectionViewCell *)viewForCarousel:(CWCarousel *)carousel indexPath:(NSIndexPath *)indexPath index:(NSInteger)index{
    UICollectionViewCell *cell = [carousel.carouselView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor clearColor];
    UIImageView *imgView = [cell.contentView viewWithTag:666];
    if(!imgView) {
        imgView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        imgView.tag = 666;
        imgView.backgroundColor = [UIColor clearColor];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:imgView];
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = ksW(8);
    }
    NSString *name = self.dataArr[index];
    [imgView sd_setImageWithURL:[NSURL URLWithString:name] placeholderImage:[UIImage imageNamed:@"home_bg_img"]];
    return cell;
}
- (void)CWCarousel:(CWCarousel *)carousel didSelectedAtIndex:(NSInteger)index {
    NSLog(@"did selected at index %ld", index);
}
#pragma arguments UICollectionView
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;// 水平滚动
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        
        //定义每个UICollectionView 的大小
        flowLayout.itemSize = CGSizeMake((KScreenWidth-ksW(42))/2 - ksW(10), ksW(120));
        //定义每个UICollectionView 横向的间距
        flowLayout.minimumLineSpacing = ksW(10);
        //定义每个UICollectionView 纵向的间距
        flowLayout.minimumInteritemSpacing = ksW(10);
        //定义每个UICollectionView 的边距距
        flowLayout.sectionInset = UIEdgeInsetsMake(ksW(10), ksW(0), ksW(10), ksW(0));//上左下右
        
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
        //注册cell和ReusableView（相当于头部）
        [_collectionView registerClass:[ShawHomeCollCell class] forCellWithReuseIdentifier:@"cell"];
        
        //设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        //背景颜色
        _collectionView.backgroundColor = [UIColor clearColor];
        //自适应大小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
    }
    return _collectionView;
}
#pragma mark - UICollectionView delegate dataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    ShawHomeCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];

    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F1115%2F092621094155%2F210926094155-1-1200.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1656220679&t=203a38f696fa1d9b9ae6869e5a62c0ab"] placeholderImage:[UIImage imageNamed:@"home_bg_img"]];
    cell.text.text = [NSString stringWithFormat:@"Cel2l %ld",indexPath.item];
    cell.thName.text = [NSString stringWithFormat:@"Cel2l %ld",indexPath.item];
    return cell;
}
#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选择%ld",indexPath.item);
}
@end
