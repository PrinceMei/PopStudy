//
//  NSArray+GroupAndSortByPinyin.m
//  HXSortByLetters
//
//  Created by yaowei on 16/4/3.
//  Copyright © 2016年 hello. All rights reserved.
// NSArray分类：给数组按拼音分组并排序

#import "NSArray+GroupAndSortByPinyin.h"

@implementation NSArray (GroupAndSortByPinyin)

/**
 *  给普通的字符串数组按拼音分组并排序
 *
 *  @param key 分组和排序的关键字（依据这个分组和排序）
 *
 *  @return 分好组、拍好序的数组
 */
- (NSArray *)groupAndSortStringArrayUsingComparator:(NSComparator)cmptr {
    
    // 1、创建包含各组组名的arrM
    NSMutableArray *arrM = [NSMutableArray array];
    
    NSString *letterStr = @"a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z";
    
    [letterStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSArray *arr = [letterStr componentsSeparatedByString:@","];
    
    for (NSInteger idx = 0; idx < arr.count; idx++) {
        
        NSMutableDictionary *dicM = [NSMutableDictionary dictionaryWithObjects:@[arr[idx], [NSMutableArray array]] forKeys:@[@"title", @"list"]];
        
        [arrM addObject:dicM];
        
    }
    
    // 1.1 最后把特殊字符包含进来
    NSMutableDictionary *dicU = [NSMutableDictionary dictionaryWithObjects:@[@"#", [NSMutableArray array]] forKeys:@[@"title", @"list"]];
    [arrM addObject:dicU];
    
    
    // 2、比较第一个letter是否相同，相同的话变成一组
    for (NSString *str in self) {
        
        // 2.1 中文转拼音
        NSString *newStr = [self translateChineseToPinYinWithChineseString:str];
        newStr =  [newStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]; // 去掉两边的空格
        
        // 2.2 取出第一个字母
        NSString *firstLetter = [newStr substringToIndex:1];
        
        if ([arr containsObject:firstLetter]) {
            
            // 2.3 算出这个字母在arrM中的位置，加入对应位置的数组中
            NSInteger idx = [arr indexOfObject:firstLetter];
            [arrM[idx][@"list"] addObject:str];
            
        }
        else {
            
            // 2.4 不是字母开头的就放在@“#”组
            [arrM[26][@"list"] addObject:str];
            
        }
    }
    
    // 2.5 这时就分组完毕
    NSLog(@"%@", arrM);
    
    // 3.0 把list为空的项删掉
    NSMutableArray *destArrM = [NSMutableArray arrayWithArray:arrM];
    
    for (NSDictionary *dic in arrM) {
        
        NSMutableArray *listM = dic[@"list"];
        
        if (listM.count == 0) {
            
            [destArrM removeObject:dic];
            
        }
        
    }
    
    // 4.0 给每组排序
    for (NSMutableDictionary *dict in destArrM) {
        
//        dict[@"list"]  = [dict[@"list"] sortedArrayUsingComparator:cmptr];
        dict[@"list"] = [dict[@"list"] sortedArrayUsingComparator:^NSComparisonResult(NSString *  _Nonnull obj1, NSString *  _Nonnull obj2) {
            
            NSString *str1 = [self translateChineseToPinYinWithChineseString:obj1];
            NSString *str2 = [self translateChineseToPinYinWithChineseString:obj2];
            
            return cmptr(str1,str2);
            
        }];
        
    }
    
    return destArrM;
    
}


/**
 *  给字典数组按拼音分组并排序
 *
 *  @param key 分组和排序的关键字（依据这个分组和排序）
 *
 *  @return 分好组、拍好序的数组
 */
- (NSArray *)groupAndSortDictionaryArrayByKey:(NSString *)key {
    
    // 1、创建包含各组组名的arrM
    NSMutableArray *arrM = [NSMutableArray array];
    
    NSString *letterStr = @"a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z";
    
    [letterStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSArray *arr = [letterStr componentsSeparatedByString:@","];
    
    for (NSInteger idx = 0; idx < arr.count; idx++) {
        
        NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithObjects:@[arr[idx], [NSMutableArray array]] forKeys:@[@"title", @"list"]];
        
        [arrM addObject:dictM];
        
    }
    
    // 1.1 最后把特殊字符包含进来
    NSMutableDictionary *dicU = [NSMutableDictionary dictionaryWithObjects:@[@"#", [NSMutableArray array]] forKeys:@[@"title", @"list"]];
    [arrM addObject:dicU];
    
    // 2、分组
    // 2、比较第一个letter是否相同，相同的话变成一组
    for (NSDictionary *dict in self) {
        
        // 根据关键字分组
        NSString *str = dict[key];
        
        // 2.1 中文转拼音
        NSString *newStr = [self translateChineseToPinYinWithChineseString:str];
        newStr =  [newStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]; // 去掉两边的空格
        
        // 2.2 取出第一个字母
        NSString *firstLetter = [newStr substringToIndex:1];
        
        if ([arr containsObject:firstLetter]) {
            
            // 2.3 算出这个字母在arrM中的位置，加入对应位置的数组中
            NSInteger idx = [arr indexOfObject:firstLetter];
            [arrM[idx][@"list"] addObject:dict];
            
        }
        else {
            
            // 2.4 不是字母开头的就放在@“#”组
            [arrM[26][@"list"] addObject:dict];
            
        }
    }
    
    // 2.5 这时就分组完毕
    
    // 3.0 把list为空的项删掉
    NSMutableArray *destArrM = [NSMutableArray arrayWithArray:arrM];
    
    for (NSDictionary *dic in arrM) {
        
        NSMutableArray *listM = dic[@"list"];
        
        if (listM.count == 0) {
            
            [destArrM removeObject:dic];
            
        }
        
    }
    
    // 4.0 给每组排序
    for (NSMutableDictionary *dict in destArrM) {
        
        dict[@"list"]  = [dict[@"list"] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            
            NSString *str1 = [self translateChineseToPinYinWithChineseString:obj1[@"name"]];
            NSString *str2 = [self translateChineseToPinYinWithChineseString:obj2[@"name"]];
            
            return [str1 compare:str2 options:NSLiteralSearch];
            
        }];
        
    }

    return destArrM;
}



/**
 *  返回中文对应的pinyin
 *
 *  @param chineseString 中文字符串
 *
 *  @return 中文对应的pinyin
 */
- (NSString *)translateChineseToPinYinWithChineseString:(NSString *)chineseString {
    
    NSMutableString *ms;
    if ([chineseString length]) {
        ms = [[NSMutableString alloc] initWithString:chineseString];
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
            //            NSLog(@"pinyin: %@", ms);
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
            //            NSLog(@"pinyin: %@", ms);
        }
        
        // 字符替换在这里不起效，dont know why
        //        [ms stringByReplacingOccurrencesOfString:@"w" withString:@"2"];
        
    }
    
    return ms;
    
}



@end
