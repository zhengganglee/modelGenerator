<#assign pojoBasePackage='com.jessieray.api.mode'>
<#assign serviceBasePackage='com.jessieray.api.request'>
<#function getIosTypeImpl type name>
    <#if !(type = 'Boolean' || type = 'boolean' || type = 'java.lang.Boolean' 
    || type = 'int' || type ='Integer' || type ='java.lang.Integer' 
    || type = 'long' || type ='Long' || type ='java.lang.Long' 
    || type = 'double' || type ='Double' || type ='java.lang.Double')>
        <#return '['+name+' release'+'], '+name+' =nil;'>
    </#if>
    <#return ''>
</#function>
<#function getStringType property>
    <#if property.type?starts_with('java.lang.String') || property.type ='String' || (property.path??&&property.path?starts_with('.type.')) || property.type ='java.util.Date'>
        <#return property.name>
    </#if>
    <#return ''>
</#function>

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

<#function iosArrayItemTypeField property>
    <#if property.genericType?? && !property.genericType?starts_with('java.lang.') && !property.genericType?contains('.type.')>
        <#return true>
    <#else>
        <#return false>
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

//  
//  lecai 2013
//  This file（.m） is auto generated, do not modify it by hand
//

#import "${entity.name?cap_first}.h"

@implementation ${entity.name?cap_first}

<#list entity.propertiesList as property><#if property_index=0>@synthesize </#if>${property.name}<#if property_has_next>, <#else>;</#if></#list>

<#--
- (void)dealloc {
<#list entity.propertiesList as property>
    <#if getIosTypeImpl(property.type property.name) != ''>
    ${getIosTypeImpl(property.type property.name)}
    </#if>
</#list>
	[super dealloc];
}
-->

<#list entity.propertiesList as property>
<#assign name=getStringType(property)>
    <#if name != ''>
- (NSMutableString *)${property.name} {
    if (${name} == nil || [${name} isEqualToString:@"null"]) {
        ${name} = [[NSMutableString alloc] initWithString:@""];
    }
    return ${name};
}
    </#if>

</#list>
- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    <#list entity.propertiesList as property>
    <#if property.comment??>
    /**
     * ${property.comment}
     */
    </#if>
    
    <#assign iosType = getIosType(property)>
    <#if iosType='@property(assign)int'>
    self.${property.name} = [decoder decodeIntForKey:@"${property.name}"];
    <#elseif iosType='@property(assign)long'>
    self.${property.name} = [decoder decodeInt64ForKey:@"${property.name}"];
    <#elseif iosType='@property(assign)double'>
    self.${property.name} = [decoder decodeDoubleForKey:@"${property.name}"];
    <#elseif iosType='@property(assign)BOOL'>
    self.${property.name} = [decoder decodeBoolForKey:@"${property.name}"];
    <#else>
    self.${property.name} = [decoder decodeObjectForKey:@"${property.name}"];
    </#if>

    </#list>
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {

    <#list entity.propertiesList as property>
    <#if property.comment??>
    /**
     * ${property.comment}
     */
    </#if>
    
    <#assign iosType = getIosType(property)>
    <#if iosType='@property(assign)int'>
    [encoder encodeInt:self.${property.name} forKey:@"${property.name}"];
    <#elseif iosType='@property(assign)long'>
    [encoder encodeInt64:self.${property.name} forKey:@"${property.name}"];
    <#elseif iosType='@property(assign)double'>
    [encoder encodeDouble:self.${property.name} forKey:@"${property.name}"];
    <#elseif iosType='@property(assign)BOOL'>
    [encoder encodeBool:self.${property.name} forKey:@"${property.name}"];
    <#else>
    [encoder encodeObject:self.${property.name} forKey:@"${property.name}"];
    </#if>

    </#list>
}

<#assign hasGenFiled = false>
<#list entity.propertiesList as property>
    <#if iosArrayItemTypeField(property)>

        <#assign hasGenFiled = true>
<#--
+ (NSDictionary *)modelContainerPropertyGenericClass {

    return @{ @"${property.name}" : @"${getGenericType(property)}" };
}
-->
    </#if>
</#list>

<#if hasGenFiled>
    + (NSDictionary *)modelContainerPropertyGenericClass {
        return @{
    <#list entity.propertiesList as property>
        <#if iosArrayItemTypeField(property)>
            @"${property.name}" : @"${getGenericType(property)}" <#--<#if (property?is_first)>,</#if>-->
        </#if>
    </#list>
        };
    }
</#if>
@end
