<#assign pojoBasePackage='com.netmodel.api.model'>
<#assign serviceBasePackage='com.lecai.proxy.service'>

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
    <#if type='boolean'>
        <#return 'Boolean'>
    <#elseif type='byte'>
        <#return 'Byte'>
    <#elseif type='char'>
        <#return 'Character'>
    <#elseif type='short'>
        <#return 'Short'>
    <#elseif type='int'>
        <#return 'Integer'>
    <#elseif type='long'>
        <#return 'Long'>
    <#elseif type='float'>
        <#return 'Float'>
    <#elseif type='double'>
        <#return 'Double'>
    <#else>
        <#return type>
    </#if>
</#function>
package ${prePackage}.${subPackage};

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import ${pojoBasePackage}.${subPackage}.${entity.name?cap_first};

import ${pojoBasePackage}.type.*;

<#list entity.propertiesList as property>
<#if property.ref>
import ${pojoBasePackage}${property.path};
</#if>
</#list>

/**
 * This file is auto generated, do not modify it by hand
 *
 */
public interface ${entity.name?cap_first}Service {

<#list entity.propertiesList as property>
<#if property.queryKey?? && property.queryKey>
    public ${entity.name?cap_first} findBy${property.name?cap_first}(<#if entity.requiredUid>String uid, </#if>${property.type?cap_first} ${property.name}) throws Exception;
    <#assign queryKeyProperty=property>
    <#break>
</#if>
</#list>

<#if entity.searchList??>
<#list entity.searchList as search>
    <#assign handleMethodName='' handleMethodParam=''>
    <#list search.itemList as item>
        <#assign handleMethodName = handleMethodName + item.name?cap_first>
        <#assign handleMethodParam = handleMethodParam + (getType(item.type) + getGenericType4search(item) + " " + item.name)>
        <#if item_has_next>
            <#assign handleMethodName = handleMethodName + "And">
            <#assign handleMethodParam = handleMethodParam + ", ">
        </#if>
    </#list>
    <#if handleMethodName?has_content><#assign handleMethodName="By"+handleMethodName></#if>
    
    <#if search.pageable>
        <#assign serviceReturnType='Page<${entity.name?cap_first}>'>
        <#if handleMethodParam?has_content>
            <#assign handleMethodParam = handleMethodParam + ", Pageable pageable">
        <#else>
            <#assign handleMethodParam = "Pageable pageable">
        </#if>
    <#else>
        <#assign serviceReturnType='java.util.List<${entity.name?cap_first}>'>
    </#if>
        /**<#if search.comment??>
         * ${search.comment}
         * </#if><#list search.itemList as item>
         * @param ${item.name} 
         *           ${item.comment!''}</#list>
         */
        <#--<#if search.service??>
        <#list search.service.paramList as param>
            <#if handleMethodName?has_content>
                <#assign handleMethodName=handleMethodName+"And">
            </#if>
            <#assign handleMethodName=handleMethodName+param?cap_first>
            <#if handleMethodParam?has_content>
                <#assign handleMethodParam=handleMethodParam+", ">
            </#if>
            <#assign handleMethodParam=handleMethodParam+"String "+param>
        </#list>
        <#if !handleMethodName?starts_with("By") && handleMethodName?has_content><#assign handleMethodName="By"+handleMethodName></#if>
        </#if>-->
    	<#if handleMethodName?has_content || (search.searchName!'')?has_content>
    	public ${serviceReturnType} find${(search.searchName!'')?cap_first}${handleMethodName?cap_first}(<#if entity.requiredUid || search.requiredUid>String uid<#if handleMethodParam?has_content>, </#if></#if>${handleMethodParam}) throws Exception;
    	<#else>
        public ${serviceReturnType} get${entity.name?cap_first}(<#if entity.requiredUid || search.requiredUid>String uid<#if handleMethodParam?has_content>, </#if></#if>${handleMethodParam}) throws Exception;
    	</#if>
</#list>
</#if>

<#function getFullType item>
    <#if getGenericType4search(item)??>
        <#return '${toRefType(getType(item.type))}${getGenericType4search(item)}'>
    <#else>
        <#return '${toRefType(getType(item.type))}'>
    </#if>
</#function>

<#list entity.actionList as action>
    <#assign actionMethodParam = ''>
    <#list action.itemList as item>
        <#assign actionMethodParam = actionMethodParam + getFullType(item) + " " + item.name>
        <#if item_has_next>
            <#assign actionMethodParam = actionMethodParam + ", ">
        </#if>
    </#list>
<#if action.method="create">
    /**<#if action.comment??>
     * ${action.comment}
     * </#if><#list action.itemList as item>
     * @param ${item.name} 
     *           ${item.comment!''}</#list>
     */
    public com.qinglicai.webapp.service.ServiceResult do${(action.actionName!'save')?cap_first}(<#if entity.requiredUid || action.requiredUid>String uid, </#if><#if actionMethodParam?has_content>${actionMethodParam}<#else>${entity.name?cap_first} ${entity.name?uncap_first}</#if>) throws Exception;

<#elseif action.method="update">
    /**<#if action.comment??>
     * ${action.comment}
     * </#if><#list action.itemList as item>
     * @param ${item.name} 
     *           ${item.comment!''}</#list>
     */
    public com.qinglicai.webapp.service.ServiceResult do${(action.actionName!'update')?cap_first}(${queryKeyProperty.type?cap_first} ${queryKeyProperty.name}, <#if entity.requiredUid || action.requiredUid>String uid, </#if><#if actionMethodParam?has_content>${actionMethodParam}<#else>${entity.name?cap_first} ${entity.name?uncap_first}</#if>) throws Exception;

</#if>
</#list>

}