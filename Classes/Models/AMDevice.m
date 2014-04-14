//
//  AMDevice.m
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMDevice.h"

@implementation AMDevice
+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier" : @"id",
            @"name" : @"name",
            @"uuid" : @"uuid",
            @"token" : @"token",
            @"platform" : @"platform"};
}
@end
