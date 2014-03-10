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
    });
    
    context(@"class", ^{
        
    });
    
    context(@"mapping", ^{
        
    });
});

SPEC_END