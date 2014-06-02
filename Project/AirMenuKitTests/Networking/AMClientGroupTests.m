//
//  AMClientGroupTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 15/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#include <Kiwi/Kiwi.h>
#include "TestToolBox.h"
#include "AMClient+Group.h"

SPEC_BEGIN(AMClientGroupTests)

describe(@"AMClient+Group", ^{
    context(@"on error free flow", ^{
        context(@"on find group", ^{
            __block NSURLSessionDataTask *task;
            __block AMGroup *foundGroup;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"groups/1"]
                                     httpMethod:@"GET"
                             nameOfResponseFile:@"group.json"
                                   responseCode:200];
                
                task = [[AMClient sharedClient] findGroupWithIdentifier:@"1" completion:^(AMGroup *group, NSError *error) {
                    foundGroup = group;
                }];
            });
            
            it(@"uses GET method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"calls /groups/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"groups/1"]];
            });
            
            it(@"creates group object", ^{
                [[expectFutureValue(foundGroup) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:[TestToolBox objectFromJSONFromFile:@"group.json"]];
            });
        });
        
        context(@"on update group", ^{
            __block NSURLSessionDataTask *task;
            __block AMGroup *updatedGroup;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"groups/1"]
                                     httpMethod:@"PUT"
                             nameOfResponseFile:@"group.json"
                                   responseCode:200];
                
                AMGroup *group = [[AMGroup alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] updateGroup:group withNewName:@"new name" completion:^(AMGroup *group, NSError *error) {
                    updatedGroup = group;
                }];
            });
            
            it(@"uses PUT method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"PUT"];
            });
            
            it(@"calls /groups/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"groups/1"]];
            });
            
            it(@"crates group object", ^{
                [[expectFutureValue(updatedGroup) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:[TestToolBox objectFromJSONFromFile:@"group.json"]];
            });
            
            it(@"sends parameters in HTTP body", ^{
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"name" : @"new name"}];
            });
        });
        
        context(@"on delete group", ^{
            __block NSURLSessionDataTask *task;
            __block AMGroup *deletedGroup;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"groups/1"]
                                     httpMethod:@"DELETE"
                             nameOfResponseFile:@"group.json"
                                   responseCode:200];
                
                AMGroup *group = [[AMGroup alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] deleteGroup:group completion:^(AMGroup *group, NSError *error) {
                    deletedGroup = group;
                }];
            });
        
            it(@"uses DELETE method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"DELETE"];
            });
            
            it(@"calls /groups/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"groups/1"]];
            });
            
            it(@"creates group object", ^{
                [[expectFutureValue(deletedGroup) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:[TestToolBox objectFromJSONFromFile:@"group.json"]];
            });
        });
        
        context(@"on find staff members", ^{
            __block NSURLSessionDataTask *task;
            __block NSArray *foundMembers;
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"groups/1/staff_members"]
                                     httpMethod:@"GET"
                             nameOfResponseFile:@"staff_members.json"
                                   responseCode:200];
                
                AMGroup *group = [[AMGroup alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] findStaffMembersOfGroup:group completion:^(NSArray *staffMembers, NSError *error) {
                    foundMembers = staffMembers;
                }];
            });
            
            it(@"uses GET method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"calls /groups/1/staff_members", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"groups/1/staff_members"]];
            });
            
            it(@"creates array of staff members", ^{
                [[expectFutureValue(foundMembers) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:[TestToolBox objectFromJSONFromFile:@"staff_members.json"]];
            });
        });
        
        context(@"on add staff member", ^{
            __block NSURLSessionDataTask *task;
            __block AMStaffMember *newMember;
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"groups/1/staff_members"]
                                     httpMethod:@"POST"
                             nameOfResponseFile:@"staff_member.json"
                                   responseCode:200];
                
                AMGroup *group = [[AMGroup alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                AMStaffMember *member= [[AMStaffMember alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] addStaffMember:member toGroup:group completion:^(AMStaffMember *staffMember, NSError *error) {
                    newMember = staffMember;
                }];
            });
            
            it(@"uses POST method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"POST"];
            });
            
            it(@"calls /groups/1/staff_members", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"groups/1/staff_members"]];
            });
            
            it(@"creates staff member object", ^{
                [[expectFutureValue(newMember) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:[TestToolBox objectFromJSONFromFile:@"staff_member.json"]];
            });
            
            it(@"sends parameters in HTTP body", ^{
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"staff_member_id" : @"1"}];
            });
        });
    });
});

SPEC_END