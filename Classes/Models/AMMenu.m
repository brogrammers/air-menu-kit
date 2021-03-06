//
//  AMMenu.m
//  AirMenuKit
//
//  Created by Robert Lis on 03/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMMenu.h"
#import "AMMenuSection.h"
#import "NSDateFormatter+AirMenuTimestamp.h"

@implementation AMMenu

#pragma mark - Mantle Framework mapping hooks

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier" : @"id",
             @"name" : @"name",
             @"menuSections": @"menu_sections",
             @"isActive" : @"active"};
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

+(NSValueTransformer *)menuSectionsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[AMMenuSection class]];
}

-(BOOL)isEqual:(id)object
{
    if(self.class == [object class]) {
        return  [self.identifier isEqualToNumber:[(AMMenu *)object identifier]] ||
        (!self.identifier && ![(AMMenu *)object identifier]);
    }
    return NO;}

-(NSUInteger)hash
{
    return [self.identifier hash];
}

@end
