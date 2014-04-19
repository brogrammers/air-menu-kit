//
//  AMUserTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 09/03/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <objc/message.h>
#import <Kiwi/Kiwi.h>
#import "AMUser.h"
#import "NSDateFormatter+AirMenuTimestamp.h"
#import "AMOrder.h"
#import <objc/objc-runtime.h>
#import "AMOAuthToken.h"

SPEC_BEGIN(AMUserTests)

describe(@"AMUser", ^{
    context(@"object", ^{
        __block AMUser *user;
        
        beforeAll(^{
            user = [[AMUser alloc] init];
            [user setValuesForKeysWithDictionary:@{@"identifier" : @1,
                                                   @"name" : @"Rob",
                                                   @"username" : @"Fox",
                                                   @"type" : @"Owner",
                                                   @"email" : @"rob@mail.ie",
                                                   @"scopes" : @[@"add_menus", @"remove_orders"],
                                                   @"unreadCount" : @1,
                                                   @"phoneNumber" : @"12345",
                                                   @"company" : [AMCompany new],
                                                   @"currentOrders" : @[[AMOrder new]]}];
        });
        
        it(@"subclasses MTLModel", ^{
            [[user should] beKindOfClass:[MTLModel class]];
        });
        
        it(@"conforms to MTLJSONSerialising protocol", ^{
            [[user should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
        
        it(@"has identifier attribute", ^{
            [[user.identifier should] equal:@1];
        });
        
        it(@"has name attribute", ^{
            [[user.name should] equal:@"Rob"];
        });
        
        it(@"has username attribute", ^{
            [[user.username should] equal:@"Fox"];
        });
        
        it(@"has type attribute", ^{
            [[@(user.type) should] equal:@(AMUserTypeUser)];
        });
        
        it(@"has email attribute", ^{
            [[user.email should] equal:@"rob@mail.ie"];
        });
        
        it(@"has scopes attribute", ^{
            [[user.scopes should] equal:@[@"add_menus", @"remove_orders"]];
        });
        
        it(@"has phone attribute", ^{
            [[user.phoneNumber should] equal:@"12345"];
        });
        
        it(@"unread_count attribute", ^{
            [[user.unreadCount should] equal:@1];
        });
        
        it(@"has company attribute", ^{
            [[user.company should] equal:[AMCompany new]];
        });
        
        it(@"has current orders attribute", ^{
            [[user.currentOrders should] equal:@[[AMOrder new]]];
        });
        
    });
    
    context(@"class", ^{
        it(@"returns correct mapping from JSONKeyPathsByPropertyKey", ^{
            NSDictionary *mapping = [AMUser JSONKeyPathsByPropertyKey];
            NSDictionary *expectedMapping = @{@"identifier" : @"id",
                                              @"name" : @"name",
                                              @"username" : @"identity.username",
                                              @"email" : @"identity.email",
                                              @"type" : @"type",
                                              @"scopes" : @"scopes",
                                              @"phoneNumber" : @"phone",
                                              @"currentOrders" : @"current_orders",
                                              @"company" : @"company",
                                              @"unreadCount" : @"unread_count"};
            [[mapping should] equal:expectedMapping];
        });
        
        
        it(@"implements typeJSONTransformer", ^{
            [[[AMUser class] should] respondToSelector:NSSelectorFromString(@"typeJSONTransformer")];
        });
        
        it(@"returns string transformer from typeJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMUser class], NSSelectorFromString(@"typeJSONTransformer"));
            NSString *type = @"StaffMember";
            [[[valueTransformer reverseTransformedValue:[valueTransformer transformedValue:type]] should] equal:@"StaffMember"];
        });
        
        it(@"implements scopesJSONTransformer", ^{
            [[[AMUser class] should] respondToSelector:NSSelectorFromString(@"scopesJSONTransformer")];
        });
        
        it(@"returns array transfromer from scopesJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMUser class], NSSelectorFromString(@"scopesJSONTransformer"));
            [[[valueTransformer transformedValue:@[@"update_orders"]] should] equal:@[@(AMOAuthScopeUpdateOrders)]];
            [[[valueTransformer reverseTransformedValue:@[@(AMOAuthScopeUpdateOrders)]] should] equal:@[@"update_orders"]];
        });
        
        it(@"implements companyJSONTransformer", ^{
            [[[AMUser class] should] respondToSelector:NSSelectorFromString(@"companyJSONTransformer")];
        });
        
        it(@"returns dicionary company transformer from companyJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMUser class], NSSelectorFromString(@"companyJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
        });
        
        it(@"implements currentOrdersJSONTransformer", ^{
            [[[AMUser class] should] respondToSelector:NSSelectorFromString(@"currentOrdersJSONTransformer")];
        });
        
        it(@"returns array orders tansformer from currentOrdersJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMUser class], NSSelectorFromString(@"currentOrdersJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
        });
        
    });
    
    context(@"mapping", ^{
        __block AMUser *user;
        __block NSDictionary *parsedUserJSON;
        __block NSDictionary *companyParsedJSON;
        __block NSDictionary *orderParsedJSON;
        
        
        beforeAll(^{
            companyParsedJSON = @{@"id" : @1, @"name" : @"acompany"};
            orderParsedJSON = @{@"id" : @1 , @"state" : @"new"};
            
            parsedUserJSON = @{@"id" : @(1),
                              @"name" : @"Robert Lis",
                              @"type" : @"Owner",
                              @"identity" : @{@"username" : @"rob", @"email" : @"rob@gmail.com"},
                              @"scopes" : @[@"update_orders", @"create_groups"],
                              @"current_orders" : @[orderParsedJSON],
                              @"company" : companyParsedJSON };
            
            user = [MTLJSONAdapter modelOfClass:[AMUser class] fromJSONDictionary:parsedUserJSON error:nil];
        });
        
        it(@"maps parsed user JSON to AMUser object", ^{
            [[user.identifier should] equal:@(1)];
            [[user.name should] equal:@"Robert Lis"];
            [[@(user.type) should] equal:@(AMUserTypeOwner)];
            [[user.username should] equal:@"rob"];
            [[user.email should] equal:@"rob@gmail.com"];
            [[user.scopes should] equal:@[@(AMOAuthScopeUpdateOrders), @(AMOAuthScopeCreateGroups)]];
        });
        
        it(@"it maps parsed company JSON and hooks it up", ^{
            [[user.company.identifier should] equal:@1];
            [[user.company.name should] equal:@"acompany"];
        });
        
        it(@"it maps parsed order JSON and hooks it up", ^{
            AMOrder *order = user.currentOrders[0];
            [[order.identifier should] equal:@1];
            [[@(order.state) should] equal:@(AMOrderStateNew)];
        });
    });
});

SPEC_END