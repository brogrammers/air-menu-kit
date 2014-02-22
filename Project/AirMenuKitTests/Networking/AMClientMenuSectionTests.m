//
//  AMClientMenuSectionTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 22/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "AMClient+MenuSection.h"
#import "TestToolBox.h"

SPEC_BEGIN(AMClientMenuSectionTests)

describe(@"AMClient+MenuSection", ^{
   context(@"on error free flow", ^{
       context(@"on find menu section", ^{
           __block NSURLSessionDataTask *task;
           __block AMMenuSection *sectionFound;
           beforeAll(^{
               [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"menu_sections/1"]
                                    httpMethod:@"GET"
                            nameOfResponseFile:@"menu_section.json"
                                  responseCode:200];
               task = [[AMClient sharedClient] findMenuSectionWithIdentifier:@"1" completion:^(AMMenuSection *section, NSError *error) {
                   sectionFound = section;
               }];
           });
           
           it(@"uses GET method", ^{
               [[task.originalRequest.HTTPMethod should] equal:@"GET"];
           });
           
           it(@"calls /menu_sections/1", ^{
               [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"menu_sections/1"]];
           });
           
           it(@"creates a menu section object", ^{
               [[expectFutureValue(sectionFound) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"menu_section.json"]];
           });
       });
       
       context(@"on create menu item", ^{
           __block NSURLSessionDataTask *task;
           __block AMMenuSection *section;
           __block AMMenuItem *newItem;
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"menu_sections/1/menu_items"]
                                     httpMethod:@"POST"
                             nameOfResponseFile:@"menu_item.json"
                                   responseCode:200];
                section = [TestToolBox objectFromJSONFromFile:@"menu_section.json"];
                task = [[AMClient sharedClient] createItemOfSection:section
                                                           withName:@"name"
                                                        description:@"some item"
                                                              price:@1.0
                                                           currency:@"EUR"
                                                         completion:^(AMMenuItem *item, NSError *error) {
                                                             newItem = item;
                                                         }];
            });
           
            it(@"uses POST method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"POST"];
            });
           
            it(@"calls /menu_sections/1/menu_items", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"menu_sections/1/menu_items"]];
            });
           
            it(@"creates a menu item object", ^{
                [[expectFutureValue(newItem) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"menu_item.json"]];
            });
           
            it(@"sends parameters in HTTP body", ^{
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"name" : @"name",
                                                                                   @"description" : @"some item",
                                                                                   @"price" : @"1",
                                                                                   @"currency" : @"EUR"}];
            
        
            });
       });
       
       context(@"on find items of section", ^{
           __block NSURLSessionDataTask *task;
           __block AMMenuSection *section;
           __block NSArray *menuItems;
           beforeAll(^{
               [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"menu_sections/1/menu_items"]
                                    httpMethod:@"GET"
                            nameOfResponseFile:@"menu_items.json"
                                  responseCode:200];
               section = [TestToolBox objectFromJSONFromFile:@"menu_section.json"];
               task = [[AMClient sharedClient] findItemsOfSection:section completion:^(NSArray *items, NSError *error) {
                   menuItems = items;
               }];
           });
           
           it(@"uses GET method", ^{
               [[task.originalRequest.HTTPMethod should] equal:@"GET"];
           });
           
           it(@"calls /menu_sections/1/menu_items", ^{
               [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"menu_sections/1/menu_items"]];
           });
           
           it(@"creates arry of menu items object", ^{
               [[expectFutureValue(menuItems) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"menu_items.json"]];
           });
       });
   });
});

SPEC_END