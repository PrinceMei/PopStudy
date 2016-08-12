//
//  YWSliderMenuView.m
//  PopStudy
//
//  Created by yaowei on 16/8/5.
//  Copyright © 2016年 juku. All rights reserved.
//

#import "YWSliderMenuView.h"
#define sliderBtnTagStartPoint 1000
@interface YWSliderMenuView()
@property (nonatomic,assign) NSInteger curSelectRow;
@property (nonatomic,strong) UIView *bottomTabLine;
@property (nonatomic,assign) sliderMeunType menuType;
@property (nonatomic,strong) UIScrollView *contentScrollView;
@end


@implementation YWSliderMenuView
-(instancetype)initWithFrame:(CGRect)frame andStyleModel:(YWSliderMenuStyleModel *)styleModel andDelegate:(id<YWSliderMenuDelegate>)delegate andShowType:(sliderMeunType)type{
   self =  [super initWithFrame:frame];
    if (self) {
        _styleModel=styleModel;
        _curSelectRow =-1;
        _menuType =type;
        _sliderDelegate =delegate;
        [self initSliderTopView:type];
    }
    return self;
}

-(void)initSliderTopView:(sliderMeunType)type{

    _contentScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_contentScrollView];
    NSAssert(_styleModel.menuTitles, @"顶部活动栏标题为空");
    
    if (type == sliderMeunTypeTitleAndImage) {//标题、图片
        if(!_styleModel.menuImagesNormal) {
            NSAssert(0, @"sliderMenuTypeTitleAndImage却未传入未选中的显示图片数组?");
        }
        if (!_styleModel.menuImagesSelect) {
            NSAssert(0, @"sliderMenuTypeTitleAndImage却未传入选中时的显示图片数组?");
        }
        
        if(_styleModel.menuTitles.count<_styleModel.menuImagesNormal.count||_styleModel.menuTitles.count<_styleModel.menuImagesSelect.count) {
            NSAssert(0, @"标题和图片的数量不一致!");
        }
        
    }

        if (!_styleModel.sliderMenuBtnBgColorForNormal) {
            _styleModel.sliderMenuBtnBgColorForNormal = RGB(140, 140, 140);
        }
        if (!_styleModel.sliderMenuTextColorForSelect) {
            _styleModel.sliderMenuTextColorForSelect = YMSBrandColor;
        }
        if (!_styleModel.titleLableFont) {
            _styleModel.titleLableFont  = defaultFont(12);
        }
        if (_styleModel.menuWidth <=0) {
            _styleModel.menuWidth = kScreenW /4.f;
        }
        if (_styleModel.menuHorizontalSpacing<=0 ) {
            _styleModel.menuHorizontalSpacing = 0.f;
        }
        
        _contentScrollView.showsHorizontalScrollIndicator =NO;
        _contentScrollView.showsVerticalScrollIndicator =NO;
        //点击状态栏 控件滚回至顶部
        _contentScrollView.scrollsToTop =NO;
        _contentScrollView.bounces = YES;
        _contentScrollView.delegate =self;
        _contentScrollView.contentSize =CGSizeMake((_styleModel.menuWidth +_styleModel.menuHorizontalSpacing)*_styleModel.menuTitles.count+ _styleModel.menuHorizontalSpacing,0);
        
        if (_styleModel.sizeToFitScreenWidth||_styleModel.sizeInMiddle) {
            _contentScrollView.scrollEnabled = NO;
        }
        
        for (int i =0; i<_styleModel.menuTitles.count; i++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((_styleModel.menuHorizontalSpacing+_styleModel.menuWidth)*i, 0, _styleModel.menuWidth, _contentScrollView.frame.size.height)];
            btn.center =CGPointMake(btn.center.x,_contentScrollView.frame.size.height/2.0f);
            [btn addTarget:self action:@selector(sliderBtnSelectEvent:) forControlEvents:UIControlEventTouchUpInside];
            //取消btn点击效果
            btn.adjustsImageWhenHighlighted =NO;
            btn.selected=i==0?YES:NO;
            btn.tag =sliderBtnTagStartPoint+i;
            [btn setTitle:_styleModel.menuTitles[i] forState:UIControlStateNormal];
            [btn setTitle:_styleModel.menuTitles[i] forState:UIControlStateSelected];
            [btn setTitleColor:_styleModel.sliderMenuBtnBgColorForNormal forState:UIControlStateNormal];
            [btn setTitleColor:_styleModel.sliderMenuBtnBgColorForSelect forState:UIControlStateSelected];
            btn.titleLabel.font = _styleModel.titleLableFont;
            [_contentScrollView addSubview:btn];
            
            if (_styleModel.sizeToFitScreenWidth) {
                float leftGap =_styleModel.menuWidth+70.f;
                btn.center =CGPointMake(_contentScrollView.bounds.size.width /2.f-((int)(_styleModel.menuTitles.count/2)-i)*leftGap, btn.center.y);
                
            }
            
            if (_styleModel.sizeInMiddle) {
                
                btn.center=CGPointMake(_contentScrollView.bounds.size.width/2.f + (float)(i-(_styleModel.menuTitles.count - 1.f)/2.f)* (_styleModel.menuWidth + _styleModel.menuHorizontalSpacing/2.f), btn.center.y);
            }
            
            
            if (type == sliderMeunTypeTitleAndImage) {
                [btn setImage:_styleModel.menuImagesNormal[i] forState:UIControlStateNormal];
                [btn setImage:_styleModel.menuImagesSelect[i] forState:UIControlStateSelected];
                CGRect imgBounds = btn.imageView.bounds;
                UIEdgeInsets imgInsets = UIEdgeInsetsZero;
                UIEdgeInsets titleInsets = UIEdgeInsetsZero;
                imgInsets.bottom = btn.frame.size.height / 2 -10;
                imgInsets.right = (btn.frame.size.width - imgBounds.size.width)/2;
                imgInsets.left = (btn.frame.size.width - imgBounds.size.width)/2;
                titleInsets.top = btn.frame.size.height / 2 ;
                titleInsets.left =-imgBounds.size.width;
                [btn setImageEdgeInsets:imgInsets];
                [btn setTitleEdgeInsets:titleInsets];

                
            }
        }
        
        
        if (type == sliderMeunTypeTitleOnly) {
            _bottomTabLine = [[UIView alloc] initWithFrame:CGRectMake(_styleModel.menuHorizontalSpacing, 0, _styleModel.menuWidth, _styleModel.lineHeight>0?_styleModel.lineHeight:2)];
           
            CGRect frame = _bottomTabLine.frame;
            frame.origin.y = _contentScrollView.bounds.size.height-_bottomTabLine.frame.size.height;
            _bottomTabLine.frame =frame;
            
            _bottomTabLine.backgroundColor = _styleModel.lineColor?_styleModel.lineColor:_styleModel.sliderMenuTextColorForSelect;
            [_contentScrollView addSubview:_bottomTabLine];
            
            if (_styleModel.sizeToFitScreenWidth) {
                CGRect frame = _bottomTabLine.frame;
                UIButton *btn = (UIButton *)[_contentScrollView viewWithTag:sliderBtnTagStartPoint+0];
                frame.origin.x =btn.frame.origin.x;
                _bottomTabLine.frame = frame;
            }
           
             [self selectAtRow:0 andDelegate:NO];
            
            
        }
        
        
        if (!_styleModel.hideViewBottomLineView) {
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 0.5f)];
            lineView.backgroundColor =YMSLineViewColor;
            self.clipsToBounds =NO;
            [self addSubview:lineView];
        }
        
    
    
}


