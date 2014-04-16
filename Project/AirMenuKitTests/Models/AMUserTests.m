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
                                                   @"scopes" : @[@"add_menus", @"remove_orders"]}];
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
            [[user.type should] equal:@"Owner"];
        });
        
        it(@"has email attribute", ^{
            [[user.email should] equal:@"rob@mail.ie"];
        });
        
        it(@"has scopes attribute", ^{
            [[user.scopes should] equal:@[@"add_menus", @"remove_orders"]];
        });
        
        it(@"has company attribute", ^{
       //     [[user.company should] equal:[AMCompany new]];
        });
        
        it(@"has current orders attribute", ^{
        //    [[user.currentOrders should] equal:[AMOrder new]];
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
                                              @"scopes" : @"scopes"};
            [[mapping should] equal:expectedMapping];
        });
    });
    
    context(@"mapping", ^{
        __block AMUser *user;
        __block NSDictionary *parsedUserJSON;
        
        beforeAll(^{
           parsedUserJSON = @{@"id" : @(1),
                              @"name" : @"Robert Lis",
                              @"type" : @"Manager",
                              @"identity" : @{@"username" : @"rob", @"email" : @"rob@gmail.com"},
                              @"scopes" : @[@"Manager"]};
            user = [MTLJSONAdapter modelOfClass:[AMUser class] fromJSONDictionary:parsedUserJSON error:nil];
        });
        
        it(@"maps parsed user JSON to AMUser object", ^{
            [[user.identifier should] equal:@(1)];
            [[user.name should] equal:@"Robert Lis"];
            [[user.type should] equal:@"Manager"];
            [[user.username should] equal:@"rob"];
            [[user.email should] equal:@"rob@gmail.com"];
            [[user.scopes should] equal:@[@"Manager"]];
        });
    });
});

SPEC_END