//
//  AMAddress.m
//  AirMenuKit
//
//  Created by Robert Lis on 03/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMAddress.h"
#import "NSDateFormatter+AirMenuTimestamp.h"

@implementation AMAddress

#pragma mark - Mantle framework mapping hooks

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
                @"identifier" : @"id",
                @"addressLine1" : @"address_1",
                @"addressLine2" : @"address_2",
                @"city" : @"city",
                @"county" : @"county",
                @"country": @"country"
             };
}

-(BOOL)isEqual:(id)object
{
    if(self.class == [object class]) {
        return  [self.identifier isEqualToNumber:[(AMAddress *)object identifier]] ||
        (!self.identifier && ![(AMAddress *)object identifier]);
    }
    return NO;}

-(NSUInteger)hash
{
    return [self.identifier hash];
}

@end
