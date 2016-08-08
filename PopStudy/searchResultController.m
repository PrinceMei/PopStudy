//
//  searchResultController.m
//  PopStudy
//
//  Created by 韩晓 on 16/8/3.
//  Copyright © 2016年 juku. All rights reserved.
//

#import "searchResultController.h"
#import "MenuTableViewCell.h"
@interface searchResultController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation searchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textArr = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets =NO;
    self.tableVew = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.tableVew.dataSource =self;
    self.tableVew.delegate = self;
    [self.view addSubview:self.tableVew];
    [self.tableVew registerClass:[MenuTableViewCell  class] forCellReuseIdentifier:@"cell"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.textArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"forIndexPath:indexPath];
    cell.textLabel.text =self.textArr[indexPath.row];
    return cell;
}


@end
