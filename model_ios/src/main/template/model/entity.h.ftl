<#assign pojoBasePackage='com.jessieray.api.mode'>
<#assign serviceBasePackage='com.jessieray.api.request'>

<#function getIosType property>
    <#local type=property.type>
    <#if type?starts_with('java.lang.String') || type ='String'>
        <#return '@property(nonatomic,strong)NSMutableString'>
    <#elseif type = 'int' || type ='Integer' || type ='java.lang.Integer'>
        <#return '@property(assign)int'>
    <#elseif type = 'int' || type ='Long' || type ='java.lang.Long'>
        <#return '@property(assign)long'>
    <#elseif type = 'double' || type ='Double' || type ='java.lang.Double'>
        <#return '@property(assign)double'>
    <#elseif type = 'Boolean' || type = 'boolean' || type = 'java.lang.Boolean'>
        <#return '@property(assign)BOOL'>
    <#elseif type = 'java.util.List'>
        <#return '@property(nonatomic,strong)NSArray'>
    <#elseif type = 'java.util.Map'>
        <#return '@property(nonatomic,strong)NSMutableDictionary'>
    <#elseif type = 'java.util.Date'>
        <#return '@property(nonatomic,strong)NSMutableString'>
    <#--<#elseif property.path?contains('.type.') >-->
        <#--<#return '@property(nonatomic,strong)NSMutableString'>-->
    <#else>
        <#return '@property(nonatomic,strong)'+type?cap_first>
    </#if>
</#function>

<#function getGenericType property>
    <#local genericType=property.genericType>
    <#if genericType?starts_with('.') || genericType?contains('.type.')>
        <#return genericType?substring((genericType?last_index_of('.')+1))>
     <#else>
        <#return genericType>
    </#if>
</#function>

<#function getIosTypeImpl type name>
    <#if type = 'Boolean' || type = 'boolean' || type = 'java.lang.Boolean' 
    || type = 'int' || type ='Integer' || type ='java.lang.Integer' 
    || type = 'long' || type ='Long' || type ='java.lang.Long' 
    || type = 'double' || type ='Double' || type ='java.lang.Double'>
        <#return name>
     <#else>
        <#return '*'+name>
    </#if>
</#function>
<#function getIosNotStringTypeImpl type name>
    <#if type?starts_with('java.lang.String') || type ='String'>
        <#return '*'+name>
     <#else>
        <#return '*'+name>
    </#if>
</#function>

<#function iosArrayItemTypeField property>
    <#if property.genericType?? && !property.genericType?starts_with('java.lang.') && !property.genericType?contains('.type.')>
        <#return true>
    <#else>
        <#return false>
    </#if>
</#function>
<#function getExtendsClassName>
    <#if !entity.extendsClass?? || !entity.extendsClass?contains('.') || entity.extendsClass?ends_with('.')>
        <#return entity.extendsClass>
    <#else>
        <#return entity.extendsClass?substring(entity.extendsClass?last_index_of('.') + 1)>
    </#if>
</#function>

//  
//  lecai 2013
//  This file(.h) is auto generated, do not modify it by hand
//

#import <Foundation/Foundation.h>
<#list entity.propertiesList as property>
<#if property.ref && !property.path?contains('.type.')>
#import "${property.type?cap_first}.h"
<#elseif iosArrayItemTypeField(property)>
#import "${(getGenericType(property))?cap_first}.h"
</#if>
</#list>

@interface ${entity.name?cap_first} : ${getExtendsClassName()!'NSObject'} <NSCoding>

<#list entity.propertiesList as property>
<#if property.comment??>
/**
 * ${property.comment}
 */
</#if>
<#if property.ref>
${getIosType(property)}  *${property.name};
<#else>
${getIosType(property)} ${getIosTypeImpl(property.type property.name)};
</#if>

<#--<#if iosArrayItemTypeField(property)>@property(nonatomic,strong)${getGenericType(property)} *${property.name}Array;</#if>-->

</#list>

@end
