//
//  YWSliderMenuView.h
//  PopStudy
//
//  Created by yaowei on 16/8/5.
//  Copyright © 2016年 juku. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,sliderMeunType) {
    sliderMeunTypeTitleOnly,
    sliderMeunTypeTitleAndImage,
};

//内部模型类，协议声明
@class YWSliderMenuStyleModel;
@protocol YWSliderMenuDelegate;

@interface YWSliderMenuView : UIView<UIScrollViewDelegate>

@property (nonatomic,strong)YWSliderMenuStyleModel *styleModel;
@property (nonatomic,weak) id<YWSliderMenuDelegate> sliderDelegate;
@property (nonatomic,readonly)NSInteger currentSelectedIndex;
//初始化
-(instancetype)initWithFrame:(CGRect)frame andStyleModel:(YWSliderMenuStyleModel *)styleModel andDelegate:(id<YWSliderMenuDelegate>)delegate andShowType:(sliderMeunType)type;

-(void)selectAtRow:(NSInteger)row andDelegate:(BOOL)delegate;


@end




@interface YWSliderMenuStyleModel : NSObject

//menu的标题数组,必传
@property (nonatomic,strong) NSArray *menuTitles;

//sliderMeunType为sliderMeunTypeTitleAndImage类型需要设置的4个属性
//未选中显示的图片数组
@property (nonatomic,strong) NSArray *menuImagesNormal;
//选中时显示的图片数组
@property (nonatomic,strong) NSArray *menuImagesSelect;
//未选中时候按钮的颜色
@property (nonatomic,strong) UIColor *sliderMenuBtnBgColorForSelect;
//选中时候按钮的颜色
@property (nonatomic,strong) UIColor *sliderMenuBtnBgColorForNormal;


//选中时候文字的颜色
@property (nonatomic,strong) UIColor *sliderMenuTextColorForSelect;
//未选中时候文字的颜色
@property (nonatomic,strong) UIColor *sliderMenuTextColorForNormal;

@property (nonatomic,strong) UIColor *lineColor;
@property (nonatomic,assign) float lineHeight;
//文字的font 默认是system size10
@property (nonatomic,strong) UIFont  *titleLableFont;

//按钮之间的间距 默认是0
@property (nonatomic,assign) float   menuHorizontalSpacing;
//按钮的宽度   默认是屏幕宽度/4 
@property (nonatomic,assign) float   menuWidth;

//适应屏幕，居中显示，只有当一个屏幕能全部显示的下的时候才有效
@property (nonatomic,assign) BOOL sizeToFitScreenWidth;

//居中显示
@property (nonatomic,assign) BOOL sizeInMiddle;

//是否根据文本的长短自动调整线条的长度
@property (nonatomic,assign) BOOL autoSuitLineViewWithdForBtnTitle;



@property (nonatomic,assign) BOOL donotScrollTapViewWhileScroll;

@property (nonatomic,assign) BOOL hideViewBottomLineView;


+ (instancetype)menuStyleModelForHome;

@end



@protocol YWSliderMenuDelegate <NSObject>

@required
//点击了某个按钮
-(void)sliderMenuDidSelectedRow:(NSInteger)row;

@optional
//重复点击按钮
-(void)sliderMenuDidReSelectedRow:(NSInteger)row;
-(void)scrollViewDidScrolled:(float)offsetX;

@end




