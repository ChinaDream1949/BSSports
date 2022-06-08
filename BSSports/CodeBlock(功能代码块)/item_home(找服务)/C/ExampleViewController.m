//
//  ExampleViewController.m
//  baseXCode
//
//  Created by cp on 2021/10/28.
//

#import "ExampleViewController.h"

@interface ExampleViewController ()

@end

@implementation ExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}
-(void)loadSuview
{
    UIView *hahhView = [[UIView alloc]initWithFrame:CGRectMake(10, 20, 80, 80)];
    hahhView.backgroundColor = UIColor.redColor;
    [self.contentView addSubview:hahhView];
}
@end
