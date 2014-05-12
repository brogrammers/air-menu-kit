//
//  AMClientStaffKindTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 19/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#include <Kiwi/Kiwi.h>
#include "TestToolBox.h"
#include "AMClient+StaffKind.h"

SPEC_BEGIN(AMClientStaffKindTests)
describe(@"AMClient+StaffKind", ^{
    context(@"on error free flow", ^{
        context(@"on find staff kind with identifier", ^{
            __block NSURLSessionDataTask *task;
            __block AMStaffKind *foundStaffKind;
            
            beforeAll(^{
                
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"staff_kinds/1"]
                                     httpMethod:@"GET"
                             nameOfResponseFile:@"staff_kind.json"
                                   responseCode:200];
                task = [[AMClient sharedClient] findStaffKindWithIdentifier:@"1" completion:^(AMStaffKind *staffKind, NSError *error) {
                    foundStaffKind = staffKind;
                }];
            });
            
            it(@"uses GET method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"calls /staff_kinds/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"staff_kinds/1"]];
            });
            
            it(@"creates staff kind object", ^{
                [[expectFutureValue(foundStaffKind) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"staff_kind.json"]];
            });
        });
        
        context(@"on update staff kind", ^{
            __block NSURLSessionDataTask *task;
            __block AMStaffKind *updatedStaffKind;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"staff_kinds/1"]
                                     httpMethod:@"PUT"
                             nameOfResponseFile:@"staff_kind.json"
                                   responseCode:200];
                AMStaffKind *staffKind = [[AMStaffKind alloc] initWithDictionary:@{@"identifier" : @"1"} error:nil];
                task = [[AMClient sharedClient] updateStaffKind:staffKind withNewName:@"aname" newScopes:(AMOAuthScopeAddMenus | AMOAuthScopeAddOrders) newAcceptsOrders:YES newAcceptsOrderItems:YES completion:^(AMStaffKind *staffKind, NSError *error) {
                    updatedStaffKind = staffKind;
                }];
            });
            
            it(@"uses PUT method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"PUT"];
            });
            
            it(@"calls /staff_kinds/1", ^{
                [[task.originalRequest.URL.absoluteString shouldEventually] equal:[baseURL stringByAppendingString:@"staff_kinds/1"]];
            });
            
            it(@"creates staff kind object", ^{
                [[expectFutureValue(updatedStaffKind) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"staff_kind.json"]];
            });
            
            it(@"sends parameters in HTTP body", ^{
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"name" : @"aname",
                                                                                   @"scopes" : @"add_menus add_orders",
                                                                                   @"accept_orders" : @"true",
                                                                                   @"accept_order_items" : @"true",
                                                                                   @"scopes" : @"add_menus add_orders"}];
            });
        });
        
        context(@"on delete staff kind", ^{
            __block NSURLSessionDataTask *task;
            __block AMStaffKind *deletedStaffKind;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"staff_kinds/1"]
                                     httpMethod:@"DELETE"
                             nameOfResponseFile:@"staff_kind.json"
                                   responseCode:200];
                
                AMStaffKind *kind = [[AMStaffKind alloc] initWithDictionary:@{@"identifier" : @"1"} error:nil];
                task = [[AMClient sharedClient] deleteStaffKind:kind completion:^(AMStaffKind *staffKind, NSError *error) {
                    deletedStaffKind = staffKind;
                }];
            });
            
            it(@"uses DELETE method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"DELETE"];
            });
            
            it(@"calls /staff_kinds/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"staff_kinds/1"]];
            });
            
            it(@"creates staff kind object", ^{
                [[expectFutureValue(deletedStaffKind) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"staff_kind.json"]];
            });
        });
    });
});
SPEC_END