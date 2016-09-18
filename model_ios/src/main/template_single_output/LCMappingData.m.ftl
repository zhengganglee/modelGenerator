//
//  LCMappingData.m
//  sdsd
//
//  Created by lehecaiminib on 13-9-10.
//  Copyright (c) 2013年 lehecaiminib. All rights reserved.
//

#import "LCMappingData.h"
#import "LCRKObjectMapping.h"

@implementation LCMappingData
+ (RKObjectMapping *)defualtMappingAdd:(RKObjectMapping *)_mapping mappingName:(NSString *)_name {
    RKObjectMapping *firstMapping = [RKObjectMapping mappingForClass:[LCAPIResult class]];
    [firstMapping addAttributeMappingsFromDictionary:@{ @"code": @"code",
     @"message": @"message",@"whiteList": @"whiteList",@"blackList": @"blackList",@"serverTime": @"serverTime",@"serverTimeMillis": @"serverTimeMillis"}];
    RKObjectMapping *secondMapping = [RKObjectMapping mappingForClass:[LCAPIResultData class]];
    [secondMapping addAttributeMappingsFromDictionary:@{ @"rows": @"rows",
     @"total": @"total"}];
    RKObjectMapping *ThirdMapping = [RKObjectMapping mappingForClass:[LCAPIResultUpData class]];
    [ThirdMapping addAttributeMappingsFromDictionary:@{ @"policy": @"policy",
     @"newVersion": @"newVersion",@"updateLog": @"updateLog",@"downloadUrl": @"downloadUrl"}];
    [firstMapping addRelationshipMappingWithSourceKeyPath:@"data" mapping:secondMapping];
    [firstMapping addRelationshipMappingWithSourceKeyPath:@"updateInfo" mapping:ThirdMapping];
    [secondMapping addRelationshipMappingWithSourceKeyPath:_name mapping:_mapping];
    return firstMapping;
}

+ (void)setAllMappingModel {
<#list entityList as entity>
<#if entity.type='object'>
//${entity.name?cap_first}=============================================================================

    
    LCRKObjectMapping *${entity.name?uncap_first}ModelMapping = [[LCRKObjectMapping alloc] customAddPropertyListFromClass:[${entity.name?cap_first} class]];
    RKResponseDescriptor *${entity.name?uncap_first}ResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[LCMappingData defualtMappingAdd:${entity.name?uncap_first}ModelMapping mappingName:@"modelList"] method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [[LTools getAllMappingDictionary] setObject:${entity.name?uncap_first}ResponseDescriptor forKey:@"${entity.name}"];
    
    /*
    RKObjectMapping *${entity.name?uncap_first}ModelMapping = [RKObjectMapping mappingForClass:[${entity.name?cap_first} class]];
    [${entity.name?uncap_first}ModelMapping addAttributeMappingsFromDictionary:@{
    <#list entity.propertiesList as property>@"${property.name}":@"${property.name}"<#if property_has_next>, </#if></#list>
    }];
    RKResponseDescriptor *${entity.name?uncap_first}ResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[LCMappingData defualtMappingAdd:${entity.name?uncap_first}ModelMapping mappingName:@"modelList"] method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [[LTools getAllMappingDictionary] setObject:${entity.name?uncap_first}ResponseDescriptor forKey:@"${entity.name}"];
    */
</#if>
</#list>
}
@end
