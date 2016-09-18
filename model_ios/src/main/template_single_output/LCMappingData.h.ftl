//
//  LCMappingData.h
//  sdsd
//
//  Created by lehecaiminib on 13-9-10.
//  Copyright (c) 2013年 lehecaiminib. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "LCAPIResult.h"
#import "LCAPIResultData.h"
<#list entityList as entity>
<#if entity.type='object'>
#import "${entity.name?cap_first}.h"
</#if>
</#list>

@interface LCMappingData : NSObject
//在默认model下添加新的mapping
+ (RKObjectMapping *)defualtMappingAdd:(RKObjectMapping *)_mapping mappingName:(NSString *)_name;

//启动应用的时候，初始化所有的mapping
+ (void)setAllMappingModel;
@end
