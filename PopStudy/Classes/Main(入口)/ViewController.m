//
//  ViewController.m
//  PopStudy
//
//  Created by yaowei on 16/7/28.
//  Copyright © 2016年 juku. All rights reserved.
//

#import "ViewController.h"
#import <POP.h>
#import "MenuTableViewController.h"
#import "SubLBXScanViewController.h"
#import "SlideViewController.h"
#import "CarouselViewController.h"
#import "NavChangeController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *items;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureTableView];
    self.title =@"PopStudy";
}


- (void)configureTableView{
    self.items = @[@[@"tableView 动画、搜索、索引",[MenuTableViewController class]],
                   @[@"扫描二维码界面",[SubLBXScanViewController class]],
                   @[@"头部滑动栏框架",[SlideViewController class]],
                   @[@"轮播图模块",[CarouselViewController class]],
                   @[@"NavigationBar渐变",[NavChangeController class]]
                   ];
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 50.f;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text =[self.items[indexPath.row] firstObject];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==1) {//扫码
        [self scanAction];
        return;
    }
    
    if (indexPath.row ==2) {//滑动视图
        SlideViewController *svc =[SlideViewController new];
//        svc.menuType =sliderMeunTypeTitleAndImage;//图片和文字
        svc.menuType = sliderMeunTypeTitleOnly;
        [self.navigationController pushViewController:svc animated:YES];
        return;
    }
    
    if (indexPath.row ==3) {//轮播图
        CarouselViewController *vc= [CarouselViewController new];
//         vc.title = [self titleForRowAtIndexPath:indexPath];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    //tableViewPop效果展示
    UIViewController *viewController = [self viewControllerForRowAtIndexPath:indexPath];
    viewController.title = [self titleForRowAtIndexPath:indexPath];
    [self.navigationController pushViewController:viewController animated:YES];
}




- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.items[indexPath.row] firstObject];
}

- (UIViewController *)viewControllerForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self.items[indexPath.row] lastObject] new];
}



#pragma mark -模仿qq界面
- (void)scanAction{
    //设置扫码区域参数设置
    
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //非矩形框区域颜色
    style.red_notRecoginitonArea = 247./255.;
    style.green_notRecoginitonArea = 202./255;
    style.blue_notRecoginitonArea = 15./255;
    style.alpa_notRecoginitonArea = 0.2;
    
    
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"qrcode_scan_light_green"];
    
    //SubLBXScanViewController继承自LBXScanViewController
    //添加一些扫码或相册结果处理
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style = style;
    
    vc.isQQSimulator = YES;
    vc.isVideoZoom = YES;
    [self.navigationController pushViewController:vc animated:YES];
}



//是否具有摄像机权限  不用
- (BOOL)cameraPemission
{
    
    BOOL isHavePemission = NO;
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)])
    {
        AVAuthorizationStatus permission =
        [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        switch (permission) {
            case AVAuthorizationStatusAuthorized:
                isHavePemission = YES;
                break;
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted:
                break;
            case AVAuthorizationStatusNotDetermined:
                isHavePemission = YES;
                break;
        }
    }
    
    return isHavePemission;
}



@end
