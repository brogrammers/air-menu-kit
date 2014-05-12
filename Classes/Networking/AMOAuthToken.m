//
//  AMOAuthToken.m
//  AirMenuKit
//
//  Created by Robert Lis on 11/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMOAuthToken.h"
#import <ObjectiveSugar/ObjectiveSugar.h>

@implementation AMOAuthToken

#pragma mark - Mantle framework mapping hooks

+(NSArray *)scopesStrings
{
    return  @[ @"basic",
               @"admin",
               @"trusted",
               @"user",
               @"developer",
               @"owner",
               //menus
               @"get_menus",
               @"add_menus",
               @"add_active_menus",
               @"update_menus",
               @"delete_menus",
               //orders
               @"get_orders",
               @"add_orders",
               @"update_orders",
               //groups
               @"get_groups",
               @"create_groups",
               @"update_groups",
               @"delete_groups",
               //devices
               @"get_devices",
               @"create_devices",
               @"update_devices",
               @"delete_devices",
               //staff kinds
               @"get_staff_kinds",
               @"create_staff_kinds",
               @"update_staff_kinds",
               @"delete_staff_kinds",
               //staff members
               @"get_staff_members",
               @"create_staff_members",
               @"delete_staff_members",
               @"update_staff_members",
               //payments
               @"create_payments",
               //openinng hours
               @"get_opening_hours",
               @"create_opening_hours",
               @"update_opening_hours",
               @"delete_opening_hours"];
}

+(NSArray *)scopesNumbers
{
    return     @[@(AMOAuthScopeBasic),
                 @(AMOAuthScopeAdmin),
                 @(AMOAuthScopeTrusted),
                 @(AMOAuthScopeUser),
                 @(AMOAuthScopeDeveloper),
                 @(AMOAuthScopeOwner),
                 //menus
                 @(AMOAuthScopeGetMenus),
                 @(AMOAuthScopeAddMenus),
                 @(AMOAuthScopeAddActiveMenus),
                 @(AMOAuthScopeUpdateMenus),
                 @(AMOAuthScopeDeleteMenus),
                 //orders
                 @(AMOAuthScopeGetOrders),
                 @(AMOAuthScopeAddOrders),
                 @(AMOAuthScopeUpdateOrders),
                 //groups
                 @(AMOAuthScopeGetGroups),
                 @(AMOAuthScopeCreateGroups),
                 @(AMOAuthScopeUpdateGroups),
                 @(AMOAuthScopeDeleteGroups),
                 //device
                 @(AMOAuthScopeGetDevices),
                 @(AMOAuthScopeCreateDevices),
                 @(AMOAuthScopeUpdateDevices),
                 @(AMOAuthScopeDeleteDevices),
                 //staff kinds
                 @(AMOAuthScopeGetStaffKinds),
                 @(AMOAuthScopeCreateStaffKinds),
                 @(AMOAuthScopeUpdateStaffKinds),
                 @(AMOAuthScopeDeleteStaffKinds),
                 //staff members
                 @(AMOAuthScopeGetStaffMembers),
                 @(AMOAuthScopeCreateStaffMembers),
                 @(AMOAuthScopeDeleteStaffMembers),
                 @(AMOAuthScopeUpdateStaffMembers),
                 //payment
                 @(AMOAuthScopeCreatePayments),
                 //hours
                 @(AMOAuthScopeCreateOpeningHours),
                 @(AMOAuthScopeGetOpeningHours),
                 @(AMOAuthScopeUpdateOpeningHours),
                 @(AMOAuthScopeDeleteOpeningHours)];
}

+(NSDictionary *)numberToScopesMapping
{
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    [[self scopesNumbers] eachWithIndex:^(NSNumber *scope, NSUInteger index) {
        [mapping setObject:[self scopesStrings][index] forKey:scope];
    }];
    return mapping;
}

+(NSDictionary *)scopesToNumberMapping
{
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    [[self scopesStrings] eachWithIndex:^(NSString *scope, NSUInteger index) {
        [mapping setObject:[self scopesNumbers][index] forKey:scope];
    }];
    return mapping;
}

+(AMOAuthScope)allScopes
{
    __block AMOAuthScope scopes = AMOAuthScopeNone;
    [[self scopesNumbers] each:^(NSNumber *scope) {
        scopes |= [scope unsignedIntegerValue];
    }];
    return scopes;
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
