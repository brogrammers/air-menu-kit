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

SPEC_BEGIN(AMStaffMemberTests)
describe(@"AMStaffMember", ^{
    context(@"object", ^{
        __block AMStaffMember *staffMember;
        
        beforeAll(^{
            staffMember = [AMStaffMember new];
            [staffMember setValuesForKeysWithDictionary:@{@"identifier" : @1,
                                                          @"name" : @"a name",
                                                          @"restaurant" : [AMRestaurant new],
                                                          @"scopes" : @[@(AMOAuthScopeGetGroups), @(AMOAuthScopeAddMenus)]}];
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
        
//        it(@"has username attribute", ^{
//            [[staffMember.username should] equal:@"a username"];
//        });
//        
//        it(@"has email attribute", ^{
//            [[staffMember.email should] equal:@"an email"];
//        });
//        
//        it(@"has scopes attribute", ^{
//            [[staffMember.scopes should] equal:@[@(AMOAuthScopeGetGroups), @(AMOAuthScopeAddMenus)]];
//        });
//        
//        it(@"has device attribute", ^{
//            [[staffMember.device should] equal:[AMDevice new]];
//        });
//        
//        it(@"has group attribute", ^{
//            [[staffMember.group should] equal:[AMGroup new]];
//        });
//        
//        it(@"has kind attribute", ^{
//            [[staffMember.kind should] equal:[AMStaffKind new]];
//        });
//        
//        it(@"has restaurant attribute", ^{
//            [[staffMember.restaurant should] equal:[AMRestaurant new]];
//        });
    });
    
    context(@"class", ^{
        it(@"returns correct mapping from JSONKeyPathsByPropertyKey", ^{
            NSDictionary *mapping = [AMStaffMember JSONKeyPathsByPropertyKey];
            NSDictionary *expectedMapping = @{@"identifier" : @"id",
                                              @"name" : @"name",
                                              @"restaurant" : @"restaurant",
                                              @"scopes" : @"scopes"};
            [[mapping should] equal:expectedMapping];
        });
    });
    
    context(@"mapping", ^{
        
    });
});
SPEC_END