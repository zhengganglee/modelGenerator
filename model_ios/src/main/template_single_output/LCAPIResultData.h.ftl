//
//  LCAPIResultData.h
//  LeCai
//
//  Created by lehecaiminib on 13-9-16.
//
//

#import <Foundation/Foundation.h>

@interface LCAPIResultData : NSObject <NSCoding>
@property(nonatomic, assign)long                      rows;
@property(nonatomic, assign)long                      total;
@property(nonatomic,strong)NSMutableArray             *modelList;
@end
