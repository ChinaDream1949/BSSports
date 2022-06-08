//
//  ShawInformationV.m
//  BSSports
//
//  Created by shaw on 2022/6/1.
//

#import "ShawInformationV.h"

@interface ShawInformationV ()<CWCarouselDatasource, CWCarouselDelegate>
// 轮播图
@property (nonatomic, strong) CWCarousel *carousel;
@property (nonatomic, strong) NSArray    *dataArr;

@end

@implementation ShawInformationV

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
@end
