//
//  AMOrder.m
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMOrder.h"
#import "AMOrderItem.h"
#import "NSDateFormatter+AirMenuTimestamp.h"

@implementation AMOrder
+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier" : @"id",
             @"state" : @"state",
             @"approvedAt" : @"approved_time",
             @"servedAt" : @"served_time",
             @"cancelledAt" : @"cancelled_time",
             @"user" : @"user",
             @"restaurant" : @"restaurant",
             @"orderItems" : @"order_items",
             @"tableNumber" : @"table_number"};
}

+(NSValueTransformer *)restaurantJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AMRestaurant class]];
}

+(NSValueTransformer *)userJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AMUser class]];
}

+(NSValueTransformer *)orderItemsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[AMOrderItem class]];
}

+(NSValueTransformer *)approvedAtJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [[NSDateFormatter sharedAirMenuFormatter] dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [[NSDateFormatter sharedAirMenuFormatter] stringFromDate:date];
    }];
}

+(NSValueTransformer *)cancelledAtJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [[NSDateFormatter sharedAirMenuFormatter] dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [[NSDateFormatter sharedAirMenuFormatter] stringFromDate:date];
    }];
}

+(NSValueTransformer *)servedAtJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [[NSDateFormatter sharedAirMenuFormatter] dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [[NSDateFormatter sharedAirMenuFormatter] stringFromDate:date];
    }];
}
+(NSValueTransformer *)stateJSONTransformer
{
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{@"new" : @(AMOrderStateNew),
                                                                           @"open" : @(AMOrderStateOpen),
                                                                           @"approved" : @(AMOrderStateApproved),
                                                                           @"cancelled" : @(AMOrderStateCancelled),
                                                                           @"served" : @(AMOrderStateServed),
                                                                           @"paid" : @(AMOrderStatePaid)}];
}

-(BOOL)isEqual:(id)object
{
    if(self.class == [object class]) {
        return  [self.identifier isEqualToNumber:[(AMOrder *)object identifier]] ||
        (!self.identifier && ![(AMOrder *)object identifier]);
    }
    return NO;
}

-(NSUInteger)hash
{
    return [self.identifier hash];
}

@end
