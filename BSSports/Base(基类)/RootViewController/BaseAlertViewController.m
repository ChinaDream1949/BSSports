//
//  BaseAlertViewController.m
//  baseXCode
//
//  Created by __ on 2021/4/23.
//

#import "BaseAlertViewController.h"

@interface BaseAlertViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong)UIView* bgView;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) BOOL isDragScrollView;
@property (nonatomic, assign) CGFloat lastTransitionY;

@end

@implementation BaseAlertViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bgView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [self.view addSubview:self.bgView];
        self.bgView.backgroundColor = UIColor.blackColor;
        self.bgView.alpha = 0;
        
        self.contentView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, KScreenHeight, ksW(370))];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = ksW(8);
        [self.view addSubview:self.contentView];
        
        
        [self.view addGestureRecognizer:self.tapGesture];
        [self.view addGestureRecognizer:self.panGesture];
        
        [self loadSuview];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0.4];
    
}

-(void)loadSuview
{
    /**例*/
    UIButton *cosebtn = [ViewConstructor CustButton];
    [cosebtn setTitle:@"关闭" forState:UIControlStateNormal];
    [self.contentView addSubview:cosebtn];
    cosebtn.backgroundColor = UIColor.blackColor;
    cosebtn.frame = CGRectMake(self.contentView.width/2.0, self.contentView.height/2.0, 50, 30);
    [cosebtn addTarget:self action:@selector(coseClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)show
{
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    UIViewController* rootV = kAppDelegate.window.rootViewController;
    [rootV presentViewController:self animated:NO completion:nil];
    [self.view layoutIfNeeded];
//    self.contentView.frame = CGRectMake(0, wcpSH, wcpSW, height);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    float height = self.contentView.height;
    float time = height/1480.0;
    [UIView animateWithDuration:time animations:^{
        self.bgView.alpha = 0.5;
        self.contentView.frame = CGRectMake(0, KScreenHeight-height, kScreenWidth, height);
    }];
}

-(void)coseClick
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    float time = (kScreenHeight - self.contentView.origin.y)/1480.0;
    [UIView animateWithDuration:time animations:^{
        self.bgView.alpha = 0;
        self.contentView.frame = CGRectMake(0, KScreenHeight, KScreenWidth, self.contentView.bounds.size.height);
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

#pragma mark - 懒加载
- (UITapGestureRecognizer *)tapGesture {
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        _tapGesture.delegate = self;
    }
    return _tapGesture;
}

- (UIPanGestureRecognizer *)panGesture {
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        _panGesture.delegate = self;
    }
    return _panGesture;
}
#pragma mark - HandleGesture
- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture {
    CGPoint point = [tapGesture locationInView:self.contentView];
    if (![self.contentView.layer containsPoint:point] && tapGesture.view == self.view) {
        [self coseClick];
//        if (self.removeBlock) {
//            self.removeBlock();
//        }
    }
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    CGPoint translation = [panGesture translationInView:self.contentView];
    if (self.isDragScrollView) {
        // 当UIScrollView在最顶部时，处理视图的滑动
        if (self.scrollView.contentOffset.y <= 0) {
            if (translation.y > 0) { // 向下拖拽
                CGPoint oldOffset = self.scrollView.contentOffset;
                self.scrollView.contentOffset = CGPointMake(oldOffset.x, 0);
                self.scrollView.panGestureRecognizer.enabled = NO;
                self.isDragScrollView = NO;
                
                CGRect contentFrame = self.contentView.frame;
                contentFrame.origin.y += translation.y;
                self.contentView.frame = contentFrame;
                
                NSLog(@"%f",translation.y);
            }
        }
    }else {
        CGFloat contentM = (self.view.frame.size.height - self.contentView.frame.size.height);
        
        if (translation.y > 0) { // 向下拖拽
            CGRect contentFrame = self.contentView.frame;
            contentFrame.origin.y += translation.y;
            self.contentView.frame = contentFrame;
        }else if (translation.y < 0 && self.contentView.frame.origin.y > contentM) { // 向上拖拽
            CGRect contentFrame = self.contentView.frame;
            contentFrame.origin.y = MAX((self.contentView.frame.origin.y + translation.y), contentM);
            self.contentView.frame = contentFrame;
        }
    }
    NSLog(@"高度%02f",self.contentView.origin.y);
    [panGesture setTranslation:CGPointZero inView:self.contentView];
    
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [panGesture velocityInView:self.contentView];
        
        self.scrollView.panGestureRecognizer.enabled = YES;
        
        // 结束时的速度>0 滑动距离> 5 且UIScrollView滑动到最顶部
        if (velocity.y > 0 && self.lastTransitionY > 5 && !self.isDragScrollView) {
            [self coseClick];
//            if (self.removeBlock) {
//                self.removeBlock();
//            }
            
        }else {
            [self showWithCompletion:nil];
        }
    }
    
    self.lastTransitionY = translation.y;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (gestureRecognizer == self.panGesture) {
        UIView *touchView = touch.view;
        while (touchView != nil) {
            if ([touchView isKindOfClass:[UIScrollView class]]) {
                self.scrollView = (UIScrollView *)touchView;
                self.isDragScrollView = YES;
                break;
            }else if (touchView == self.contentView) {
                self.isDragScrollView = NO;
                break;
            }
            touchView = (UIView *)[touchView nextResponder];
        }
    }
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.tapGesture) {
        CGPoint point = [gestureRecognizer locationInView:self.contentView];
        if ([self.contentView.layer containsPoint:point] && gestureRecognizer.view == self.view) {
            return NO;
        }
    }else if (gestureRecognizer == self.panGesture) {
        return YES;
    }
    return YES;
   
}

// 是否与其他手势共存
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer == self.panGesture) {
        if ([otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewPanGestureRecognizer")] || [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
            if ([otherGestureRecognizer.view isKindOfClass:[UIScrollView class]]) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)showWithCompletion:(void (^)(void))completion {
    [UIView animateWithDuration:0.25f animations:^{
        CGRect frame = self.contentView.frame;
        frame.origin.y = self.view.frame.size.height - frame.size.height;
        self.contentView.frame = frame;
    } completion:^(BOOL finished) {
        !completion ? : completion();
    }];
}

@end
