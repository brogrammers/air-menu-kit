//
//  AMUser.m
//  AirMenuKit
//
//  Created by Robert Lis on 09/03/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMUser.h"

@implementation AMUser

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier" : @"id",
             @"name" : @"name",
             @"username" : @"identity.username",
             @"email" : @"identity.email",
             @"type" : @"type",
             @"scopes" : @"scopes"};
}
@end
