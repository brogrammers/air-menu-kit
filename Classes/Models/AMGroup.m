//
//  AMGroup.m
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMGroup.h"
#import "AMStaffMember.h"

@implementation AMGroup
+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier" : @"id",
             @"name" : @"name",
             @"device" : @"device",
             @"staffMembers" : @"staff_members"};
}

+(NSValueTransformer *)deviceJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AMDevice class]];
}

+(NSValueTransformer *)staffMembersJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[AMStaffMember class]];
}

-(BOOL)isEqual:(id)object
{
    if(self.class == [object class]) {
        return  [self.identifier isEqualToNumber:[(AMGroup *)object identifier]] ||
        (!self.identifier && ![(AMGroup *)object identifier]);
    }
    return NO;}

-(NSUInteger)hash
{
    return [self.identifier hash];
}

@end
