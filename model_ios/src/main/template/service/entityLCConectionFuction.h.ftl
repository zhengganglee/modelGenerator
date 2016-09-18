<#assign entityLCConName='LCConectionFuction'>
<#assign pojoBasePackage='com.jessieray.api.mode'>
<#assign serviceBasePackage='com.jessieray.api.request'>
//  
//  lecai 2013
//  This file（connectionFuction.h） is auto generated, do not modify it by hand
//

#import <Foundation/Foundation.h>

@interface ${entity.name?cap_first}${entityLCConName} : NSObject

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
<#list entity.propertiesList as property>
<#if property.queryKey?? && property.queryKey>
+ (void)findBy${property.name?cap_first}_${property.name}:(NSString *)_${property.name} delegate:(id)_delegate finishSelector:(SEL)_finishSEL failSelector:(SEL)_failSEL timeOutSelector:(SEL)_timeOutSEL;
    <#assign queryKeyProperty=property>
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
+ (void)find${(search.searchName!'')?cap_first}${handleMethodName?cap_first}_<#list search.itemList as item>${item.name}:(NSString *)_${item.name} </#list><#if search.pageable>page:(NSString *)_page size:(NSString *)_size </#if>delegate:(id)_delegate finishSelector:(SEL)_finishSEL failSelector:(SEL)_failSEL timeOutSelector:(SEL)_timeOutSEL;
<#else>
+ (void)get${entity.name?cap_first}_delegate:(id)_delegate finishSelector:(SEL)_finishSEL failSelector:(SEL)_failSEL timeOutSelector:(SEL)_timeOutSEL;
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
+ (void)${action.actionName!'save'}_<#list action.allItemList as item>${item.name}:(NSString *)_${item.name} </#list>delegate:(id)_delegate finishSelector:(SEL)_finishSEL failSelector:(SEL)_failSEL timeOutSelector:(SEL)_timeOutSEL;

<#elseif action.method="update">
+ (void)${action.actionName!'save'}<#if queryKeyProperty??>_${queryKeyProperty.name}:(NSString *)_${queryKeyProperty.name} <#else>_</#if><#list action.allItemList as item>${item.name}:(NSString *)_${item.name} </#list>delegate:(id)_delegate finishSelector:(SEL)_finishSEL failSelector:(SEL)_failSEL timeOutSelector:(SEL)_timeOutSEL;
</#if>
</#list>

@end