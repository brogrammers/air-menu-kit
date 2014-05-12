//
//  AMClientMenu.m
//  AirMenuKit
//
//  Created by Robert Lis on 22/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "AMClient+Menu.h"
#import "AMMenu.h"
#import "AMMenuSection.h"
#import "TestToolBox.h"

SPEC_BEGIN(AMClientMenuTests)

describe(@"AMClient+Menu", ^{
    context(@"with error free flow", ^{
        context(@"on find menu", ^{
            __block NSURLSessionDataTask *task;
            __block AMMenu *menuFound;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"menus/1"]
                                     httpMethod:@"GET"
                             nameOfResponseFile:@"menu.json"
                                   responseCode:200];
                task = [[AMClient sharedClient] findMenuWithIdentifier:@"1"
                                                            completion:^(AMMenu *menu, NSError *error) {
                                                                menuFound = menu;
                                                            }];
            });
            
            it(@"uses GET method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"calls /menus/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"menus/1"]];
            });
            
            it(@"creates a menu object", ^{
                [[expectFutureValue(menuFound) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"menu.json"]];
            });
        });
        
        context(@"on delete menu", ^{
            __block NSURLSessionDataTask *task;
            __block AMMenu *deletedMenu;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"menus/1"]
                                     httpMethod:@"DELETE"
                             nameOfResponseFile:@"menu.json"
                                   responseCode:200];
                AMMenu *menu = [[AMMenu alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] deleteMenu:menu completion:^(AMMenu *menu, NSError *error) {
                    deletedMenu = menu;
                }];
            });
            
            it(@"uses DELETE method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"DELETE"];
            });
            
            it(@"calls /menus/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"menus/1"]];
            });
            
            it(@"creates menu object", ^{
                [[expectFutureValue(deletedMenu) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"menu.json"]];
            });
        });
        
        
        context(@"on update menu", ^{
            __block NSURLSessionDataTask *task;
            __block AMMenu *updatedMenu;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"menus/1"]
                                     httpMethod:@"PUT"
                             nameOfResponseFile:@"menu.json"
                                   responseCode:200];
                AMMenu *menu = [[AMMenu alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] updateMenu:menu newActive:YES newName:@"aname" completion:^(AMMenu *menu, NSError *error) {
                    updatedMenu = menu;
                }];
            });
            
            it(@"uses PUT method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"PUT"];
            });
            
            it(@"calls /menus/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"menus/1"]];
            });
            
            it(@"creates menu object", ^{
                [[expectFutureValue(updatedMenu) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"menu.json"]];
            });
            
            it(@"sends parameters in HTTP body", ^{
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"active" : @"true",
                                                                                   @"name" : @"aname"}];
            });
        });
        
        context(@"on create menu section", ^{
            
            __block NSURLSessionDataTask *task;
            __block AMMenuSection *newMenuSection;
            __block AMMenu *menu;
            
            beforeAll(^{
                menu = [TestToolBox objectFromJSONFromFile:@"menu.json"];
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"menus/3/menu_sections"]
                                     httpMethod:@"POST"
                             nameOfResponseFile:@"menu_section.json"
                                   responseCode:200];
                task = [[AMClient sharedClient] createSectionOfMenu:menu
                                                           withName:@"another section"
                                                        description:@"blah"
                                                        staffKindId:@"1"
                                                         completion:^(AMMenuSection *section, NSError *error) {
                                                             newMenuSection = section;
                                                         }];
            });
            
            it(@"uses POST method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"POST"];
            });
            
            it(@"calls /menus/3/menu_sections", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"menus/3/menu_sections"]];
            });
            
            it(@"creates a menu section object", ^{
                [[expectFutureValue(newMenuSection) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"menu_section.json"]];
            });
            
            it(@"sends parameters in HTTP body", ^{
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"name" : @"another section",
                                                                                   @"description" : @"blah",
                                                                                   @"staff_kind_id" : @"1"}];
            });
        });
        
        context(@"on find sections of menu", ^{
            __block NSURLSessionDataTask *task;
            __block AMMenu *menu;
            __block NSArray *menuSections;
            
            beforeAll(^{
                
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"menus/3/menu_sections"]
                                     httpMethod:@"GET"
                             nameOfResponseFile:@"menu_sections.json"
                                   responseCode:200];
                
                menu = [TestToolBox objectFromJSONFromFile:@"menu.json"];
                task = [[AMClient sharedClient] findSectionsOfMenu:menu completion:^(NSArray *sections, NSError *error) {
                    menuSections = sections;
                }];
            });
            
            it(@"uses GET method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"calls /menus/3/menu_sections", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"menus/3/menu_sections"]];
            });
            
            it(@"creates array of menu sections object", ^{
                [[expectFutureValue(menuSections) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"menu_sections.json"]];
            });
        });
    });
});

SPEC_END