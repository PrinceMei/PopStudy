//
//  CarouselViewController.m
//  PopStudy
//
//  Created by 韩晓 on 16/8/8.
//  Copyright © 2016年 juku. All rights reserved.
//

#import "CarouselViewController.h"
#import "YWCarouselView.h"
@interface CarouselViewController ()

@end

@implementation CarouselViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets =NO;
    self.view.backgroundColor =YMSBrandColor;
    YWCarouselView *cv = [[YWCarouselView alloc]initWithFrame:CGRectMake(0, 60, kScreenW, 200)];
    [self.view addSubview:cv];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
