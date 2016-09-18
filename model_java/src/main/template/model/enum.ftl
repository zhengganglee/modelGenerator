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
package ${prePackage}.${subPackage};

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public enum ${entity.name?cap_first} implements Serializable {

	<#list entity.propertiesList as property>
	<#if property.comment??>
    /**
     * ${property.comment}
     */
    </#if>
	${property.name}("${property.displayName!property.cnName}", ${property.id}),
	</#list>
	UN_KNOWN("未知", -3);
	private static final Map<Integer, ${entity.name?cap_first}> map = new HashMap<Integer, ${entity.name?cap_first}>();

	static {
		${entity.name?cap_first}[] ${entity.name}s = ${entity.name?cap_first}.values();
		for (${entity.name?cap_first} ${entity.name} : ${entity.name}s) {
			map.put(${entity.name}.getValue(), ${entity.name});
		}
	}

	private int value;

	private String name;

	private String realName;

	private ${entity.name?cap_first}(String name, int value) {
		this.name = name;
		this.value = value;
		this.realName = this.toString();
	}

	private ${entity.name?cap_first}(String name, int value, String realName) {
		this.name = name;
		this.value = value;
		this.realName = realName;
	}

	public int getValue() {
		return value;
	}

	public String getName() {
		return name;
	}

	public String getRealName() {
		return realName;
	}
	
	public void setRealName(String realName) {
        this.realName = realName;
    }

	public static ${entity.name?cap_first} getFromValue(int value) {
		${entity.name?cap_first} ${entity.name} = map.get(value);
		return ${entity.name} == null ? UN_KNOWN : ${entity.name};
	}
	
		
}