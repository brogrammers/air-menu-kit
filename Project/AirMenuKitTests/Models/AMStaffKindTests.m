//
//  AMStaffKindTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "AMStaffKind.h"
#import "AMOAuthToken.h"
#import <objc/objc-runtime.h>

SPEC_BEGIN(AMStaffKindTests)
describe(@"AMStaffKind", ^{
    context(@"object", ^{
        
        __block AMStaffKind *staffKind;
        
        beforeAll(^{
            staffKind = [AMStaffKind new];
            [staffKind setValuesForKeysWithDictionary:@{@"identifier" : @1,
                                                        @"name" : @"a name",
                                                        @"restaurant" : [AMRestaurant new],
                                                        @"scopes" : @[@(AMOAuthScopeUser)],
                                                        @"acceptsOrders" : @YES,
                                                        @"acceptsOrderItems" : @NO}];
        });
        
        it(@"subclasses MTLModel", ^{
            [[staffKind should] beKindOfClass:[MTLModel class]];
        });
        
        it(@"conforms to MTLJSONSerializer protocol", ^{
            [[staffKind should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
        
        it(@"has identifier attribute", ^{
            [[staffKind.identifier should] equal:@1];
        });
        
        it(@"has name attribute", ^{
            [[staffKind.name should] equal:@"a name"];
        });
        
        it(@"has restaurant attribute", ^{
            [[staffKind.restaurant should] equal:[AMRestaurant new]];
        });
        
        it(@"has scopes attribute", ^{
            [[staffKind.scopes should] equal:@[@(AMOAuthScopeUser)]];
        });
        
        it(@"has accepts orders attriute", ^{
            [[staffKind.acceptsOrders should] equal:@YES];
        });
        
        it(@"has accepts order items attribute", ^{
            [[staffKind.acceptsOrderItems should] equal:@NO];
        });
    });
    
    context(@"class", ^{
        it(@"returns correct mapping from JSONKeyPathsByPropertyKey", ^{
            NSDictionary *mapping = [AMStaffKind JSONKeyPathsByPropertyKey];
            NSDictionary *expectedMapping = @{@"identifier" : @"id",
                                              @"name" : @"name",
                                              @"restaurant" : @"restaurant",
                                              @"scopes" : @"scopes",
                                              @"acceptsOrders" : @"accept_orders",
                                              @"acceptsOrderItems" : @"accept_order_items",
                                              @"members" : @"staff_members"};
            [[mapping should] equal:expectedMapping];
        });
        
        it(@"responds to restaurantJSONTransformer", ^{
            [[[AMStaffKind class] should] respondToSelector:NSSelectorFromString(@"restaurantJSONTransformer")];
        });
        
        it(@"returns dicionary restaurant transformer from restaurantJSONTransformer", ^{
            NSValueTransformer *transformer = objc_msgSend([AMStaffKind class], NSSelectorFromString(@"restaurantJSONTransformer"));
            [[transformer shouldNot] beNil];
        });
        
        it(@"responds to scopesJSONTransformer", ^{
            [[[AMStaffKind class] should] respondToSelector:NSSelectorFromString(@"scopesJSONTransformer")];
        });
        
        it(@"returns array transformer from scopesJSONTransformer", ^{
            NSValueTransformer *transformer = objc_msgSend([AMStaffKind class], NSSelectorFromString(@"scopesJSONTransformer"));
            NSArray *scopesStrings = @[@"add_active_menus", @"get_groups"];
            NSArray *scopes = [transformer transformedValue:scopesStrings];
            [[scopes should] equal:@[@(AMOAuthScopeAddActiveMenus), @(AMOAuthScopeGetGroups)]];
            [[[transformer reverseTransformedValue:scopes] should] equal:scopesStrings];
        });
    });

    context(@"mapping", ^{
        __block AMStaffKind *staffKind;
        __block NSDictionary *parsedStaffKindJSON;
        __block NSDictionary *parsedRestaurantJSON;
        beforeAll(^{
            parsedRestaurantJSON = @{@"id" : @1,
                                     @"name" : @"Nandos"};
            parsedStaffKindJSON = @{@"id" : @1,
                                    @"name" : @"Manager",
                                    @"restaurant" : parsedRestaurantJSON,
                                    @"accept_order_items" : [NSNumber numberWithBool:NO],
                                    @"accept_orders" : [NSNumber numberWithBool:YES],
                                    @"scopes" : @[@"add_active_menus", @"get_groups"]};
            staffKind = [MTLJSONAdapter modelOfClass:[AMStaffKind class] fromJSONDictionary:parsedStaffKindJSON error:nil];
        });
        
        it(@"maps parsed staff kind JSON to AMStaffKind object", ^{
            [[staffKind.identifier should] equal:@1];
            [[staffKind.name should] equal:@"Manager"];
            [[staffKind.scopes should] equal:@[@(AMOAuthScopeAddActiveMenus), @(AMOAuthScopeGetGroups)]];
            [[staffKind.acceptsOrderItems should] equal:@NO];
            [[staffKind.acceptsOrders should] equal:@YES];
        });
        
        it(@"maps parsed restaurant JSON to AMRestaurant and hooks it up", ^{
            [[staffKind.restaurant.identifier should] equal:@1];
            [[staffKind.restaurant.name should] equal:@"Nandos"];
        });
    });
});
SPEC_END