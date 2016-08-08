//
//  NSArray+GroupAndSortByPinyin.h
//  HXSortByLetters
//
//  Created by 韩晓 on 16/4/3.
//  Copyright © 2016年 hello. All rights reserved.
// NSArray分类：给数组按拼音分组并排序

#import <Foundation/Foundation.h>

@interface NSArray (GroupAndSortByPinyin)


/**
 *  给普通的字符串数组按拼音分组并排序
 *
 *  @param key 分组和排序的关键字（依据这个分组和排序）
 *
 *  @return 分好组、拍好序的数组
 */
- (NSArray *)groupAndSortStringArrayUsingComparator:(NSComparator)cmptr;

/**
*  给字典数组按拼音分组并排序
*
*  @param key 分组和排序的关键字（依据这个分组和排序）
*
*  @return 分好组、拍好序的数组
*/
- (NSArray *)groupAndSortDictionaryArrayByKey:(NSString *)key;

@end
