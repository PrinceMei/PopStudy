//
//  MenuTableViewController.m
//  PopStudy
//
//  Created by yaowei on 16/7/29.
//  Copyright © 2016年 juku. All rights reserved.
//

#import "MenuTableViewController.h"
#import "MenuTableViewCell.h"
#import "NSArray+GroupAndSortByPinyin.h"
#import "searchResultController.h"
@interface MenuTableViewController ()<UISearchResultsUpdating,UISearchBarDelegate>
@property (nonatomic,strong) NSArray *items;
@property (nonatomic,strong) UISearchController *searchController;
@property (nonatomic,strong) searchResultController *resultContrller;
@property (nonatomic,strong)  NSArray *originalArr;
@end
static NSString *const KCellIdentifier =@"cellIdentifier";
@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"PopStudy";
    [self configureSearchBar];
    [self configureTableView];
    [self configureTitleView];
}



- (void)configureSearchBar{
    self.resultContrller = [searchResultController new];
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:self.resultContrller];
    //协议 用来处理搜索内容更新时的操作
    self.searchController.searchResultsUpdater = self;
    //隐藏之前内容
    self.searchController.dimsBackgroundDuringPresentation =NO;
    self.searchController.searchBar.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 44.0);
    //显示在NavigationBar的下面
//    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.tableView.tableHeaderView = self.searchController.searchBar;
}



- (void)configureTableView{

    self.originalArr  = @[@"姚明",@"张三",@"李四",@"王五",@"赵六",@"田七",@"安迪",@"小花",@"鲍蕾",@"火种",@"笼子",@"姚明",@"张三",@"李四",@"王五",@"赵六",@"田七",@"安迪",@"小花",@"鲍蕾",@"火种",@"笼子"];
    
    [self.tableView registerClass:[MenuTableViewCell class] forCellReuseIdentifier:KCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.rowHeight = 50.f;
    
    
    
   self.items =  [self.originalArr groupAndSortStringArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if (obj1  > obj2 ) {
            return NSOrderedDescending;
        }
        if (obj1  < obj2 ) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
    
    self.tableView.sectionIndexBackgroundColor =[UIColor grayColor];
       //改变索引的颜色
    self.tableView.sectionIndexColor = [UIColor purpleColor];
       //改变索引选中的背景颜色
    self.tableView.sectionIndexTrackingBackgroundColor = [UIColor redColor];
    
}

-(void)configureTitleView{
    UILabel *headlineLabel = [UILabel new];
    headlineLabel.font = [UIFont fontWithName:@"Avenir-Light" size:28];
    headlineLabel.textAlignment = NSTextAlignmentCenter;
    headlineLabel.textColor = [UIColor colorWithRed:84/255.0 green:84/255.0 blue:84/255.0 alpha:1];
    NSMutableAttributedString *attrutedString = [[NSMutableAttributedString alloc] initWithString:self.title];
    [attrutedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:84/255.0 green:84/255.0 blue:84/255.0 alpha:1] range:NSMakeRange(1, 1)];
    headlineLabel.attributedText =attrutedString;
    [headlineLabel sizeToFit];
    self.navigationItem.titleView = headlineLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSDictionary *dic = self.items[section];
    NSArray *arr = dic[@"list"];
    return arr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier forIndexPath:indexPath];
       NSDictionary *dic = self.items[indexPath.section];
    NSArray *arr = dic[@"list"];
    cell.textLabel.text = arr[indexPath.row];
    return cell;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
   
    NSDictionary *dic = self.items[section];
    return dic[@"title"];
}


//右边索引 字节数(如果不实现 就不显示右侧索引)
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    NSMutableArray *arr =[NSMutableArray array];
    for (NSDictionary *dic in self.items) {
        NSString *str = dic[@"title"];
        [arr addObject:str];
    }
    return arr;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;{
    NSLog(@"title = %@,index = %ld",title,index);

    
    return index;
}


#pragma mark - UISearchBarDelegate
//把中文转成拼音 做模糊搜索
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    [self.resultContrller.textArr removeAllObjects];
    NSString *keyStr =[self translateChineseToPinYinWithChineseString:searchController.searchBar.text];
    if (keyStr.length >0) {
        for (NSString *tempStr in self.originalArr) {
            NSString *pinyinStr =[self translateChineseToPinYinWithChineseString:tempStr];
            NSRange titleResult=[pinyinStr rangeOfString:keyStr options:NSCaseInsensitiveSearch];
            
            if (titleResult.length>0) {
                [self.resultContrller.textArr addObject:tempStr];
            }
            
        }
    }
    

    [self.resultContrller.tableVew reloadData];
}





-(void)hasChinese:(NSString *)str{
    
    for (int i=0;i<str.length;i++) {
        NSRange range=NSMakeRange(i,1);
        NSString *subString=[str substringWithRange:range];
        const char *cString=[subString UTF8String];
        
        if (strlen(cString)==3) {
            NSLog(@"第i是汉字");
        }else if(strlen(cString)==1) {
            NSLog(@"第i是字母");
        }
        
    }
}



/**
 *  返回中文对应的pinyin
 *
 *  @param chineseString 中文字符串
 *
 *  @return 中文对应的pinyin
 */
- (NSString *)translateChineseToPinYinWithChineseString:(NSString *)chineseString {
    
    NSMutableString *ms;
    if ([chineseString length]) {
        ms = [[NSMutableString alloc] initWithString:chineseString];
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
            //            NSLog(@"pinyin: %@", ms);
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
            //            NSLog(@"pinyin: %@", ms);
        }
        
        // 字符替换在这里不起效，dont know why
        //        [ms stringByReplacingOccurrencesOfString:@"w" withString:@"2"];
        
    }
    
    return ms;
    
}




@end
