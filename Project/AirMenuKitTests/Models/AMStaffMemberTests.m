//
//  AMStaffMemberTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "AMStaffMember.h"
#import "AMOAuthToken.h"
#import <objc/objc-runtime.h>

SPEC_BEGIN(AMStaffMemberTests)
describe(@"AMStaffMember", ^{
    context(@"object", ^{
        __block AMStaffMember *staffMember;
        
        beforeAll(^{
            staffMember = [AMStaffMember new];
            [staffMember setValuesForKeysWithDictionary:@{@"identifier" : @1,
                                                          @"name" : @"a name",
                                                          @"restaurant" : [AMRestaurant new],
                                                          @"scopes" : @[@(AMOAuthScopeGetGroups), @(AMOAuthScopeAddMenus)],
                                                          @"username" : @"a username",
                                                          @"email" : @"an email",
                                                          @"device" : [AMDevice new],
                                                          @"group" : [AMGroup new],
                                                          @"kind" : [AMStaffKind new],
                                                          @"restaurant" : [AMRestaurant new]}];
        });
        
        it(@"sublcasses MTLModel", ^{
            [[staffMember should] beKindOfClass:[MTLModel class]];
        });
        
        it(@"conforms to MTLJSONSerializer protocol", ^{
            [[staffMember should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
        
        it(@"has identifier attribute", ^{
            [[staffMember.identifier should] equal:@1];
        });
        
        it(@"has name attribute", ^{
            [[staffMember.name should] equal:@"a name"];
        });
        
        it(@"has username attribute", ^{
            [[staffMember.username should] equal:@"a username"];
        });
        
        it(@"has email attribute", ^{
            [[staffMember.email should] equal:@"an email"];
        });
        
        it(@"has scopes attribute", ^{
            [[staffMember.scopes should] equal:@[@(AMOAuthScopeGetGroups), @(AMOAuthScopeAddMenus)]];
        });
        
        it(@"has device attribute", ^{
            [[staffMember.device should] equal:[AMDevice new]];
        });
        
        it(@"has group attribute", ^{
            [[staffMember.group should] equal:[AMGroup new]];
        });
        
        it(@"has kind attribute", ^{
           [[staffMember.kind should] equal:[AMStaffKind new]];
        });
        
        it(@"has restaurant attribute", ^{
            [[staffMember.restaurant should] equal:[AMRestaurant new]];
        });
    });
    
    context(@"class", ^{
        it(@"returns correct mapping from JSONKeyPathsByPropertyKey", ^{
            NSDictionary *mapping = [AMStaffMember JSONKeyPathsByPropertyKey];
            NSDictionary *expectedMapping = @{@"identifier" : @"id",
                                              @"name" : @"name",
                                              @"username" : @"identity.username",
                                              @"email" : @"identity.email",
                                              @"scopes" : @"scopes",
                                              @"restaurant" : @"restaurant",
                                              @"device" : @"device",
                                              @"group" : @"group",
                                              @"kind" : @"staff_kind"};
            [[mapping should] equal:expectedMapping];
        });
        
        it(@"implements restaurantJSONTransformer", ^{
            [[[AMStaffMember class] should] respondToSelector:NSSelectorFromString(@"restaurantJSONTransformer")];
        });
        
        it(@"returns dictionary restaurant transformer from restaurantJSONTransformer", ^{
            NSValueTransformer *transformer = objc_msgSend([AMStaffMember class], NSSelectorFromString(@"restaurantJSONTransformer"));
            [[transformer shouldNot] beNil];
        });
        
        it(@"implements deviceJSONTransformer", ^{
            [[[AMStaffMember class] should] respondToSelector:NSSelectorFromString(@"deviceJSONTransformer")];
        });
        
        it(@"returns dictionary restaurant transformer from deviceJSONTrasformer", ^{
            NSValueTransformer *transformer = objc_msgSend([AMStaffMember class], NSSelectorFromString(@"deviceJSONTransformer"));
            [[transformer shouldNot] beNil];
        });
        
        it(@"implements groupJSONTransformer ", ^{
            [[[AMStaffMember class] should] respondToSelector:NSSelectorFromString(@"groupJSONTransformer")];
        });
        
        it(@"returns dicionary group transformer from ", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMStaffMember class], NSSelectorFromString(@"groupJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
        });
        
        it(@"it implements scopesJSONTransformer", ^{
            [[[AMStaffMember class] should] respondToSelector:NSSelectorFromString(@"scopesJSONTransformer")];
        });
        
        it(@"it returns scopes array transformer from scopesJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMStaffMember class], NSSelectorFromString(@"scopesJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
        });
        
        it(@"it implements kindJSONTransformer", ^{
            [[[AMStaffMember class] should] respondToSelector:NSSelectorFromString(@"kindJSONTransformer")];
        });
        
        it(@"returns dictionary staff kind transformer from kindJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMStaffMember class], NSSelectorFromString(@"kindJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
        });
    });
    
    context(@"mapping", ^{
        
        __block AMStaffMember *member;
        __block NSDictionary *parsedStaffMemberJSON;
        __block NSDictionary *parsedRestaurantJSON;
        __block NSDictionary *parsedStaffKindJSON;
        __block NSDictionary *parsedDeviceJSON;
        __block NSDictionary *parsedGroupJSON;
        
        beforeAll(^{
            parsedGroupJSON = @{@"id" : @1,
                                @"name" : @"Waitress"};
            parsedDeviceJSON = @{@"id" : @1,
                                 @"uuid" : @"a uuid",
                                 @"token" : @"a token",
                                 @"platform" : @"platform"};
            parsedRestaurantJSON = @{@"id" : @1,
                                     @"name" : @"The Church"};
            parsedStaffKindJSON = @{@"id" : @2,
                                    @"name" : @"Waitress"};
            parsedStaffMemberJSON = @{@"group" : parsedGroupJSON,
                                      @"device" : parsedDeviceJSON,
                                      @"restaurant" : parsedRestaurantJSON,
                                      @"staff_kind" : parsedStaffKindJSON,
                                      @"id" : @2,
                                      @"name" : @"Emma Blah",
                                      @"identity" : @{@"username" : @"emma", @"email" : @"emma@mckenna.ie"}};
            member = [MTLJSONAdapter modelOfClass:[AMStaffMember class] fromJSONDictionary:parsedStaffMemberJSON error:nil];
        });
        
        it(@"maps parsed staff member JSON to AMStaffMember", ^{
            [[member.identifier should] equal:@2];
            [[member.name should] equal:@"Emma Blah"];
            [[member.username should] equal:@"emma"];
            [[member.email should] equal:@"emma@mckenna.ie"];
        });
        
        it(@"maps parsed device JSON and hooks it up", ^{
            [[member.device.identifier should] equal:@1];
            [[member.device.uuid should] equal:@"a uuid"];
            [[member.device.token should] equal:@"a token"];
        });
        
        it(@"maps staff kind JSON and hooks it up", ^{
            [[member.kind.identifier should] equal:@2];
            [[member.kind.name should] equal:@"Waitress"];
        });
        
        it(@"maps group JSON and hooks it up", ^{
            [[member.group.identifier should] equal:@1];
            [[member.group.name should] equal:@"Waitress"];
        });
    });
});
SPEC_END