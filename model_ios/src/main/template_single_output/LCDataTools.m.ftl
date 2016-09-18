//
//  LCDataTools.m
//  LeCai
//
//  Created by lehecaiminib on 13-9-10.
//
//

#import "LCDataTools.h"
<#list entityList as entity>
<#if entity.type='enum'>
//${entity.name?cap_first}=============================================================================
static LCOverRideDictionary *k${entity.name?cap_first}EnumToMarkedDictionary; //彩票彩种枚举对应标示
static LCOverRideDictionary *k${entity.name?cap_first}MarkedToEnumDictionary; //彩票彩种标示对应枚举
static LCOverRideDictionary *k${entity.name?cap_first}MarkedToRealNameDictionary; //彩票彩种标示对应彩种名称

</#if>
</#list>
@implementation LCDataTools

#pragma mark --
#pragma mark Application data
<#list entityList as entity>
<#if entity.type='enum'>
//${entity.name?cap_first}=============================================================================
//彩种映射枚举到标示字典
+ (LCOverRideDictionary *)get${entity.name?cap_first}EnumToMarkedDictionary {
    if (!k${entity.name?cap_first}EnumToMarkedDictionary) {
        k${entity.name?cap_first}EnumToMarkedDictionary = [[LCOverRideDictionary alloc] init];
    }
    return k${entity.name?cap_first}EnumToMarkedDictionary;
}

//彩种映射标示到枚举字典
+ (LCOverRideDictionary *)get${entity.name?cap_first}MarkedToEnumDictionary {
    if (!k${entity.name?cap_first}MarkedToEnumDictionary) {
        k${entity.name?cap_first}MarkedToEnumDictionary = [[LCOverRideDictionary alloc] init];
    }
    return k${entity.name?cap_first}MarkedToEnumDictionary;
}

//彩种映射标示到彩种名称字典
+ (LCOverRideDictionary *)get${entity.name?cap_first}MarkedToRealNameDictionary {
    if (!k${entity.name?cap_first}MarkedToRealNameDictionary) {
        k${entity.name?cap_first}MarkedToRealNameDictionary = [[LCOverRideDictionary alloc] init];
    }
    return k${entity.name?cap_first}MarkedToRealNameDictionary;
}

</#if>
</#list>

+ (void)setLotteryTypeData {

<#list entityList as entity>
<#if entity.type='enum'>
//${entity.name?cap_first}=============================================================================
    [[LCDataTools get${entity.name?cap_first}EnumToMarkedDictionary] setValue:@"UN_KNOWN" forKey:[NSString stringWithFormat:@"%i",-3]];
    [[LCDataTools get${entity.name?cap_first}MarkedToEnumDictionary] setValue:[NSString stringWithFormat:@"%i",-3] forKey:@"UN_KNOWN"];
    [[LCDataTools get${entity.name?cap_first}MarkedToRealNameDictionary] setValue:@"未知" forKey:@"UN_KNOWN"];
    
    <#list entity.propertiesList as property>
    //${property.cnName}
    [[LCDataTools get${entity.name?cap_first}EnumToMarkedDictionary] setValue:@"${property.name}" forKey:[NSString stringWithFormat:@"%i",${property.id}]];
    [[LCDataTools get${entity.name?cap_first}MarkedToEnumDictionary] setValue:[NSString stringWithFormat:@"%i",${property.id}] forKey:@"${property.name}"];
    [[LCDataTools get${entity.name?cap_first}MarkedToRealNameDictionary] setValue:@"${(property.displayName)!property.cnName}" forKey:@"${property.name}"];

    </#list>
</#if>
</#list>
}
@end
