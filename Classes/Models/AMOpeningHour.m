//
//  AMOpeningHour.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/05/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMOpeningHour.h"
#import "NSDateFormatter+AirMenuTimestamp.h"

@implementation AMOpeningHour
+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier" : @"id",
             @"day" : @"day",
             @"startTime" : @"start",
             @"endTime" : @"end"};
}

+(NSValueTransformer *)startTimeJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [[NSDateFormatter sharedAirMenuFormatter] dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [[NSDateFormatter sharedAirMenuFormatter] stringFromDate:date];
    }];
}

+(NSValueTransformer *)endTimeJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [[NSDateFormatter sharedAirMenuFormatter] dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [[NSDateFormatter sharedAirMenuFormatter] stringFromDate:date];
    }];
}

-(BOOL)isEqual:(id)object
{
    if(self.class == [object class]) {
        return  [self.identifier isEqualToNumber:[(AMOpeningHour *)object identifier]] ||
        (!self.identifier && ![(AMOpeningHour *)object identifier]);
    }
    return NO;
}

-(NSUInteger)hash
{
    return [self.identifier hash];
}
@end
