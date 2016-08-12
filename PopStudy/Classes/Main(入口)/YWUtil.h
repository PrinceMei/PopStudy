//
//  YWUtil.h
//  PopStudy
//
//  Created by yaowei on 16/8/5.
//  Copyright © 2016年 juku. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWUtil : NSObject
+ (UIColor *) colorWithHexString: (NSString *)color;
+ (float)countWidthOfString:(NSString *)string WithHeight:(float)height Font:(UIFont *)font;
@end
