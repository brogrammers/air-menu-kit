//
//  AMMenuSection.m
//  AirMenuKit
//
//  Created by Robert Lis on 03/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMMenuSection.h"
#import "AMMenuItem.h"
#import "NSDateFormatter+AirMenuTimestamp.h"

@implementation AMMenuSection

#pragma mark - Mantle framework mapping hooks

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return  @{@"identifier" : @"id",
              @"createdAt" : @"created_at",
              @"updatedAt" : @"updated_at",
              @"name" : @"name",
              @"details" : @"description",
              @"menuItems" : @"menu_items"};
}

+(NSValueTransformer *)createdAtJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [[NSDateFormatter sharedAirMenuFormatter] dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [[NSDateFormatter sharedAirMenuFormatter] stringFromDate:date];
    }];
}

+(NSValueTransformer *)updatedAtJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [[NSDateFormatter sharedAirMenuFormatter] dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [[NSDateFormatter sharedAirMenuFormatter] stringFromDate:date];
    }];
}

+(NSValueTransformer *)menuItemsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[AMMenuItem class]];
}

@end
