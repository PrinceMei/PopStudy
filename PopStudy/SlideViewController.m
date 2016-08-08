//
//  SlideViewController.m
//  PopStudy
//
//  Created by 韩晓 on 16/8/5.
//  Copyright © 2016年 juku. All rights reserved.
//

#import "SlideViewController.h"
#import "ContentViewController.h"
@interface SlideViewController ()<YWSliderMenuDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) YWSliderMenuView *sliderMenu;
@property (nonatomic,strong) UIScrollView * contentScrollView;
@property (nonatomic,strong) NSMutableDictionary *listVCdic;
@property (nonatomic,assign) NSInteger menuCount;
@end

@implementation SlideViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"SliderView";
    self.menuCount =10;
    [self initView];
    
}


-(void)initView{
    //第一个子视图为scrollView或者其子类的时候 会自动设置 inset为64 这样navSliderMenu会被下移
    self.automaticallyAdjustsScrollViewInsets =NO;
    YWSliderMenuStyleModel *model = [YWSliderMenuStyleModel new];
    NSMutableArray *titleArr = [NSMutableArray array];
    NSMutableArray *normaImageArr = [NSMutableArray  array];
    NSMutableArray *selsectImageArr = [NSMutableArray array];
    
    for (int i= 0; i<self.menuCount; i++) {
        [titleArr addObject:[NSString stringWithFormat:@"标题%i",i]];
        [normaImageArr addObject:[UIImage imageNamed:@"ws_leimu_gray"]];
        [selsectImageArr addObject:[UIImage imageNamed:@"ws_leimu_pink"]];
    }
    
    model.menuTitles = [titleArr copy];
    
    if (self.menuType == sliderMeunTypeTitleAndImage) {
        model.menuImagesNormal = [normaImageArr copy];
        model.menuImagesSelect = [selsectImageArr copy];
        
    }
    
    
    //下面的几个都可以不设置也可以定制
    //    model.sliderMenuTextColorForNormal = QHRGB(140, 140, 140);
    //    model.sliderMenuTextColorForSelect = QHRGB(226, 12, 12);
    //    model.titleLableFont               = defaultFont(12);
    //    model.menuWidth                    = QHScreenWidth /4.f;
    //    model.menuHorizontalSpacing        = 0.f;
    
    self.sliderMenu = [[YWSliderMenuView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, 50) andStyleModel:model andDelegate:self andShowType:self.menuType];
    self.sliderMenu.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.sliderMenu];
    
    
    //example 用于滑动的滚动视图
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.sliderMenu.frame.origin.y+self.sliderMenu.frame.size.height, kScreenW, kScreenH-self.sliderMenu.frame.origin.y+self.sliderMenu.frame.size.height)];
    self.contentScrollView.contentSize = (CGSize){kScreenW*self.menuCount,self.contentScrollView.contentSize.height};
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.delegate      = self;
    self.contentScrollView.scrollsToTop  = NO;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.contentScrollView];
    
    [self addListVCWithIndex:0];
    
    
}

-(void)sliderMenuDidSelectedRow:(NSInteger)row{

    //让scrollview滚到相应的位置
    [self.contentScrollView setContentOffset:CGPointMake(row*kScreenW, self.contentScrollView.contentOffset.y)  animated:NO];
}


#pragma mark scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //用scrollView的滑动大小与屏幕宽度取整数 得到滑动的页数
    [self.sliderMenu selectAtRow:(int)((scrollView.contentOffset.x+kScreenW/2.f)/kScreenW) andDelegate:NO];
    //根据页数添加相应的视图
    [self addListVCWithIndex:(int)(scrollView.contentOffset.x/kScreenW)];
    [self addListVCWithIndex:(int)(scrollView.contentOffset.x/kScreenW)+1];
    
}



- (void)addListVCWithIndex:(NSInteger)index {
    if (!self.listVCdic) {
        self.listVCdic=[[NSMutableDictionary alloc] init];
    }
    if (index<0||index>=self.menuCount) {
        return;
    }
    //根据页数添加相对应的视图 并存入数组
    
    if (![self.listVCdic objectForKey:@(index)]) {
        ContentViewController * contentViewController = [ContentViewController new];
        contentViewController.index = (int)index;
        [self addChildViewController:contentViewController];
        
        contentViewController.view.frame = CGRectMake(index*kScreenW, 0, contentViewController.view.bounds.size.width, contentViewController.view.bounds.size.height);

        [self.contentScrollView addSubview:contentViewController.view];
        [self.listVCdic setObject:contentViewController forKey:@(index)];
    }
}

@end
