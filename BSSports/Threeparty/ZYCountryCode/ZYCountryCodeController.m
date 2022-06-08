//
//  ZYCountryCodeController.m
//   Wayii
//
//  Created by zy on 2021/8/13.
//

#import "ZYCountryCodeController.h"
#import "ZYIndexView.h"

@interface ZYCountryCodeController () <UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,UISearchControllerDelegate,ZYIndexDelegate> {
    UITableView *_tableView;
    UISearchController *_searchController;
    NSDictionary *_sortedNameDict;
    NSArray *_indexArray;
    NSMutableArray *_results;
}
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) ZYIndexView *indexView;
@property (nonatomic, strong) UILabel * typeLabel;

@end

@implementation ZYCountryCodeController



#pragma mark - system
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DarkCorWhithe;
    self.backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.backButton setImage:[UIImage imageNamed:@"ZY_Login_back"] forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    [self.backButton addTarget:self action:@selector(backButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    
//    [self.navigationController.navigationBar navBarBackGroundColor:DarkCorWhithe image:nil isOpaque:NO];
//    [self.navigationController.navigationBar navBarBottomLineHidden:YES];
    
    [self creatSubviews];
    
}

- (void)backButtonAction {
    
    if (self.backBlock) {
        self.backBlock();
    }
    
}


#pragma mark - private
 //创建子视图
- (void)creatSubviews {
    
    
    _results = [NSMutableArray arrayWithCapacity:1];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight - 20) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 44.0;
    _tableView.backgroundColor = UIColor.clearColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.sectionIndexColor = DarkCor153153153;
    _tableView.sectionFooterHeight = 0;

    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.delegate = self;
    _searchController.obscuresBackgroundDuringPresentation = NO;
    _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, _searchController.searchBar.bounds.size.height)];
    [headerView addSubview:_searchController.searchBar];
    headerView.backgroundColor = DarkCorWhithe;
    _tableView.tableHeaderView = headerView;

    //判断当前系统语言
//    if (LanguageIsEnglish) {
//        NSString *plistPathEN = [[NSBundle mainBundle] pathForResource:@"sortedNameEN" ofType:@"plist"];
//        _sortedNameDict = [[NSDictionary alloc] initWithContentsOfFile:plistPathEN];
//    } else {
        NSString *plistPathCH = [[NSBundle mainBundle] pathForResource:@"sortedNameCH" ofType:@"plist"];
        _sortedNameDict = [[NSDictionary alloc] initWithContentsOfFile:plistPathCH];
//    }

    _indexArray = [[NSArray alloc] initWithArray:[[_sortedNameDict allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }]];
    

    self.indexView = [[ZYIndexView alloc] initWithFrame:CGRectMake(kScreenWidth - 30,110, 30,100)];
    self.indexView.delegate = self;
    self.indexView.backgroundColor = [UIColor redColor];
    [self.view addSubview: self.indexView];
    [ self.indexView setIndexes:_indexArray];
    

    
}

- (NSString *)showCodeStringIndex:(NSIndexPath *)indexPath {
    NSString *showCodeSting;
    if (_searchController.isActive) {
        if (_results.count > indexPath.row) {
            showCodeSting = [_results objectAtIndex:indexPath.row];
        }
    } else {
        if (_indexArray.count > indexPath.section) {
            NSArray *sectionArray = [_sortedNameDict valueForKey:[_indexArray objectAtIndex:indexPath.section]];
            if (sectionArray.count > indexPath.row) {
                showCodeSting = [sectionArray objectAtIndex:indexPath.row];
            }
        }
    }
    return showCodeSting;
}

- (void)selectCodeIndex:(NSIndexPath *)indexPath {
    
    NSString * originText = [self showCodeStringIndex:indexPath];
    NSArray  * array = [originText componentsSeparatedByString:@"+"];
    NSString * countryName = [array.firstObject stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString * code = array.lastObject;
    
    if (self.deleagete && [self.deleagete respondsToSelector:@selector(returnCountryName:code:)]) {
        [self.deleagete returnCountryName:countryName code:code];
    }
    
    if (self.returnCountryCodeBlock != nil) {
        self.returnCountryCodeBlock(countryName,code);
    }
    
    _searchController.active = NO;
    [_searchController.searchBar resignFirstResponder];
    
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
    
    NSLog(@"选择国家: %@   代码: %@",countryName,code);
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
   
    if (_results.count > 0) {
        [_results removeAllObjects];
    }
    NSString *inputText = searchController.searchBar.text;
    __weak __typeof(self)weakSelf = self;
    [_sortedNameDict.allValues enumerateObjectsUsingBlock:^(NSArray * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj containsString:inputText]) {
                __strong __typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf->_results addObject:obj];
            }
        }];
    }];
    [_tableView reloadData];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_searchController.isActive) {
        return 1;
    } else {
        return [_sortedNameDict allKeys].count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_searchController.isActive) {
         return [_results count];
    } else {
        if (_indexArray.count > section) {
            NSArray *array = [_sortedNameDict objectForKey:[_indexArray objectAtIndex:section]];
            return array.count;
        }
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.textColor = DarkCor515151;
        
    }
    cell.backgroundColor = DarkCorWhithe;
    cell.textLabel.text = [self showCodeStringIndex:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *lineLabel = [UILabel new];
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    [cell.contentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(cell.contentView).offset(12);
        make.bottom.mas_equalTo(cell.contentView).offset(-1);
        make.width.offset(kScreenWidth - 12 - 36);
        make.height.offset(1);
        
    }];
    
    
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    
    if (_searchController.isActive) {
        return 0;
    } else {
    
        return 44;

    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
        
       
    UIView *vv = [UIView new];
    vv.backgroundColor = DarkCorWhithe;
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth - 40,44)];
    if (_indexArray.count > section) {
        self.typeLabel.text = [NSString stringWithFormat:@"%@",[_indexArray objectAtIndex:section]];
    }
    self.typeLabel.textColor = DarkCor153153153;
    self.typeLabel.font = [UIFont systemFontOfSize:14];
    [vv addSubview:self.typeLabel];
        
    return vv;
    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.indexView.onTouch) return;
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:scrollView.contentOffset];
    if (indexPath) {
        [self.indexView setSelectedLabel:indexPath.section];
    }
}




- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_indexArray.count && _indexArray.count > section) {
        return [_indexArray objectAtIndex:section];
    }
    return nil;
}

#pragma mark - 选择国际获取代码
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self selectCodeIndex:indexPath];
}



#pragma mark - TTIndexBarDelegate

- (void)indexDidChanged:(ZYIndexView *)indexBar index:(NSInteger)index title:(NSString *)title {
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}






- (void)willPresentSearchController:(UISearchController *)searchController {
    self.indexView.hidden = YES;
}
- (void)didPresentSearchController:(UISearchController *)searchController {
    
}
- (void)willDismissSearchController:(UISearchController *)searchController{
    self.indexView.hidden = NO;
}






@end
