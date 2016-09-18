<#assign pojoBasePackage='com.netmodel.api.model'>
<#assign serviceBasePackage='com.netmodel.api.request'>

<#function getType type>
    <#if type?starts_with('.')>
        <#return '${pojoBasePackage}${type}'>
    <#else>
        <#return '${type}'>
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

<#function getGenericType4searchConfig searchConfig>
    <#if searchConfig.genericType??>
        <#if searchConfig.genericType?starts_with('.')>
            <#return '<${pojoBasePackage}${searchConfig.genericType}>'>
        <#else>
            <#return '<${searchConfig.genericType}>'>
        </#if>
    <#else>
        <#return ''>
    </#if>
</#function>

<#function isStringType fieldType>
    <#return fieldType = "String" || fieldType = "java.lang.String">
</#function>

package ${prePackage}.${subPackage};

<#list entity.propertiesList as property>
<#if property.ref>
import ${pojoBasePackage}${property.path};
</#if>
</#list>

import ${pojoBasePackage}.base.ApiResult;
import java.io.Serializable;

/**
 * This file is auto generated, do not modify it by hand
 *
 */

public class ${entity.name?cap_first} <#if entity.extendsClass?? && entity.extendsClass?has_content>extends <#if entity.extendsClass?starts_with('.')>${pojoBasePackage}</#if>${entity.extendsClass} </#if>implements Serializable {
<#list entity.propertiesList as property>
    <#if property.comment??>
    /**
     * ${property.comment}
     */
    </#if>
<#if property.ref>
    <#if property.defaultValue??>
    private ${property.type?cap_first}${getGenericType(property)} ${property.name} = ${property.defaultValue};
    <#else>
    private ${property.type?cap_first}${getGenericType(property)} ${property.name}<#if stringPropertyDefaultEmpty && isStringType(property.type)> = ""</#if>;
    </#if>
<#else>
    <#if property.defaultValue??>
    private ${property.type}${getGenericType(property)} ${property.name} = ${property.defaultValue};
    <#else>
    private ${property.type}${getGenericType(property)} ${property.name}<#if stringPropertyDefaultEmpty && isStringType(property.type)> = ""</#if>;
    </#if>
</#if>

</#list>

<#list entity.propertiesList as property>

    <#if property.ref>
    public void set${property.name?cap_first}(${property.type?cap_first}${getGenericType(property)} ${property.name}) {
        <#if isStringType(property.type)>
         if (${property.name} == null) {
            return;
         }
         </#if>
        this.${property.name} = ${property.name};
    }

    public ${property.type?cap_first}${getGenericType(property)} get${property.name?cap_first}() {
        return ${property.name};
    }
    <#else>
    public void set${property.name?cap_first}(${property.type}${getGenericType(property)} ${property.name}) {
        <#if isStringType(property.type)>
         if (${property.name} == null) {
            return;
         }
         </#if>
        this.${property.name} = ${property.name};
    }

    public ${property.type}${getGenericType(property)} get${property.name?cap_first}() {
        return ${property.name};
    }
    </#if>

</#list>

}