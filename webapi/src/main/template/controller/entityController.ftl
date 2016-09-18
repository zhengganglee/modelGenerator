<#assign pojoBasePackage='com.netmodel.api.model'>
<#assign serviceBasePackage='com.qinglicai.webapp.service'>
<#assign cacheModel=(subPackage?starts_with('cache.')||entity.cacheable)><#--缓存model，没有公共参数，CND缓存'/cache/'路径下的请求-->

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
            <#return '${pojoBasePackage}${search.genericType}'>
        <#else>
            <#return '${search.genericType}'>
        </#if>
    <#else>
        <#return null>
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

<#function hasUid entity queryKeyProperty searchOrAction>
    <#return entity.requiredUid || (queryKeyProperty!='' && queryKeyProperty.name='uid') || (searchOrAction?? && searchOrAction.requiredUid?? && searchOrAction.requiredUid)>
</#function>

package ${prePackage}.${subPackage};

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qinglicai.webapp.interceptor.annotation.RequestSign;
import com.qinglicai.webapp.interceptor.annotation.RequiredLogin;

import ${pojoBasePackage}.${subPackage}.${entity.name?cap_first};

import ${pojoBasePackage}.type.*;

import com.qinglicai.webapp.util.RequestUtils;
import com.qinglicai.webapp.util.ResponseUtils;

<#list entity.propertiesList as property>
    <#if property.ref>
import ${pojoBasePackage}${property.path};
</#if>
</#list>

import ${serviceBasePackage}.${subPackage}.${entity.name?cap_first}Service;

<#list entity.actionList as action>
<#if action.method="create" || action.method="update">
    <#assign hasAction=true><#break>    
</#if>
</#list>

<#if hasAction??>
/**
 * 这个Controller有抽象的请求需要子类实现<br>
 */
<#else>
@Controller
</#if>
<#assign baseReqUrl="/${subPackage?replace('.','/')}/${entity.name?lower_case}">
<#if entity.cacheable>
@RequestMapping({"/cache${baseReqUrl}","${baseReqUrl}"})
<#else>
@RequestMapping("${baseReqUrl}")
</#if>
public <#if hasAction??>abstract</#if> class ${entity.name?cap_first}Controller extends com.qinglicai.webapp.BaseController {

    @Autowired(required=false) public ${entity.name?cap_first}Service ${entity.name?uncap_first}Service;

