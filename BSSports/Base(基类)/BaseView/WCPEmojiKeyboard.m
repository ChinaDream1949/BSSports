//
//  WCPEmojiKeyboard.m
//  baseXCode
//
//  Created by 华尚 on 2021/6/3.
//

#import "WCPEmojiKeyboard.h"


#define FACE_COUNT_ROW  4
#define FACE_COUNT_CLU  7
#define FACE_COUNT_PAGE ( FACE_COUNT_ROW * FACE_COUNT_CLU - 1)
#define FACE_ICON_SIZE  44

#define STICKER_COUNT_ROW  2
#define STICKER_COUNT_CLU  4
#define STICKER_COUNT_PAGE ( STICKER_COUNT_ROW * STICKER_COUNT_CLU)
#define STICKER_ICON_SIZE  80


@implementation WFCUStickerItem

@end



@interface WCPEmojiKeyboard() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>
@property(nonatomic, strong) NSArray *faceEmojiArray;
@property(nonatomic,strong) UIButton *sendBtn;
@property(nonatomic, strong)UIPageControl *facePageControl;
@property(nonatomic, strong)UICollectionView *collectionView;

//@property(nonatomic, strong)UICollectionView *tabView;

@property(nonatomic, strong)NSMutableDictionary<NSString *, WFCUStickerItem *> *stickers;
@property(nonatomic, assign)int selectedTableRow;
@end

#define EMOJ_TAB_HEIGHT 42
#define EMOJ_FACE_VIEW_HEIGHT 190
#define EMOJ_PAGE_CONTROL_HEIGHT 0

#define EMOJ_AREA_HEIGHT (EMOJ_TAB_HEIGHT + EMOJ_FACE_VIEW_HEIGHT + EMOJ_PAGE_CONTROL_HEIGHT)
@implementation WCPEmojiKeyboard{
    int width;
    int location;
}

@synthesize delegate;

- (id)init {
    width = [UIScreen mainScreen].bounds.size.width;
    UIEdgeInsets safe = [UIApplication sharedApplication].keyWindow.safeAreaInsets;
    self = [super initWithFrame:CGRectMake(0, 0, width, EMOJ_AREA_HEIGHT + safe.bottom)];
    
    
    if (self) {

        self.backgroundColor = UIColor.whiteColor;

        NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
        NSString *bundlePath = [resourcePath stringByAppendingPathComponent:@"Emoj.plist"];
        
        self.faceEmojiArray = [[NSArray alloc]initWithContentsOfFile:bundlePath];

        [self addSubview:self.collectionView];

        //添加PageControl
        [self addSubview:self.facePageControl];
        
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.tag = 333;
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _sendBtn.frame = CGRectMake(self.frame.size.width - 52,EMOJ_AREA_HEIGHT + safe.bottom-37-5,52, 37);
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:rgba(51, 51, 51, 1.0) forState:UIControlStateNormal];
        self.sendBtn.layer.borderWidth = 0.5f;
        self.sendBtn.layer.borderColor = UIColor.lightGrayColor.CGColor;
        [_sendBtn addTarget:self action:@selector(sendBtnHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sendBtn];
        
        [_collectionView reloadData];

        self.selectedTableRow = 0;
    }

    return self;
}

- (void)setSelectedTableRow:(int)selectedTableRow {
    _selectedTableRow = selectedTableRow;
    
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 10);
        CGRect frame = self.bounds;
        frame.size.height = EMOJ_FACE_VIEW_HEIGHT;
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.decelerationRate = 90;
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    }
    return _collectionView;
}

