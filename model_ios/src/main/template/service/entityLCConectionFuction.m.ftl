<#assign entityLCConName='LCConectionFuction'>
<#assign pojoBasePackage='com.jessieray.api.mode'>
<#assign serviceBasePackage='com.jessieray.api.request'>
<#assign cacheModel=(subPackage?starts_with('cache.')||entity.cacheable)><#--缓存model，没有公共参数，CND缓存'/cache/'路径下的请求-->
//  
//  lecai 2013
//  This file（connectionFuction.m） is auto generated, do not modify it by hand
//
#import "${entity.name?cap_first}${entityLCConName}.h"
@implementation ${entity.name?cap_first}${entityLCConName}

<#function getType type>
    <#if type?starts_with('.')>
        <#return '${pojoBasePackage}${type}'>
    <#elseif type?contains('.')>
        <#return '${type}'>
    <#else>
        <#return '${type?cap_first}'>
    </#if>
</#function>
<#function getGenericType property>
    <#if property.genericType??>
        <#if property.genericType?starts_with('.')>
            <#return '<${pojoBasePackage}${property.genericType}>'>
        <#else>
            <#return '<${property.genericType}>'>
        </#if>
    <#else>
        <#return ''>
    </#if>
</#function>
<#function getGenericType4search search>
    <#if search.genericType??>
        <#if search.genericType?starts_with('.')>
            <#return '<${pojoBasePackage}${search.genericType}>'>
        <#else>
            <#return '<${search.genericType}>'>
        </#if>
    <#else>
        <#return ''>
    </#if>
</#function>
<#function toRefType type>
    <#local newType=type?lower_case>
    <#if newType='boolean'>
        <#return 'Boolean'>
    <#elseif newType='byte'>
        <#return 'Byte'>
    <#elseif newType='char'>
        <#return 'Character'>
    <#elseif newType='short'>
        <#return 'Short'>
    <#elseif newType='int'>
        <#return 'Integer'>
    <#elseif newType='long'>
        <#return 'Long'>
    <#elseif newType='float'>
        <#return 'Float'>
    <#elseif newType='double'>
        <#return 'Double'>
    <#else>
        <#return type>
    </#if>
</#function>

<#function hasUid entity queryKeyProperty>
    <#return entity.requiredUid || (queryKeyProperty!='' && queryKeyProperty.name='uid')>
</#function>

<#list entity.propertiesList as property>
<#if property.queryKey?? && property.queryKey>
    <#assign queryKeyProperty=property>
