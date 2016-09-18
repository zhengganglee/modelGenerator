<#assign pojoBasePackage='com.netmodel.api.model'>
<#assign serviceBasePackage='com.netmodel.api.request'>
<#assign cacheModel=(subPackage?starts_with('cache.')||entity.cacheable)><#--缓存model，没有公共参数，CND缓存'/cache/'路径下的请求-->

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

<#function getExecutor action>
    <#assign executorMethod=''>
    <#list action.allItemList as item>
        <#if item.executor?exists>
            <#assign executorMethod='${item.executor}'>
        </#if>
    </#list>
    <#return executorMethod>
</#function>

package ${prePackage}.${subPackage};

import ${pojoBasePackage}.type.*;

<#list entity.propertiesList as property>
    <#if property.ref>
    import ${pojoBasePackage}${property.path};
    </#if>
</#list>

import ${pojoBasePackage}.${subPackage}.${entity.name?cap_first};
import ${pojoBasePackage}.base.ApiResult;
import ${pojoBasePackage}.request.RequestCallback;
import ${pojoBasePackage}.request.RequestConfig;

/**
* This file is auto generated, do not modify it by hand
*
*/

public class ${entity.name?cap_first}Request {

<#list entity.propertiesList as property>
    <#if property.queryKey?? && property.queryKey>
    public static void findBy${property.name?cap_first}(<#if entity.requiredUid>String uid, </#if>${getType(property.type)} ${property.name}, RequestCallback requestCallback) {
    String url = RequestConfig.getProxyRequest().getProxyApi() + "<#if entity.cacheable>/cache</#if>/${subPackage?replace('.','/')}/${entity.name?lower_case}/"+${property.name}.toString();
    java.util.Map<String, String> params = new java.util.HashMap<String, String>();
        <#if entity.requiredUid>
        params.put("uid", uid);
        </#if>
    RequestConfig.getProxyRequest().doRequest(url, params, com.netmodel.api.model.request.IProxyRequest.HTTP_METHOD_GET, <#if cacheModel>true<#else>false</#if>, ${entity.name?cap_first}Result.class, requestCallback);
    }
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
    public static void find${(search.searchName!'')?cap_first}${handleMethodName?cap_first}(<#if entity.requiredUid>String uid, </#if><#list search.itemList as item>${getType(item.type)}${getGenericType4search(item)} ${item.name}, </#list><#if search.pageable> Integer page, Integer size, </#if>RequestCallback requestCallback) {
    String url = RequestConfig.getProxyRequest().getProxyApi() + "<#if entity.cacheable>/cache</#if>/${subPackage?replace('.','/')}/${entity.name?lower_case}"+"/search/find${(search.searchName!'')?cap_first}${handleMethodName?cap_first}";
    java.util.Map<String, String> params = new java.util.HashMap<String, String>();
        <#if entity.requiredUid>
        params.put("uid", uid);
        </#if>
        <#list search.itemList as item>
        params.put("${item.name}", com.netmodel.api.model.request.RequestUtils.object2String(${item.name}));
        </#list>
        <#if search.pageable>
        params.put("page", String.valueOf(page));
        params.put("size", String.valueOf(size));
        </#if>
    RequestConfig.getProxyRequest().doRequest(url, params, com.netmodel.api.model.request.IProxyRequest.HTTP_METHOD_GET, <#if cacheModel>true<#else>false</#if>, ${entity.name?cap_first}Result.class, requestCallback);
    }
    <#else>
    public static void get${entity.name?cap_first}(<#if entity.requiredUid>String uid, </#if><#if search.pageable>Integer page, Integer size, </#if>RequestCallback requestCallback) {
    String url = RequestConfig.getProxyRequest().getProxyApi() + "<#if entity.cacheable>/cache</#if>/${subPackage?replace('.','/')}/${entity.name?lower_case}";
    java.util.Map<String, String> params = new java.util.HashMap<String, String>();
        <#if entity.requiredUid>
        params.put("uid", uid);
        </#if>
        <#if search.pageable>
        params.put("page", String.valueOf(page));
        params.put("size", String.valueOf(size));
        </#if>
    RequestConfig.getProxyRequest().doRequest(url, params, com.netmodel.api.model.request.IProxyRequest.HTTP_METHOD_GET, <#if cacheModel>true<#else>false</#if>, ${entity.name?cap_first}Result.class, requestCallback);
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

executor : ${getExecutor(action)}
*/
    <#if action.method="create">
    public static void ${action.actionName!'save'}(<#if entity.requiredUid>String uid, </#if><#list action.allItemList as item>${getFullType(item)} ${item.name}, </#list><#if '${getExecutor(action)}'='rsa'> String rsaPublicKey,</#if> RequestCallback requestCallback) {
    String url = RequestConfig.getProxyRequest().getProxyApi() + "/${subPackage?replace('.','/')}/${entity.name?lower_case}"<#if !action.root && action.actionName??>+"/${action.actionName}"</#if>;
    java.util.Map<String, String> params = new java.util.HashMap<String, String>();
        <#if entity.requiredUid>
        params.put("uid", uid);
        </#if>
        <#list action.allItemList as item>
            <#if item.executor?? && '${item.executor}'='rsa'>
            params.put("${item.name}", com.netmodel.api.model.request.ProxyRSAUtils.encryptByPublicKey(com.netmodel.api.model.request.RequestUtils.object2String(${item.name}), rsaPublicKey));
            <#else>
            params.put("${item.name}", com.netmodel.api.model.request.RequestUtils.object2String(${item.name}));
            </#if>
        </#list>
    RequestConfig.getProxyRequest().doRequest(url, params, com.netmodel.api.model.request.IProxyRequest.HTTP_METHOD_POST, false, ${entity.name?cap_first}Result.class, requestCallback);
    }

    <#elseif action.method="update">
    public static void ${action.actionName!'update'}(${getType(queryKeyProperty.type)} ${queryKeyProperty.name},<#if entity.requiredUid>String uid, </#if><#list action.allItemList as item>${getFullType(item)} ${item.name}, </#list><#if '${getExecutor(action)}'='rsa'> String rsaPublicKey, </#if>RequestCallback requestCallback) {
    String url = RequestConfig.getProxyRequest().getProxyApi() + "/${subPackage?replace('.','/')}/${entity.name?lower_case}"+"/"+${queryKeyProperty.name}<#if !action.root && action.actionName??>+"/${action.actionName}"</#if>;
    java.util.Map<String, String> params = new java.util.HashMap<String, String>();
        <#if entity.requiredUid>
        params.put("uid", uid);
        </#if>
        <#list action.allItemList as item>
            <#if item.executor?? && '${item.executor}'='rsa'>
            params.put("${item.name}", com.netmodel.api.model.request.ProxyRSAUtils.encryptByPublicKey(com.netmodel.api.model.request.RequestUtils.object2String(${item.name}), rsaPublicKey));
            <#else>
            params.put("${item.name}", com.netmodel.api.model.request.RequestUtils.object2String(${item.name}));
            </#if>
        </#list>
    RequestConfig.getProxyRequest().doRequest(url, params, com.netmodel.api.model.request.IProxyRequest.HTTP_METHOD_PUT, false, ${entity.name?cap_first}Result.class, requestCallback);
    }

    </#if>
</#list>

public static class ${entity.name?cap_first}Result extends ApiResult<${entity.name?cap_first}> {

private static final long serialVersionUID = 1L;

}
}