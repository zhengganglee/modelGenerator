//
//  LCAPIResult.h
//  LeCai
//
//  Created by lehecaiminib on 13-9-16.
//
//

#import <Foundation/Foundation.h>
#import "LCAPIResultData.h"
#import "LCAPIResultUpData.h"

@interface LCAPIResult : NSObject <NSCoding>
@property(nonatomic,strong)NSArray           *whiteList;
@property(nonatomic,strong)NSArray           *blackList;
@property(nonatomic,strong)NSMutableString   *serverTime;
@property(nonatomic,assign)double            serverTimeMillis;
@property(nonatomic,strong)NSMutableString   *message;
@property(nonatomic,assign)long              code;
@property(nonatomic,strong)LCAPIResultData   *data;
@property(nonatomic,strong)LCAPIResultUpData *updateInfo;
@end
