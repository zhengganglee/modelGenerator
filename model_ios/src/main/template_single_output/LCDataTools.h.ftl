//
//  LCDataTools.h
//  LeCai
//
//  This file is auto generated, do not modify it by hand
//
//

#import <Foundation/Foundation.h>
#import "LCOverRideDictionary.h"
@interface LCDataTools : NSObject{
    
}

#pragma mark --
#pragma mark Application data
<#list entityList as entity>
<#if entity.type='enum'>
//${entity.name?cap_first}=============================================================================
//彩种映射枚举到标示字典
+ (LCOverRideDictionary *)get${entity.name?cap_first}EnumToMarkedDictionary;

//彩种映射标示到枚举字典
+ (LCOverRideDictionary *)get${entity.name?cap_first}MarkedToEnumDictionary;

//彩种映射标示到彩种名称字典
+ (LCOverRideDictionary *)get${entity.name?cap_first}MarkedToRealNameDictionary;

</#if>
</#list>
//初始化彩种映射数据
+ (void)setLotteryTypeData;
@end