+ (void)findBy${property.name?cap_first}_${property.name}:(NSString *)_${property.name} delegate:(id)_delegate finishSelector:(SEL)_finishSEL failSelector:(SEL)_failSEL timeOutSelector:(SEL)_timeOutSEL {
     NSString *url = [NSString stringWithFormat:@"%@<#if entity.cacheable>/cache</#if>/${subPackage?replace('.','/')}/${entity.name?lower_case}/%@", K_URL_HOST, _${property.name}];
     [LTools startAsynchronousUrl:url parameter:nil method:@"GET" delegate:_delegate mappingName:@"${entity.name?cap_first}" urlCacheMode:<#if cacheModel>YES<#else>NO</#if> finishSelector:_finishSEL failSelector:_failSEL timeOutSelector:_timeOutSEL];
}
    <#break>
</#if>
</#list>

<#list entity.searchList as search>
    <#assign handleMethodName = ''>
    <#list search.itemList as item>
        <#assign handleMethodName = handleMethodName + item.name?cap_first>
        <#if item_has_next>
            <#assign handleMethodName = handleMethodName + "And">
        </#if>
    </#list>
    <#if handleMethodName?has_content><#assign handleMethodName="By"+handleMethodName></#if>
    
/**<#if search.comment??>
 * ${search.comment}
 * </#if><#list search.itemList as item>
 * @param ${item.name} 
 *           ${item.comment!''}</#list>
 */
<#if handleMethodName?has_content || (search.searchName!'')?has_content>
+ (void)find${(search.searchName!'')?cap_first}${handleMethodName?cap_first}_<#list search.itemList as item>${item.name}:(NSString *)_${item.name} </#list><#if search.pageable>page:(NSString *)_page size:(NSString *)_size </#if>delegate:(id)_delegate finishSelector:(SEL)_finishSEL failSelector:(SEL)_failSEL timeOutSelector:(SEL)_timeOutSEL {
     NSMutableString *url = [[NSMutableString alloc] init];
     [url appendFormat:@"%@<#if entity.cacheable>/cache</#if>/${subPackage?replace('.','/')}/${entity.name?lower_case}/search/find${(search.searchName!'')?cap_first}${handleMethodName?cap_first}", K_URL_HOST];
     
     NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
     <#list search.itemList as item>
     [params setObject:_${item.name} forKey:@"${item.name}"];
     </#list>
     <#if search.pageable>
     [params setObject:_page forKey:@"page"];
     [params setObject:_size forKey:@"size"];
     </#if>
     [LTools startAsynchronousUrl:url parameter:params method:@"GET" delegate:_delegate mappingName:@"${entity.name?cap_first}" urlCacheMode:<#if cacheModel>YES<#else>NO</#if> finishSelector:_finishSEL failSelector:_failSEL timeOutSelector:_timeOutSEL];
     [params release] , params = nil;
     [url release] , url = nil;
}
<#else>
+ (void)get${entity.name?cap_first}_delegate:(id)_delegate finishSelector:(SEL)_finishSEL failSelector:(SEL)_failSEL timeOutSelector:(SEL)_timeOutSEL {
     NSString *url = [NSString stringWithFormat:@"%@<#if entity.cacheable>/cache</#if>/${subPackage?replace('.','/')}/${entity.name?lower_case}", K_URL_HOST];
     [LTools startAsynchronousUrl:url parameter:nil method:@"GET" delegate:_delegate mappingName:@"${entity.name?cap_first}" urlCacheMode:<#if cacheModel>YES<#else>NO</#if> finishSelector:_finishSEL failSelector:_failSEL timeOutSelector:_timeOutSEL];
}
</#if>
</#list>

<#function getFullType item>
    <#if getGenericType4search(item)??>
        <#return '${toRefType(getType(item.type))}${getGenericType4search(item)}'>
    <#else>
        <#return '${toRefType(getType(item.type))}'>
    </#if>
</#function>

<#list entity.actionList as action>
/**<#if action.comment??>
 * ${action.comment}
 * </#if><#list action.allItemList as item>
 * @param ${item.name} 
 *           ${item.comment!''}</#list>
 */
<#if action.method="create">
+ (void)${action.actionName!'save'}_<#list action.allItemList as item>${item.name}:(NSString *)_${item.name} </#list>delegate:(id)_delegate finishSelector:(SEL)_finishSEL failSelector:(SEL)_failSEL timeOutSelector:(SEL)_timeOutSEL {
     NSMutableString *url = [[NSMutableString alloc] init];
     [url appendFormat:@"%@/${subPackage?replace('.','/')}/${entity.name?lower_case}", K_URL_HOST];
     <#if !action.root && action.actionName??>
     [url appendString:@"/${action.actionName}"];
     </#if>
     
     NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
     <#list action.allItemList as item>
     [params setObject:_${item.name} forKey:@"${item.name}"];
     </#list>
     [LTools startAsynchronousUrl:url parameter:params method:@"POST" delegate:_delegate mappingName:@"${entity.name?cap_first}" urlCacheMode:NO finishSelector:_finishSEL failSelector:_failSEL timeOutSelector:_timeOutSEL];
     [params release] , params = nil;
     [url release] , url = nil;
}

<#elseif action.method="update">
+ (void)${action.actionName!'save'}<#if queryKeyProperty??>_${queryKeyProperty.name}:(NSString *)_${queryKeyProperty.name} <#else>_</#if><#list action.allItemList as item>${item.name}:(NSString *)_${item.name} </#list>delegate:(id)_delegate finishSelector:(SEL)_finishSEL failSelector:(SEL)_failSEL timeOutSelector:(SEL)_timeOutSEL {
     NSMutableString *url = [[NSMutableString alloc] init];
     <#if queryKeyProperty??>
     [url appendFormat:@"%@/${subPackage?replace('.','/')}/${entity.name?lower_case}/%@",K_URL_HOST, _${queryKeyProperty.name}]; 
     <#else>
     [url appendFormat:@"%@/${subPackage?replace('.','/')}/${entity.name?lower_case}",K_URL_HOST];
     </#if>
     <#if !action.root && action.actionName??>
     [url appendString:@"/${action.actionName}"];
     </#if>
     NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
     <#list action.allItemList as item>
     [params setObject:_${item.name} forKey:@"${item.name}"];
     </#list>
     [LTools startAsynchronousUrl:url parameter:params method:@"PUT" delegate:_delegate mappingName:@"${entity.name?cap_first}" urlCacheMode:NO finishSelector:_finishSEL failSelector:_failSEL timeOutSelector:_timeOutSEL];
     [params release] , params = nil;
     [url release] , url = nil;
}
</#if>
</#list>

@end