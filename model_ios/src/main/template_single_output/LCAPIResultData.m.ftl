//
//  LCAPIResultData.m
//  LeCai
//
//  Created by lehecaiminib on 13-9-16.
//
//

#import "LCAPIResultData.h"

@implementation LCAPIResultData
@synthesize rows,modelList,total;
- (void)dealloc {
    [modelList release] , modelList = nil;
    [super dealloc];
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.modelList = [decoder decodeObjectForKey:@"modelList"];
    self.rows = [decoder decodeInt32ForKey:@"rows"];
    self.total = [decoder decodeInt32ForKey:@"total"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.modelList forKey:@"modelList"];
    [encoder encodeInt32:self.rows forKey:@"rows"];
    [encoder encodeInt32:self.total forKey:@"total"];
}
@end
