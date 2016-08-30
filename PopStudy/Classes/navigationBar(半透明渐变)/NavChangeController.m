//
//  NavChangeController.m
//  PopStudy
//
//  Created by 韩晓 on 16/8/30.
//  Copyright © 2016年 juku. All rights reserved.
//

#import "NavChangeController.h"

@interface NavChangeController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong)UIView *navBackView;
@end

@implementation NavChangeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleSingleLineEtched;
    self.navBackView=[[[self.navigationController.navigationBar.subviews firstObject] subviews] firstObject];
}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    self.navBackView.alpha =0.0;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.imageView.image =[UIImage imageNamed:@"ws_leimu_pink"];
    cell.textLabel.text =@"这是测试标题";
    cell.detailTextLabel.text =@"这是测试副标题";
    return cell;
}

#pragma mark - ScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSLog(@"%f",scrollView.contentOffset.y);
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY<0) {
        //这是隐藏整个NavBar
        //        self.navigationController.navigationBar.alpha = fabs(offsetY)/64.0;
       self.navBackView.alpha = fabs(offsetY)/64.0;
        self.navigationController.navigationBar.shadowImage =[UIImage new];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        
    }else{
       self.navBackView.alpha = 0;
        //        self.navigationController.navigationBar.alpha = 0.0;
    }
}



@end
