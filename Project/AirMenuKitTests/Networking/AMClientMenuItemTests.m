//
//  AMClientMenuItemTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 22/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "AMClient+MenuItem.h"
#import "TestToolBox.h"

SPEC_BEGIN(AMClientMenuItemTests)

describe(@"AMClient+AMMenuItem", ^{
    context(@"on error free flow", ^{
       context(@"on find menu item", ^{
           __block NSURLSessionDataTask *task;
           __block AMMenuItem *foundItem;
           beforeAll(^{
            [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"menu_items/1"]
                                 httpMethod:@"GET"
                         nameOfResponseFile:@"menu_item.json"
                               responseCode:200];
               
              task = [[AMClient sharedClient] findMenuItemWithIdentifier:@"1" completion:^(AMMenuItem *item, NSError *error) {
                  foundItem = item;
              }];
           });
           
           it(@"uses GET method", ^{
               [[task.originalRequest.HTTPMethod should] equal:@"GET"];
           });
           
           it(@"calls /menu_items/1", ^{
               [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"menu_items/1"]];
           });
           
           it(@"creates menu item object", ^{
               [[expectFutureValue(foundItem) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"menu_item.json"]];
           });
       });
    });
    
    context(@"on update menu item", ^{
        __block NSURLSessionDataTask *task;
        __block AMMenuItem *updatedItem;
        beforeAll(^{
            [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"menu_items/1"]
                                 httpMethod:@"PUT"
                         nameOfResponseFile:@"menu_item.json"
                               responseCode:200];
            
            AMMenuItem *menuItem = [[AMMenuItem alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
            task = [[AMClient sharedClient] updateMenuItem:menuItem withNewName:@"newname" newDescription:@"newdesc" newPrice:@2.5 newCurrency:@"newcurr" newStaffKindId:@"1" completion:^(AMMenuItem *item, NSError *error) {
                updatedItem = item;
            }];
        });
        
        it(@"uses PUT method", ^{
            [[task.originalRequest.HTTPMethod should] equal:@"PUT"];
        });
        
        it(@"calls /menu_items/1", ^{
            [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"menu_items/1"]];
        });
        
        it(@"creates menu item object", ^{
            [[expectFutureValue(updatedItem) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"menu_item.json"]];
        });
        
        it(@"sends parameters in HTTP body", ^{
            [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"name" : @"newname", @"description" : @"newdesc", @"price" : @"2.5", @"currency" : @"newcurr", @"staff_kind_id" : @"1"}];
        });
    });
    
    context(@"on delete menu item", ^{
        __block NSURLSessionDataTask *task;
        __block AMMenuItem *deletedItem;
        
        beforeAll(^{
            [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"menu_items/1"]
                                 httpMethod:@"DELETE"
                         nameOfResponseFile:@"menu_item.json"
                               responseCode:200];
            
            AMMenuItem *menuItem = [[AMMenuItem alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
            task = [[AMClient sharedClient] deleteMenuItem:menuItem completion:^(AMMenuItem *item, NSError *error) {
                deletedItem = item;
            }];
        });
        
        it(@"uses DELETE method", ^{
            [[task.originalRequest.HTTPMethod should] equal:@"DELETE"];
        });
        
        it(@"calls /menu_items/1", ^{
            [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"menu_items/1"]];
        });
        
        it(@"crates menu item object", ^{
            [[expectFutureValue(deletedItem) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"menu_item.json"]];
        });
    });
});

SPEC_END