- (UIPageControl *)facePageControl {
    if (!_facePageControl) {
//        _facePageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(width/2-50, EMOJ_FACE_VIEW_HEIGHT, 100, EMOJ_PAGE_CONTROL_HEIGHT)];
        _facePageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(width/2-100, EMOJ_FACE_VIEW_HEIGHT, 200, EMOJ_PAGE_CONTROL_HEIGHT)];
        [_facePageControl addTarget:self
                            action:@selector(pageChange:)
                  forControlEvents:UIControlEventValueChanged];
        
        _facePageControl.pageIndicatorTintColor = [UIColor grayColor];
        _facePageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        
        _facePageControl.numberOfPages = [self getPagesCount:0];

        _facePageControl.currentPage = 0;
        if (@available(iOS 14.0, *)) {
//            _facePageControl.backgroundStyle = UIPageControlBackgroundStyleProminent;
//            _facePageControl.allowsContinuousInteraction = YES;
        }

    }
    return _facePageControl;
}

- (void)sendBtnHandle:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didTouchSendEmoj)]) {
        [self.delegate didTouchSendEmoj];
    }
}

- (int)pagesOfIndexPath:(NSIndexPath *)item {
    int pages = 0;
    for (int i = 0; i < item.section; i++) {
        pages += [self collectionView:self.collectionView numberOfItemsInSection:i];
    }
    pages += item.row;
    return pages;
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (scrollView == self.collectionView) {
        NSArray<NSIndexPath *> *items = [_collectionView indexPathsForVisibleItems];
        if (items.count == 2) {
            int pages0 = [self pagesOfIndexPath:items[0]];
            int pages1 = [self pagesOfIndexPath:items[1]];
            
            UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
            CGFloat offset0 = pages0 * (self.collectionView.bounds.size.width + layout.minimumLineSpacing);
            CGFloat offset1 = pages1 * (self.collectionView.bounds.size.width + layout.minimumInteritemSpacing);
            
            NSIndexPath *selectedOne;
            if (ABS(offset0-targetContentOffset->x) > ABS(offset1 - targetContentOffset->x)) {
                targetContentOffset->x = offset1;
                selectedOne = items[1];
            } else {
                targetContentOffset->x = offset0;
                selectedOne = items[0];
            }
            
            if (items[1].section != items[0].section) {
                self.facePageControl.numberOfPages = [self getPagesCount:selectedOne.section];
                self.selectedTableRow = (int)selectedOne.section;
            }
            
            [self.facePageControl setCurrentPage:selectedOne.row];
            [self.facePageControl updateCurrentPageDisplay];
        } else if(items.count == 1) {
            int pages0 = [self pagesOfIndexPath:items[0]];
            
            UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
            CGFloat offset0 = pages0 * (self.collectionView.bounds.size.width + layout.minimumLineSpacing);
            targetContentOffset->x = offset0;
        }
    }
}

- (void)pageChange:(id)sender {
    
}

- (void)faceButton:(UIButton*)sender {
    int i = (int)sender.tag;
    if ([delegate respondsToSelector:@selector(didTouchEmoj:)]) {
        [delegate didTouchEmoj:self.faceEmojiArray[i]];
    }
    
}

- (void)backFace{
    if ([delegate respondsToSelector:@selector(didTouchBackEmoj)]) {
        [delegate didTouchBackEmoj];
    }
}

