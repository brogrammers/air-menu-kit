//
//  Company.m
//  AirMenuKit
//
//  Created by Robert Lis on 03/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMCompany.h"
#import "NSDateFormatter+AirMenuTimestamp.h"

@implementation AMCompany

#pragma mark - Mantle framework mapping hooks

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
                @"identifier" : @"id",
                @"createdAt" : @"created_at",
                @"updatedAt" : @"updated_at",
                @"name" : @"name",
                @"address" : @"address",
                @"website" : @"website"
             };
}
+(NSValueTransformer *)addressJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AMAddress class]];
}


+(NSValueTransformer *)websiteJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
