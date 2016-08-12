//
//  MenuTableViewCell.m
//  PopStudy
//
//  Created by yaowei on 16/7/29.
//  Copyright © 2016年 juku. All rights reserved.
//

#import "MenuTableViewCell.h"
#import <pop/POP.h>

@implementation MenuTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.textColor = [UIColor colorWithRed:84/255.0 green:84/255.0 blue:84/255.0 alpha:1];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        self.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:20];
        self.frame =CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-25, [UIScreen mainScreen].bounds.size.height);
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    if (self.highlighted) {
        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.duration = 0.4;
        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.95, 0.95)];
        [self.textLabel pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    }else{
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
        scaleAnimation.springBounciness = 20.f;
        [self.textLabel pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    
    }

}

@end
