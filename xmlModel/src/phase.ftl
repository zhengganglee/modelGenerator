
/**
 * This file is auto generated, do not modify it by hand
 *
 */
public class ${entity.name?cap_first} {
<#list propertiesList as property>
	
	private ${property.type} ${property.name};
	
	public void set(${property.type} ${property.name}) {
		this.${property.name} = ${property.name};
	}
	
	public ${property.type} ${property.name} get() {
		return ${property.name}
	}
</#list>
}