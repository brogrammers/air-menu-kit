//
//  StaffMember.m
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMStaffMember.h"

@implementation AMStaffMember
+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier" : @"id",
             @"name" : @"name",
             @"restaurant" : @"restaurant",
             @"scopes" : @"scopes"};
}
@end
