//
//  ContentViewController.m
//  PopStudy
//
//  Created by 韩晓 on 16/8/5.
//  Copyright © 2016年 juku. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    
}

- (void)initView {
    self.view.backgroundColor = RGB(arc4random() % 255, arc4random() % 255, arc4random() % 255);
    UILabel *lable= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenW  , 200)];
    lable.center= CGPointMake(kScreenW/2, (kScreenH-50-64)/2);
    lable.textAlignment= NSTextAlignmentCenter;
    lable.font= defaultFont(100);
    lable.text= [NSString stringWithFormat:@"%i",self.index];
    lable.textColor= [UIColor whiteColor];
    [self.view addSubview:lable];
}

@end
