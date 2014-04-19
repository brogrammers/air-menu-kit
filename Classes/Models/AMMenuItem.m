//
//  AMMenuItem.m
//  AirMenuKit
//
//  Created by Robert Lis on 03/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMMenuItem.h"
#import "NSDateFormatter+AirMenuTimestamp.h"
#import "NSNumberFormatter+AirMenuNumberFormat.h"

@implementation AMMenuItem

#pragma mark - Mantle framework mapping hooks

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier" : @"id",
             @"name" : @"name",
             @"details" : @"description",
             @"price" : @"price",
             @"currency" : @"currency",
             @"staffKind" : @"staff_kind"};
}

+(NSValueTransformer *)staffKindJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AMStaffKind class]];
}

@end
