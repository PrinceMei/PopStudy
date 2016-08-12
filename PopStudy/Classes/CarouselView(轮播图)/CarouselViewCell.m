//
//  CarouselViewCell.m
//  PopStudy
//
//  Created by yaowei on 16/8/8.
//  Copyright © 2016年 juku. All rights reserved.
//

#import "CarouselViewCell.h"
#import "Masonry.h"
@interface CarouselViewCell()

@end

@implementation CarouselViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 200)];
        self.imageView.backgroundColor = [UIColor redColor];
        [self addSubview:self.imageView];
        
        self.titleLab = [[UILabel alloc]init];
        self.titleLab.backgroundColor = [UIColor blackColor];
        self.titleLab.alpha = 0.7;
        self.titleLab.tag =2;
        self.titleLab.textColor = [UIColor whiteColor];
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        self.titleLab.font = [UIFont systemFontOfSize:15 weight:0.5];
        self.titleLab.numberOfLines = 0;
        
        [self.imageView addSubview:self.titleLab];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imageView).offset(15);
            make.right.mas_equalTo(self.imageView).offset(-15);
            make.top.mas_equalTo(self.imageView).offset(140);
            make.height.mas_equalTo(30);
        }];
        
        
        
        
    }
    return self;
}






@end
