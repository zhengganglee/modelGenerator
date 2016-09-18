//
//  LCAPIResultUpData.h
//  LeCai
//
//  Created by lehecaiminib on 13-10-21.
//
//

#import <Foundation/Foundation.h>

@interface LCAPIResultUpData : NSObject
/**
 * 升级策略
 *
 * <pre>
 * 0:不升级
 * 1:强制升级
 * 2:建议升级
 * </pre>
 */
@property(nonatomic, assign)int      policy;
/**
 * 新版本号
 */
@property(nonatomic, strong)NSMutableString *newVersion;
/**
 * 更新日志
 */
@property(nonatomic, strong)NSMutableString *updateLog;
/**
 * 下载地址
 */
@property(nonatomic, strong)NSMutableString *downloadUrl;
@end