-(void)selectAtRow:(NSInteger)row andDelegate:(BOOL)delegate{

    if (row>_styleModel.menuTitles.count -1 || row<0) {
        return;
    }
    if (row  == _curSelectRow) {//重复点击
        if (delegate && [_sliderDelegate respondsToSelector:@selector(sliderMenuDidReSelectedRow:)]) {
            [_sliderDelegate sliderMenuDidReSelectedRow:row];
        }
        return;
    }
    
    if(delegate&&[_sliderDelegate respondsToSelector:@selector(sliderMenuDidSelectedRow:)]) {
        [_sliderDelegate sliderMenuDidSelectedRow:row];
    }

    
    UIButton *unSelectBtn  = (UIButton *)[_contentScrollView viewWithTag:(_curSelectRow= _curSelectRow==-1?0:_curSelectRow) +sliderBtnTagStartPoint];
    UIButton *selectBtn=(UIButton *)[_contentScrollView viewWithTag:row+sliderBtnTagStartPoint];
    if (_menuType==sliderMeunTypeTitleOnly) {
        [UIView animateWithDuration:ABS(row-_curSelectRow)*0.1 delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            if (_styleModel.autoSuitLineViewWithdForBtnTitle) {
                float width = [YWUtil countWidthOfString:_styleModel.menuTitles[row] WithHeight:100 Font:_styleModel.titleLableFont];
                _bottomTabLine.frame = CGRectMake(_bottomTabLine.frame.origin.x, _bottomTabLine.frame.origin.y, width, _bottomTabLine.frame.size.height);
            }
            _bottomTabLine.center =CGPointMake(selectBtn.center.x, _bottomTabLine.center.y);
            
        } completion:^(BOOL finished) {
            unSelectBtn.selected=NO;
            selectBtn.selected=YES;
        }];
    }else {
        unSelectBtn.selected=NO;
        selectBtn.selected=YES;
    }
    
    
    _curSelectRow=row;
    _currentSelectedIndex = _curSelectRow;
    
    [self adjustToScrollView:_curSelectRow];

}


