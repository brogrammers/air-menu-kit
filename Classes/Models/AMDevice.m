//
//  AMDevice.m
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMDevice.h"

@implementation AMDevice
+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier" : @"id",
            @"name" : @"name",
            @"uuid" : @"uuid",
            @"token" : @"token",
            @"platform" : @"platform"};
}

-(BOOL)isEqual:(id)object
{
    if(self.class == [object class]) {
        return  [self.identifier isEqualToNumber:[(AMDevice *)object identifier]] ||
                (!self.identifier && ![(AMDevice *)object identifier]);
    }
    return NO;
}

-(NSUInteger)hash
{
    return [self.identifier hash];
}

@end