<#list entity.propertiesList as property>
<#if property.queryKey?? && property.queryKey>
    <#assign queryKeyProperty=property>
    <#if hasUid(entity,queryKeyProperty,{})>
    @RequiredLogin
    </#if>
    <#if cacheModel>@RequestSign(required = false)
    </#if>@ResponseBody
    @RequestMapping(value = "/{${property.name}}", method = RequestMethod.GET)
    public Object findBy${property.name?cap_first}(@PathVariable("${property.name}") ${property.type?cap_first} ${property.name}, <#if entity.requiredUid>@RequestParam("uid") String uid, </#if>HttpServletRequest request) throws Exception {
        return ResponseUtils.wrapSuccess(${entity.name?uncap_first}Service.findBy${property.name?cap_first}(<#if entity.requiredUid>uid, </#if>${property.name})<#if cacheModel>, true</#if>);
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
    
    <#if hasUid(entity,'',search)>
    @RequiredLogin
    </#if>
    <#if cacheModel>@RequestSign(required = false)</#if>
<#if handleMethodName?has_content || (search.searchName!'')?has_content>
    @ResponseBody
    @RequestMapping(value = "/search/find${(search.searchName!'')?cap_first}${handleMethodName?cap_first}", method = RequestMethod.GET)
    public Object find${(search.searchName!'')?cap_first}${handleMethodName?cap_first}(<#if entity.requiredUid || search.requiredUid>@RequestParam("uid") String uid, </#if>HttpServletRequest request) throws Exception {
<#else>
    @ResponseBody
    @RequestMapping(method = RequestMethod.GET)
    public Object get${entity.name?cap_first}(<#if entity.requiredUid || search.requiredUid>@RequestParam("uid") String uid, </#if>HttpServletRequest request) throws Exception {
</#if>
    
    <#assign methodParam=''>
    <#list search.itemList as item>
        <#if getGenericType4search(item)??>
        ${toRefType(getType(item.type))}<${getGenericType4search(item)}> ${item.name} = RequestUtils.extractListObjectFromRequest(request, "${item.name}", ${getGenericType4search(item)}.class);
        <#else>
        ${toRefType(getType(item.type))} ${item.name} = RequestUtils.extractObjectFromRequest(request, "${item.name}", ${toRefType(getType(item.type))}.class);
        </#if>
        <#assign methodParam=methodParam + item.name>
        <#if item_has_next>
            <#assign methodParam=methodParam + ", ">
        </#if>
    </#list>
    
    <#if search.pageable>
        Integer page = RequestUtils.extractObjectFromRequest(request, "page", Integer.class);
        Integer size = RequestUtils.extractObjectFromRequest(request, "size", Integer.class);
        Pageable pageRequest = new PageRequest(page, size);
        <#if methodParam?has_content>
            <#assign methodParam = methodParam + ", pageRequest">
        <#else>
            <#assign methodParam = "pageRequest">
        </#if>
    </#if>
<#if handleMethodName?has_content || (search.searchName!'')?has_content>
    <#--<#if search.service??>
        com.lecai.core.util.request.ProxyRequestInfo proxyRequestInfo = com.lecai.core.util.request.ProxyRequestInfoHolder.get();
    <#list search.service.paramList as param>
        <#if handleMethodName?has_content>
            <#assign handleMethodName=handleMethodName+"And">
        </#if>
        <#assign handleMethodName=handleMethodName+param?cap_first>
        <#if methodParam?has_content>
            <#assign methodParam=methodParam+", ">
        </#if>
        <#assign methodParam=methodParam+"proxyRequestInfo.get"+param?cap_first+"()">
    </#list>
    <#if !handleMethodName?starts_with("By") && handleMethodName?has_content><#assign handleMethodName="By"+handleMethodName></#if>
    </#if>-->
        return ResponseUtils.wrapSuccess(${entity.name?uncap_first}Service.find${(search.searchName!'')?cap_first}${handleMethodName?cap_first}(<#if entity.requiredUid || search.requiredUid>uid<#if methodParam?has_content>, </#if></#if>${methodParam})<#if cacheModel>, true</#if>);
<#else>
        return ResponseUtils.wrapSuccess(${entity.name?uncap_first}Service.get${entity.name?cap_first}(<#if entity.requiredUid || search.requiredUid>uid<#if methodParam?has_content>, </#if></#if>${methodParam})<#if cacheModel>, true</#if>);
</#if>
    }
</#list>

<#function getFullType item>
    <#if getGenericType4search(item)??>
        <#return '${toRefType(getType(item.type))}<${getGenericType4search(item)}>'>
    <#else>
        <#return '${toRefType(getType(item.type))}'>
    </#if>
</#function>

<#list entity.actionList as action>
    <#assign actionMethodParam = '' >
    <#list action.itemList as item>
        <#if !item.type?starts_with('.') || item.type?starts_with('.type')><#comment>javaBean 才加@RequestParam</#comment>
            <#assign actionMethodParam = actionMethodParam + '@RequestParam("${item.name}") ' + getFullType(item) + " " + item.name>
        <#else>
            <#assign actionMethodParam = actionMethodParam + getFullType(item) + " " + item.name>
        </#if>
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
    <#if hasUid(entity,'',action)>
    @RequiredLogin
    </#if>
    @ResponseBody
    @RequestMapping(<#if !action.root && action.actionName??>value = "/${action.actionName}", </#if>method = RequestMethod.POST)
    public abstract Object ${action.actionName!'save'}(<#if entity.requiredUid || action.requiredUid>@RequestParam("uid") String uid, </#if><#if actionMethodParam?has_content>${actionMethodParam}<#else>${entity.name?cap_first} ${entity.name?uncap_first}</#if>, HttpServletRequest request, HttpServletResponse response) throws Exception;

<#elseif action.method="update">
    /**<#if action.comment??>
     * ${action.comment}
     * </#if><#list action.itemList as item>
     * @param ${item.name} 
     *           ${item.comment!''}</#list>
     */
    <#if hasUid(entity,queryKeyProperty,action)>
    @RequiredLogin
    </#if>
    @ResponseBody
    @RequestMapping(value = "/{${queryKeyProperty.name}}<#if !action.root && action.actionName??>/${action.actionName}</#if>", method = RequestMethod.PUT)
    public abstract Object ${action.actionName!'update'}(@PathVariable("${queryKeyProperty.name}") ${queryKeyProperty.type?cap_first} ${queryKeyProperty.name}, <#if entity.requiredUid || action.requiredUid>@RequestParam("uid") String uid, </#if><#if actionMethodParam?has_content>${actionMethodParam}<#else>${entity.name?cap_first} ${entity.name?uncap_first}</#if>, HttpServletRequest request, HttpServletResponse response) throws Exception;

</#if>
</#list>

}