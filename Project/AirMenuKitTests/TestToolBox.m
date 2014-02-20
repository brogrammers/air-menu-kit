//
//  TestToolBox.m
//  AirMenuKit
//
//  Created by Robert Lis on 19/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "TestToolBox.h"

@implementation TestToolBox
+(NSDictionary *)bodyOfRequest:(NSURLRequest *)request
{
    NSString *requestBody = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
    NSArray *parameters = [requestBody componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    for(NSString *parameter in parameters)
    {
        if(![parameter isEqualToString:@""])
        {
            NSMutableArray *keyValue = [[parameter componentsSeparatedByString:@"="] mutableCopy];
            keyValue[0] = [keyValue[0] stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            keyValue[1] = [keyValue[1] stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            [params setValue:keyValue[1] forKey:keyValue[0]];
        }
    }
    
    return params;
}
@end
