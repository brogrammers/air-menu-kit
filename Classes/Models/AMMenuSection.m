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
              @"name" : @"name",
              @"details" : @"description",
              @"menuItems" : @"menu_items",
              @"staffKind" : @"staff_kind"};
}

+(NSValueTransformer *)menuItemsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[AMMenuItem class]];
}

+(NSValueTransformer *)staffKindJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AMStaffKind class]];
}
@end
