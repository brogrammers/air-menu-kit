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
            parsedDeviceJSON = @{@"" : @""};
            staffMembers = @[];
            parsedGroupJSON = @{@"id" : @1,
                                @"name" : @"Waiters",
                                @"device" : parsedDeviceJSON,
                                @"staff_members" : staffMembers};
            group = [MTLJSONAdapter modelOfClass:[AMGroup class] fromJSONDictionary:parsedGroupJSON error:nil];
        });
    });
});
SPEC_END