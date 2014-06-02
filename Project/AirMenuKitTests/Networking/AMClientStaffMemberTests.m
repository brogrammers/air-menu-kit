//
//  AMClientStaffMemberTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 19/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#include <Kiwi/Kiwi.h>
#include "TestToolBox.h"
#include "AMClient+StaffMember.h"

SPEC_BEGIN(AMClientStaffMemberTests)
describe(@"AMClient+StaffMember", ^{
    context(@"on error free flow", ^{
        context(@"on find staff member", ^{
            __block NSURLSessionDataTask *task;
            __block AMStaffMember *foundStaffMember;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"staff_members/1"]
                                     httpMethod:@"GET"
                             nameOfResponseFile:@"staff_member.json"
                                   responseCode:200];
                
                task = [[AMClient sharedClient] findStaffMemberWithIdentifier:@"1" completion:^(AMStaffMember *staffMember, NSError *error) {
                    foundStaffMember = staffMember;
                }];
            });
            
            it(@"uses GET method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"calls /staff_members/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"staff_members/1"]];
            });
            
            it(@"creates staff member object", ^{
                [[expectFutureValue(foundStaffMember) shouldEventuallyBeforeTimingOutAfter(60.0)] equal:[TestToolBox objectFromJSONFromFile:@"staff_member.json"]];
            });
        });
        
        context(@"update staff member", ^{
            __block NSURLSessionDataTask *task;
            __block AMStaffMember *updatedStaffMember;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"staff_members/1"]
                                     httpMethod:@"PUT"
                             nameOfResponseFile:@"staff_member.json"
                                   responseCode:200];
                
                AMStaffMember *member = [[AMStaffMember alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] updateStaffMember:member withNewName:@"aname" newPassword:@"apass" newEmail:@"amail" newStaffKindId:@"1" avatar:nil newScopes:AMOAuthScopeAddMenus completion:^(AMStaffMember *staffMember, NSError *error) {
                    updatedStaffMember = staffMember;
                }];
            });
            
            it(@"uses PUT method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"PUT"];
            });
            
            it(@"calls /staff_members/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"staff_members/1"]];
            });
            
            it(@"creates staff member object", ^{
                [[expectFutureValue(updatedStaffMember) shouldEventuallyBeforeTimingOutAfter(60.0)] equal:[TestToolBox objectFromJSONFromFile:@"staff_member.json"]];
            });
            
            it(@"sends parameters in HTTP body", ^{
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"name" : @"aname", @"password" : @"apass", @"email" : @"amail", @"staff_kind_id" : @"1", @"scopes" : @"add_menus"}];
            });
        });
        
        context(@"delete staff member", ^{
            __block NSURLSessionDataTask *task;
            __block AMStaffMember *deletedStaffMember;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"staff_members/1"]
                                     httpMethod:@"DELETE"
                             nameOfResponseFile:@"staff_member.json"
                                   responseCode:200];
                AMStaffMember *member = [[AMStaffMember alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] deleteStaffMember:member completion:^(AMStaffMember *staffMember, NSError *error) {
                    deletedStaffMember = staffMember;
                }];
            });
            
            it(@"uses DELETE method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"DELETE"];
            });
            
            it(@"calls /staff_members/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"staff_members/1"]];
            });
            
            it(@"creates staff member object", ^{
                [[expectFutureValue(deletedStaffMember) shouldEventuallyBeforeTimingOutAfter(60.0)] equal:[TestToolBox objectFromJSONFromFile:@"staff_member.json"]];
            });
        });
    });
});
SPEC_END
