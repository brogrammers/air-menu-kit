//
//  AMGroupTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "AMGroup.h"
#import "AMStaffMember.h"
#import <objc/objc-runtime.h>

SPEC_BEGIN(AMGroupTests)
describe(@"AMGroup", ^{
    
    context(@"object", ^{
        __block AMGroup *group;
        
        beforeAll(^{
            group = [AMGroup new];
            [group setValuesForKeysWithDictionary:@{@"identifier" : @1,
                                                    @"name" : @"a name",
                                                    @"device" : [AMDevice new],
                                                    @"staffMembers" : @[[AMStaffMember new]]}];
        });
        
        it(@"subclasses MTLModel", ^{
            [[group should] beKindOfClass:[AMGroup class]];
        });
        
        it(@"conforms to MTLJSONSerializer protocol", ^{
            [[group should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });

        it(@"has identifier attribute", ^{
            [[group.identifier should] equal:@1];
        });
        
        it(@"has name attribute", ^{
            [[group.name should] equal:@"a name"];
        });
        
        it(@"has device attribute", ^{
            [[group.device should] equal:[AMDevice new]];
        });
        
        it(@"has staff members attribute", ^{
            [[group.staffMembers should] equal:@[[AMStaffMember new]]];
        });

    });
    
    context(@"class", ^{
        it(@"returns correct mapping from JSONKeyPathsByPropertyKey", ^{
            NSDictionary *mapping = [AMGroup JSONKeyPathsByPropertyKey];
            NSDictionary *expectedMapping = @{@"identifier" : @"id",
                                              @"name" : @"name",
                                              @"device" : @"device",
                                              @"staffMembers" : @"staff_members"};
            [[mapping should] equal:expectedMapping];
        });
        
        it(@"implements deviceJSONTransformer", ^{
            [[[AMGroup class] should] respondToSelector:NSSelectorFromString(@"deviceJSONTransformer")];
        });
        
        it(@"returns dictionary device transformer from deviceJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMGroup class], NSSelectorFromString(@"deviceJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
        });
        
        it(@"implements staffMembersJSONTransformer", ^{
            [[[AMGroup class] should] respondToSelector:NSSelectorFromString(@"staffMembersJSONTransformer")];
        });
        
        it(@"returns array staff members transformer from staffMembersJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMGroup class], NSSelectorFromString(@"staffMembersJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
        });
    });
    
    context(@"mapping", ^{
        __block AMGroup *group;
        __block NSDictionary *parsedGroupJSON;
        __block NSDictionary *parsedDeviceJSON;
        __block NSArray *staffMembers;
        
        beforeAll(^{
            parsedDeviceJSON = @{@"id" : @3,
                                 @"uuid" : @"a uuid",
                                 @"token" : @"a token",
                                 @"platform" : @"ios"};
            staffMembers = @[@{@"id" : @2,
                               @"name" : @"emma"}];
            parsedGroupJSON = @{@"id" : @1,
                                @"name" : @"Waiters",
                                @"device" : parsedDeviceJSON,
                                @"staff_members" : staffMembers};
            group = [MTLJSONAdapter modelOfClass:[AMGroup class] fromJSONDictionary:parsedGroupJSON error:nil];
        });
        
        it(@"correctly maps group JSON to AMGroup object", ^{
            [[group.identifier should] equal:@1];
            [[group.name should] equal:@"Waiters"];
        });
        
        it(@"correctly maps staff members and hooks it up", ^{
            [[[group.staffMembers[0] identifier] should] equal:@2];
            [[[group.staffMembers[0] name] should] equal:@"emma"];
        });
        
        it(@"corretly maps devices and hooks it up", ^{
            [[group.device.identifier should] equal:@3];
            [[group.device.uuid should] equal:@"a uuid"];
            [[group.device.token should] equal:@"a token"];
            [[group.device.platform should] equal:@"ios"];
        });
    });
});
SPEC_END