- (NSInteger)getPagesCount:(NSInteger)section {
    if (section == 0) {
        int FACE_COUNT_ALL = (int)self.faceEmojiArray.count;
        int pages;
        if (FACE_COUNT_ALL > 0) {
            pages = (FACE_COUNT_ALL - 1)/(FACE_COUNT_ROW * FACE_COUNT_CLU -1) + 1;
        } else {
            pages = 0;
        }
        return pages;
    } else {
        return (self.stickers[[self.stickers.allKeys objectAtIndex:(section - 1)]].stickerPaths.count - 1) / STICKER_COUNT_PAGE + 1;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (collectionView == self.collectionView) {
        if (self.disableSticker) {
            return 1;
        }
        return self.stickers.allKeys.count + 1;
    } else {
        return 1;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [self getPagesCount:section];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.collectionView) {
        return self.collectionView.bounds.size;
    } else {
        return CGSizeMake(45, 37);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    for (UIView *subView in [cell subviews]) {
        [subView removeFromSuperview];
    }
    
    if (collectionView == self.collectionView) {
        if (indexPath.section == 0) {
            int startPos = (int)indexPath.row * FACE_COUNT_PAGE;
            int endPos = (int)MIN(self.faceEmojiArray.count, startPos +  FACE_COUNT_PAGE);
            for (int i = startPos; i <= endPos; i++) {
                int cli = (i - startPos)/FACE_COUNT_CLU;
                int col = (i - startPos)%FACE_COUNT_CLU;
                
                CGFloat x = col * width/7;
                CGFloat y = cli * FACE_ICON_SIZE + 8;
                
                if ((cli == FACE_COUNT_ROW -1 && col == FACE_COUNT_CLU - 1) || i == self.faceEmojiArray.count) {
                    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
                    [back setImage:[UIImage imageNamed:@"del_emoji_normal"] forState:UIControlStateNormal];
                    [back setImage:[UIImage imageNamed:@"del_emoji_select"] forState:UIControlStateSelected];
                    [back addTarget:self action:@selector(backFace) forControlEvents:UIControlEventTouchUpInside];
                    
                    if (i == self.faceEmojiArray.count) {
                        x = (FACE_COUNT_CLU - 1) * width/7;
                        y = (FACE_COUNT_ROW - 1) * FACE_ICON_SIZE + 8;
                    }
                    back.frame = CGRectMake( x, y, width/7, FACE_ICON_SIZE);
                    
                    [cell addSubview:back];
                } else {
                    UIButton *faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
                    [faceButton.titleLabel setFont:[UIFont systemFontOfSize:28]];
                    faceButton.tag = i;
                    
                    [faceButton addTarget:self
                                   action:@selector(faceButton:)
                         forControlEvents:UIControlEventTouchUpInside];
                    
                    faceButton.frame = CGRectMake( x, y, width/7, FACE_ICON_SIZE);
                    
                    [faceButton setTitle:self.faceEmojiArray[i]
                                forState:UIControlStateNormal];
                    
                    [cell addSubview:faceButton];
                }
            }
        } else {
            NSArray *paths = self.stickers[self.stickers.allKeys[indexPath.section - 1]].stickerPaths;
            
            int startPos = (int)indexPath.row * STICKER_COUNT_PAGE;
            int endPos = (int)MIN(paths.count, startPos +  STICKER_COUNT_PAGE);
            for (int i = startPos; i < endPos; i++) {
                int cli = (i - startPos)/STICKER_COUNT_CLU;
                int col = (i - startPos)%STICKER_COUNT_CLU;
                
                CGFloat x = col * width/STICKER_COUNT_CLU;
                CGFloat y = cli * STICKER_ICON_SIZE + 8;
                
                UIImageView *imageView;

                imageView = [[UIImageView alloc] initWithFrame:CGRectMake( x + 10, y, width/STICKER_COUNT_CLU - 20, STICKER_ICON_SIZE)];
                imageView.image = [UIImage imageWithContentsOfFile:paths[i]];
    
                [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapSticker:)]];
                imageView.userInteractionEnabled = YES;
                long tag = indexPath.section;
                tag <<= 16;
                tag += i;
                imageView.tag = tag;
                
                [cell addSubview:imageView];
                
            }
        }
    }
    
    
    return cell;
}

- (void)onTapSticker:(UITapGestureRecognizer *)sender {
    UIView *view = sender.view;
    long tag = view.tag;
    long i = tag & 0xFFFF;
    long section = tag >> 16;
    NSString *selectSticker = self.stickers[self.stickers.allKeys[section - 1]].stickerPaths[i];
    if ([self.delegate respondsToSelector:@selector(didSelectedSticker:)]) {
        [self.delegate didSelectedSticker:selectSticker];
    }
}

-(void)setPureExpression
{

//    self.frame = CGRectMake(0, 0, width, EMOJ_AREA_HEIGHT + kTabbarSafeBottomMargin-EMOJ_PAGE_CONTROL_HEIGHT);
}
@end
