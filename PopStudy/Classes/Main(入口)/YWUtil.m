//
//  YWUtil.m
//  PopStudy
//
//  Created by yaowei on 16/8/5.
//  Copyright © 2016年 juku. All rights reserved.
//

#import "YWUtil.h"

@implementation YWUtil

+ (UIColor *) colorWithHexString: (NSString *)color{
    return [YWUtil colorWithHexString:color alpha:1.f];
}

+ (UIColor *) colorWithHexString: (NSString *)color alpha:(float)alpha{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6) {
        MSLog(@"输入的16进制有误，不足6位！");
        return [UIColor clearColor];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}



+ (float)countWidthOfString:(NSString *)string WithHeight:(float)height Font:(UIFont *)font {
  
    CGSize constraintSize = CGSizeMake(MAXFLOAT, height);
    CGSize labelSize = [string sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
    return labelSize.width;
}
@end
