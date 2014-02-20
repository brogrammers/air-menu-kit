//
//  AMRestaurant.m
//  AirMenuKit
//
//  Created by Robert Lis on 03/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMRestaurant.h"

@implementation AMRestaurant

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier" : @"id",
             @"name" : @"name",
             @"loyalty" : @"loyalty",
             @"remoteOrder" : @"remote_order",
             @"conversionRate" : @"conversion_rate",
             @"address" : @"address"};
}

+(NSValueTransformer *)addressJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AMAddress class]];
}

@end
