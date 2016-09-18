<#assign pojoBasePackage='com.lecai.core.model'>
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