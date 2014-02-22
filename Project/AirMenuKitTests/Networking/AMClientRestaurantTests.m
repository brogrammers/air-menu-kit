//
//  AMClientRestaurantTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 20/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import "AMClient+Restaurant.h"
#import "AMRestaurant.h"
#import "TestToolBox.h"

SPEC_BEGIN(AMClientRestaurantTests)

describe(@"AMClient+Restaurant", ^{
    context(@"with error free flow", ^{
        context(@"on find restaurant", ^{
            __block NSURLSessionDataTask *task;
            __block AMRestaurant *foundRestaurant;
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"restaurants/1"]
                                     httpMethod:@"GET"
                             nameOfResponseFile:@"restaurant.json"
                                   responseCode:200];
                task = [[AMClient sharedClient] findRestaurantWithIdentifier:@"1" completion:^(AMRestaurant *restaurant, NSError *error) {
                    foundRestaurant = restaurant;
                }];
            });
                        
            it(@"uses GET method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"calls /restaurants/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"restaurants/1"]];
            });
            
            it(@"creates restaurant object", ^{
                [[expectFutureValue(foundRestaurant) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"restaurant.json"]];
            });
        });
        
        context(@"on find menus", ^{
            __block NSURLSessionDataTask *task;
            __block AMRestaurant *restaurant;
            __block NSArray *foundMenus;
            
            [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"restaurants/2/menus"]
                                 httpMethod:@"GET"
                         nameOfResponseFile:@"menus.json"
                               responseCode:200];
            restaurant = [TestToolBox objectFromJSONFromFile:@"restaurant.json"];
            task = [[AMClient sharedClient] findMenusOfRestaurant:restaurant completion:^(NSArray *menus, NSError *error) {
                foundMenus = menus;
            }];
            
            it(@"uses GET method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"calls /restaurants/2/menus", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"restaurants/2/menus"]];
            });
            
            it(@"creates menus objects", ^{
                [[expectFutureValue(foundMenus) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"menus.json"]];
            });
        });
        
        context(@"on create menu", ^{
            __block NSURLSessionDataTask *task;
            __block AMRestaurant *restaurant;
            __block AMMenu *menuCreated;
            
            beforeAll(^{
                restaurant = [TestToolBox objectFromJSONFromFile:@"restaurant.json"];
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"restaurants/2/menus"]
                                     httpMethod:@"POST"
                             nameOfResponseFile:@"menu.json"
                                   responseCode:200];
                task = [[AMClient sharedClient] createMenuOfRestaurant:restaurant
                                                              withName:@"monday treat"
                                                                active:YES
                                                            completion:^(AMMenu *menu, NSError *error) {
                                                                menuCreated = menu;
                                                            }];
            });
            
            it(@"uses POST method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"POST"];
            });
            
            it(@"calls /restaurants/2/menus", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"restaurants/2/menus"]];
            });
            
            it(@"creates a menu object", ^{
                [[expectFutureValue(menuCreated) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"menu.json"]];
            });
            
            it(@"sends parameters in HTTP body", ^{
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"name" : @"monday treat",
                                                                                   @"active" : @"1"}];
            });
        });
    });
});
SPEC_END
    
