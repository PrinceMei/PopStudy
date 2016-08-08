//
//  YWCarouselView.m
//  PopStudy
//
//  Created by 韩晓 on 16/8/8.
//  Copyright © 2016年 juku. All rights reserved.
//

#import "YWCarouselView.h"
#import "CarouselViewCell.h"
@interface YWCarouselView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView *cv;

@property (nonatomic,strong) UIPageControl *pc;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation YWCarouselView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *fl = [UICollectionViewFlowLayout new];
        //横向移动
        fl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.cv =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 200) collectionViewLayout:fl];
        self.cv.backgroundColor = [UIColor redColor];
        self.cv.pagingEnabled = YES;
        self.cv.delegate =self;
        self.cv.dataSource = self;
        [self addSubview:self.cv];
        
        [self.cv registerClass:[CarouselViewCell class] forCellWithReuseIdentifier:@"cell"];
        self.dataArr =@[@{@"title":@"中国奥运军团三金回顾",@"imageUrl":@"1.jpg"},
                        @{@"title":@"《封神传奇》进世界电影特效榜单？山寨的!",@"imageUrl":@"2.jpg"},
                        @{@"title":@"奥运男子4x100自由泳接力 菲尔普斯斩获奥运第19金",@"imageUrl":@"3.jpg"},
                        @{@"title":@"顶住丢金压力 孙杨晋级200自决赛",@"imageUrl":@"4.jpg"},
                        ];
    
        [self addPageControl];
        
    }
    return self;
}


- (void)addPageControl{
  //直接滚到中间
    [self.cv scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:5000] atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
    
    self.pc= [[UIPageControl alloc]initWithFrame:CGRectMake(0, 180, kScreenW, 10)];
    self.pc.numberOfPages = self.dataArr.count;
    self.pc.userInteractionEnabled =NO;

    [self.pc setValue:[UIImage imageNamed:@"mn_pageControl_selected"] forKey:@"_currentPageImage"];
    [self.pc setValue:[UIImage imageNamed:@"mn_pageControl"] forKey:@"_pageImage"];
    [self addSubview:self.pc];
    //自动移动
    [self beginScroll];
}


- (void)beginScroll{
    self.timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(scrollAction) userInfo:nil repeats:YES];
}


- (void)scrollAction{
    CarouselViewCell *cell = [self.cv.visibleCells firstObject];
    NSIndexPath *currentIndexPath = [self.cv indexPathForCell:cell];
    NSInteger section = currentIndexPath.section;
    NSInteger item = currentIndexPath.item+1;
    if (item == self.dataArr.count) {
        section+=1;
        item =0;
    }
    
    [self.cv scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:section] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    self.pc.currentPage =item;

}

#pragma mark -- scrollViewDelegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    int page = (int)(scrollView.contentOffset.x/kScreenW ) % self.dataArr.count;
    self.pc.currentPage = page;
    NSLog(@"%d",page);
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self.timer invalidate];
    self.timer =nil;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = (int)(scrollView.contentOffset.x/kScreenW ) % self.dataArr.count;
    self.pc.currentPage = page;
    [self beginScroll];
}



#pragma mark --collectionDataSourse

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 10000;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
   
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CarouselViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dic= self.dataArr[indexPath.row];
    cell.imageView.image =[UIImage imageNamed:dic[@"imageUrl"]];
    cell.titleLab.text =dic[@"title"];
    return cell;
}


#pragma mark -- collection布局方法
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kScreenW,200);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}


@end