//点击后适当滚动以适应
- (void)adjustToScrollView :(NSInteger)row {
    
    if (_styleModel.donotScrollTapViewWhileScroll) {
        return;
    }
    
    UIButton *selectBtn=(UIButton *)[_contentScrollView viewWithTag:row+sliderBtnTagStartPoint];
    
    if(_styleModel.sizeToFitScreenWidth) {
        
    }else {
        float offsetx = selectBtn.frame.origin.x - _contentScrollView.frame.size.width/2.f+ _styleModel.menuWidth/2.f;
        offsetx=offsetx<0?0:offsetx;
        offsetx = offsetx+_contentScrollView.frame.size.width>(_contentScrollView.contentSize.width)?_contentScrollView.contentSize.width-_contentScrollView.frame.size.width:offsetx;
        [_contentScrollView setContentOffset:CGPointMake(offsetx, _contentScrollView.contentOffset.y) animated:YES];
    }
    
}

- (void)sliderBtnSelectEvent:(UIButton *)sender {
    [self selectAtRow:sender.tag-sliderBtnTagStartPoint andDelegate:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([_sliderDelegate respondsToSelector:@selector(scrollViewDidScrolled:)]) {
        [_sliderDelegate scrollViewDidScrolled:scrollView.contentOffset.x];
    }
}



@end


@implementation YWSliderMenuStyleModel


+ (instancetype)menuStyleModelForHome {
    YWSliderMenuStyleModel *model       = [YWSliderMenuStyleModel new];
    model.sizeToFitScreenWidth             = YES;
    model.hideViewBottomLineView           = YES;
    model.titleLableFont                   = defaultFont(17);
    model.lineHeight                       = 4.f;
    model.sliderMenuTextColorForNormal     = YMSNavTitleColor;
    model.sliderMenuTextColorForSelect     = YMSNavTitleColor;
    model.lineColor                        = YMSBrandColor;
    model.autoSuitLineViewWithdForBtnTitle = YES;
    model.sizeInMiddle                     = YES;
    model.menuHorizontalSpacing            = 40.f;
    
    return model;
}

@end


