//
//  AMOAuthToken.m
//  AirMenuKit
//
//  Created by Robert Lis on 11/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMOAuthToken.h"
#import <ObjectiveSugar/NSNumber+ObjectiveSugar.h>

@implementation AMOAuthToken

#pragma mark - Mantle framework mapping hooks
+(NSDictionary *)numberToScopesMapping
{
    return @{
                 @(AMOAuthScopeNone) : @"",
                 @(AMOAuthScopeBasic) : @"basic",
                 @(AMOAuthScopeAdmin) : @"admin",
                 @(AMOAuthScopeTrusted) : @"trusted",
                 @(AMOAuthScopeUser) : @"user",
                 @(AMOAuthScopeDeveloper) : @"developer",
                 @(AMOAuthScopeOwner) : @"owner",
                 @(AMOAuthScopeGetMenus) : @"get_menus",
                 @(AMOAuthScopeAddMenus) : @"add_menus",
                 @(AMOAuthScopeAddActiveMenus) : @"add_active_menus",
                 @(AMOAuthScopeGetCurrentOrders) : @"get_current_orders",
                 @(AMOAuthScopeAddOrders) : @"add_orders",
                 @(AMOAuthScopeUpdateOrders) : @"update_orders",
                 @(AMOAuthScopeGetGroups) : @"get_groups",
                 @(AMOAuthScopeCreateGroups) : @"create_groups",
                 @(AMOAuthScopeGetDevices) : @"get_devices",
                 @(AMOAuthScopeCreateDevices) : @"create_devices",
                 @(AMOAuthScopeGetStaffKinds) : @"get_staff_kinds",
                 @(AMOAuthScopeCreateStaffKinds) : @"create_staff_kinds",
                 @(AMOAuthScopeGetStaffMembers) : @"get_staff_members",
                 @(AMOAuthScopeCreateStaffMembers) : @"create_staff_members"
             };
}

+(NSDictionary *)scopesToNumberMapping
{
    return @{
                 @"" : @(AMOAuthScopeNone),
                 @"basic" : @(AMOAuthScopeBasic),
                 @"admin" : @(AMOAuthScopeAdmin),
                 @"trusted" : @(AMOAuthScopeTrusted),
                 @"user" : @(AMOAuthScopeUser),
                 @"developer" : @(AMOAuthScopeDeveloper),
                 @"owner" : @(AMOAuthScopeOwner),
                 @"get_menus" : @(AMOAuthScopeGetMenus),
                 @"add_menus" :@(AMOAuthScopeAddMenus),
                 @"add_active_menus" : @(AMOAuthScopeAddActiveMenus),
                 @"get_current_orders" : @(AMOAuthScopeGetCurrentOrders),
                 @"add_orders" : @(AMOAuthScopeAddOrders),
                 @"update_orders" : @(AMOAuthScopeUpdateOrders),
                 @"get_groups" : @(AMOAuthScopeGetGroups),
                 @"create_groups" :  @(AMOAuthScopeCreateGroups),
                 @"get_devices" :  @(AMOAuthScopeGetDevices),
                 @"create_devices" : @(AMOAuthScopeCreateDevices),
                 @"get_staff_kinds" : @(AMOAuthScopeGetStaffKinds),
                 @"create_staff_kinds" : @(AMOAuthScopeCreateStaffKinds),
                 @"get_staff_members" : @(AMOAuthScopeGetStaffMembers),
                 @"create_staff_members" : @(AMOAuthScopeCreateStaffMembers)
             };

}

+(AMOAuthScope)allScopes
{
    return  AMOAuthScopeBasic &
            AMOAuthScopeAdmin &
            AMOAuthScopeTrusted &
            AMOAuthScopeUser &
            AMOAuthScopeDeveloper &
            AMOAuthScopeOwner &
            AMOAuthScopeGetMenus &
            AMOAuthScopeAddMenus &
            AMOAuthScopeAddActiveMenus &
            AMOAuthScopeGetCurrentOrders &
            AMOAuthScopeAddOrders &
            AMOAuthScopeUpdateOrders &
            AMOAuthScopeGetGroups &
            AMOAuthScopeCreateGroups &
            AMOAuthScopeGetDevices &
            AMOAuthScopeCreateDevices &
            AMOAuthScopeGetStaffKinds &
            AMOAuthScopeCreateStaffKinds &
            AMOAuthScopeGetStaffMembers &
            AMOAuthScopeCreateStaffMembers;
}

+(NSArray *)stringsFromOptions:(AMOAuthScope)scope
{
    NSMutableArray *scopesArray = [NSMutableArray array];
    [[self numberToScopesMapping] eachKey:^(NSNumber *value) {
        AMOAuthScope option = [value unsignedIntegerValue];
        if(option & scope)
        {
            [scopesArray addObject:[self numberToScopesMapping][@(option)]];
        }
    }];
    return scopesArray;
}

+(NSString *)stringFromOption:(AMOAuthScope)scope
{
    NSArray *scopeStrings = [self stringsFromOptions:scope];
    NSMutableString *string = [@"" mutableCopy];
    [scopeStrings each:^(NSString *object) {
        [string appendString:object];
        [string appendString:@" "];
    }];
    [string deleteCharactersInRange:NSMakeRange(string.length - 1, 1)];
    return string;
}

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"token" : @"token",
             @"refreshToken" : @"refresh_token",
             @"type" : @"token_type",
             @"expiresAt" : @"expires_in_seconds",
             @"scopes": @"scopes"};
}

+(NSValueTransformer *)expiresAtJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *seconds) {
        return [NSDate dateWithTimeIntervalSinceNow:[seconds intValue]];
    } reverseBlock:^(NSDate *date) {
        return @(0);
    }];
}

@end
