//
//  OrderItem.m
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMOrderItem.h"
#import "NSDateFormatter+AirMenuTimestamp.h"

@implementation AMOrderItem
+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier" : @"id",
             @"comment" : @"comment",
             @"count" : @"count",
             @"state" : @"state",
             @"approvedAt" : @"approved_time",
             @"declinedAt" : @"declined_time",
             @"prepareTimeStart" : @"start_prepare_time",
             @"prepareTimeEnd" : @"end_prepare_time",
             @"servedAt" : @"served_time",
             @"order" : @"order",
             @"menuItem" : @"menu_item"};
}

+(NSValueTransformer *)approvedAtJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [[NSDateFormatter sharedAirMenuFormatter] dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [[NSDateFormatter sharedAirMenuFormatter] stringFromDate:date];
    }];
}

+(NSValueTransformer *)declinedAtJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [[NSDateFormatter sharedAirMenuFormatter] dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [[NSDateFormatter sharedAirMenuFormatter] stringFromDate:date];
    }];
}

+(NSValueTransformer *)prepareTimeStartJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [[NSDateFormatter sharedAirMenuFormatter] dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [[NSDateFormatter sharedAirMenuFormatter] stringFromDate:date];
    }];
}

+(NSValueTransformer *)prepareTimeEndJSONTransformer
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

+(NSValueTransformer *)orderJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AMOrder class]];
}

+(NSValueTransformer *)menuItemJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AMMenuItem class]];
}

+(NSValueTransformer *)stateJSONTransformer
{
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{@"new" : @(AMOrderItemStateNew),
                                                                           @"approved" : @(AMOrderItemStateApproved),
                                                                           @"declined" : @(AMOrderItemStateDeclined),
                                                                           @"start_prepare" : @(AMOrderItemStateBeingPrepared),
                                                                           @"end_prepare" : @(AMOrderItemStatePrepared),
                                                                           @"served" : @(AMOrderItemStateServed) }];
}

-(BOOL)isEqual:(id)object
{
    if(self.class == [object class]) {
        return  [self.identifier isEqualToNumber:[(AMOrderItem *)object identifier]] ||
        (!self.identifier && ![(AMOrderItem *)object identifier]);
    }
    return NO;
}

-(NSUInteger)hash
{
    return [self.identifier hash];
}

@end
