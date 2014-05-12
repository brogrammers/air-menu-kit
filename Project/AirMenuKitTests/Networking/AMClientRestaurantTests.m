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
#import "NSDateFormatter+AirMenuTimestamp.h"

SPEC_BEGIN(AMClientRestaurantTests)

describe(@"AMClient+Restaurant", ^{
    context(@"with error free flow", ^{
        
        context(@"on finds restaurants", ^{
            __block NSURLSessionDataTask *task;
            __block NSArray *foundRestaurants;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"restaurants/?latitude=99.99000000&longitude=99.99000000&offset=99.98999999999999"]
                                     httpMethod:@"GET"
                             nameOfResponseFile:@"restaurants.json"
                                   responseCode:200];
                task = [[AMClient sharedClient] findRestaurantsAtLatitude:99.99
                                                                longitude:99.99
                                                              withinRange:99.99
                                                               completion:^(NSArray *restaurants, NSError *error) {
                                                                   foundRestaurants = restaurants;
                                                               }];
            });
            
            it(@"uses GET method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"calls /restaurants with query", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"restaurants/?latitude=99.99000000&longitude=99.99000000&offset=99.98999999999999"]];
            });
            
            it(@"creates array of restaurants object", ^{
                [[expectFutureValue(foundRestaurants) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"restaurants.json"]];
            });
        });
        
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
        
        context(@"on update restaurant", ^{
            __block NSURLSessionDataTask *task;
            __block AMRestaurant *updatedRestaurant;
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"restaurants/1"]
                                     httpMethod:@"PUT"
                             nameOfResponseFile:@"restaurant.json"
                                   responseCode:200];
                
                AMRestaurant *restaurant = [[AMRestaurant alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                
                task = [[AMClient sharedClient] updateRestaurant:restaurant
                                                     withNewName:@"aname"
                                                  newDescription:@"desc"
                                               newAddressLineOne:@"line1"
                                               newAddressLineTwo:@"line2"
                                                         newCity:@"city"
                                                       newCounty:@"county"
                                                        newState:@"state"
                                                      newCountry:@"country"
                                                     newLatitude:999.999
                                                    newLongitude:999.999
                                                   newCompletion:^(AMRestaurant *restaurant, NSError *error) {
                                                       updatedRestaurant = restaurant;
                                                   }];
            });
            
            it(@"uses PUT method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"PUT"];
            });
            
            it(@"calls /restaurants/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"restaurants/1"]];
            });
            
            it(@"creates restaurant object", ^{
                [[expectFutureValue(updatedRestaurant) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"restaurant.json"]];
            });
            
            it(@"sends parameters in HTTP body", ^{
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"name" : @"aname",
                                                                                   @"description" : @"desc",
                                                                                   @"address_1" : @"line1",
                                                                                   @"address_2" : @"line2",
                                                                                   @"city" : @"city",
                                                                                   @"county" : @"county",
                                                                                   @"state" : @"state",
                                                                                   @"country" : @"country",
                                                                                   @"latitude" : @"999.999",
                                                                                   @"longitude" : @"999.999"}];
            });
        });
        
        context(@"on delete restaurant", ^{
            __block NSURLSessionDataTask *task;
            __block AMRestaurant *deletedRestaurant;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"restaurants/1"]
                                     httpMethod:@"DELETE"
                             nameOfResponseFile:@"restaurant.json"
                                   responseCode:200];
                AMRestaurant *restaurant = [[AMRestaurant alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] deleteRestaurant:restaurant completion:^(AMRestaurant *restaurant, NSError *error) {
                    deletedRestaurant = restaurant;
                }];
            });
            
            it(@"uses DELETE method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"DELETE"];
            });
            
            it(@"calls /restaurats/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"restaurants/1"]];
            });
            
            it(@"creates restaurant object", ^{
                [[expectFutureValue(deletedRestaurant) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"restaurant.json"]];
            });
        });
        
        /*
         Restaurant > Menus
         */
        
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
        
        /*
         Restaurants > Devices
         */
        
        context(@"on find devices", ^{
            __block NSURLSessionDataTask *task;
            __block NSArray *foundDevices;
            beforeAll(^{
                
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"restaurants/1/devices"]
                                     httpMethod:@"GET"
                             nameOfResponseFile:@"devices.json"
                                   responseCode:200];
                
                AMRestaurant *restaurant = [[AMRestaurant alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] findDevicesOfRestaurant:restaurant completion:^(NSArray *devices, NSError *error) {
                    foundDevices = devices;
                }];
            });
            
            it(@"uses GET method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"calls /restaurants/1/devices", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"restaurants/1/devices"]];
            });
            
            it(@"creates array of devices", ^{
                [[expectFutureValue(foundDevices) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"devices.json"]];
            });
            
        });
        
        context(@"on create device", ^{
            __block NSURLSessionDataTask *task;
            __block AMDevice *createdDevice;
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"restaurants/1/devices"]
                                     httpMethod:@"POST"
                             nameOfResponseFile:@"device.json"
                                   responseCode:200];
                AMRestaurant *restaurant = [[AMRestaurant alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] createDeviceOfRestaurant:restaurant
                                                                withName:@"aname"
                                                                    uuid:@"auuid"
                                                                   token:@"atoken"
                                                                platform:@"aplatform"
                                                              completion:^(AMDevice *device, NSError *error) {
                                                                  createdDevice = device;
                                                              }];
            });
            
            it(@"uses POST method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"POST"];
            });
            
            it(@"calls /restaurants/1/devices", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"restaurants/1/devices"]];
            });
            
            it(@"creates device object", ^{
                [[expectFutureValue(createdDevice) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"device.json"]];
            });
            
            it(@"sends paramters in HTTP body", ^{
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"name" : @"aname", @"uuid" : @"auuid", @"token" : @"atoken", @"platform" : @"aplatform"}];
            });
        });
        
        /*
         Restaurants > Groups
         */
        
        context(@"on find groups", ^{
            __block NSURLSessionDataTask *task;
            __block NSArray *foundGroups;
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"restaurants/1/groups"]
                                     httpMethod:@"GET"
                             nameOfResponseFile:@"groups.json"
                                   responseCode:200];
                
                AMRestaurant *restaurant = [[AMRestaurant alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] findGroupsOfRestaurant:restaurant completion:^(NSArray *groups, NSError *error) {
                    foundGroups = groups;
                }];
            });
            
            it(@"uses GET method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"calls /restaurants/1/groups", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"restaurants/1/groups"]];
            });
            
            it(@"calls creates array of groups object", ^{
                [[expectFutureValue(foundGroups) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"groups.json"]];
            });
        });
        
        
        context(@"on create group", ^{
            __block NSURLSessionDataTask *task;
            __block AMGroup *createdGroup;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"restaurants/1/groups"]
                                     httpMethod:@"POST"
                             nameOfResponseFile:@"group.json"
                                   responseCode:200];
                
                AMRestaurant *restaurant = [[AMRestaurant alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] createGroupOfRestaurant:restaurant
                                                               withName:@"aname"
                                                             completion:^(AMGroup *group, NSError *error) {
                                                                 createdGroup = group;
                                                             }];
            });
            
            it(@"uses POST method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"POST"];
            });
            
            it(@"calls /restaurants/1/groups", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"restaurants/1/groups"]];
            });
            
            it(@"creates group object", ^{
                [[expectFutureValue(createdGroup) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"group.json"]];
            });
            
            it(@"sends parameters in HTTP body", ^{
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"name" : @"aname"}];
            });
        });
        
        /*
         Restaurants > Orders
         */
        
        context(@"on find orders", ^{
            __block NSURLSessionDataTask *task;
            __block NSArray *foundOrders;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"restaurants/1/orders"]
                                     httpMethod:@"GET"
                             nameOfResponseFile:@"orders.json"
                                   responseCode:200];
                
                AMRestaurant *restaurant = [[AMRestaurant alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] findOrdersOfRestaurant:restaurant completion:^(NSArray *orders, NSError *error) {
                    foundOrders = orders;
                }];
            });
            
            it(@"uses GET method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"calls /restaurants/1/orders", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"restaurants/1/orders"]];
            });
            
            it(@"creates array of orders object", ^{
                [[expectFutureValue(foundOrders) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"orders.json"]];
            });
        });
        
        context(@"on create order", ^{
            __block NSURLSessionDataTask *task;
            __block AMOrder *createdOrder;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"restaurants/1/orders"]
                                     httpMethod:@"POST"
                             nameOfResponseFile:@"order.json"
                                   responseCode:200];
                AMRestaurant *restaurant = [[AMRestaurant alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] createOrderOfRestaurant:restaurant
                                                          atTableNumber:@"1"
                                                             completion:^(AMOrder *order, NSError *error) {
                    createdOrder = order;
                }];
            });
            
            it(@"uses POST method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"POST"];
            });
            
            it(@"calls restaurants/1/orders", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"restaurants/1/orders"]];
            });
            
            it(@"crates order object", ^{
                [[expectFutureValue(createdOrder) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"order.json"]];
            });
            
            it(@"sends parameters in HTTP body", ^{
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"table_number" : @"1"}];
            });
        });
        
        /*
         Restaurants > Staff Kinds
         */
        
        context(@"on find staff kinds", ^{
            __block NSURLSessionDataTask *task;
            __block NSArray *foundStaffKinds;
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"restaurants/1/staff_kinds"]
                                     httpMethod:@"GET"
                             nameOfResponseFile:@"staff_kinds.json"
                                   responseCode:200];
                
                AMRestaurant *restaurant = [[AMRestaurant alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] findStaffKindsOfRestaurant:restaurant completion:^(NSArray *staffKinds, NSError *error) {
                    foundStaffKinds = staffKinds;
                }];
            });
            
            it(@"uses GET method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"calls /restaurants/1/staff_kinds", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"restaurants/1/staff_kinds"]];
            });
            
            it(@"creates array of staff kind object", ^{
                [[expectFutureValue(foundStaffKinds) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"staff_kinds.json"]];
            });
        });
        
        
        context(@"on create staff kinds", ^{
            __block NSURLSessionDataTask *task;
            __block AMStaffKind *createdStaffKind;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"restaurants/1/staff_kinds"]
                                     httpMethod:@"POST"
                             nameOfResponseFile:@"staff_kind.json"
                                   responseCode:200];
                AMRestaurant *restaurant = [[AMRestaurant alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] createStaffKindOfRestaurant:restaurant withName:@"aname" acceptOrders:YES acceptsOrderItems:YES scopes:AMOAuthScopeAddMenus completion:^(AMStaffKind *staffKind, NSError *error) {
                    createdStaffKind = staffKind;
                }];
            });
            
            it(@"uses POST method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"POST"];
            });
            
            it(@"calls /restaurants/1/staff_kinds", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"restaurants/1/staff_kinds"]];
            });
            
            it(@"creates staff kind object", ^{
                [[expectFutureValue(createdStaffKind) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"staff_kind.json"]];
            });
            
            it(@"sends paramters in HTTP body", ^{
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"name" : @"aname",
                                                                                   @"accept_orders" : @"true",
                                                                                   @"accept_order_items" : @"true",
                                                                                   @"scopes" : @"add_menus"}];
            });
        });
        
        /*
         Restaurants > Staff Members
         */
        
        context(@"on find staff members", ^{
            __block NSURLSessionDataTask *task;
            __block NSArray *foundStaffMembers;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"restaurants/1/staff_members"]
                                     httpMethod:@"GET"
                             nameOfResponseFile:@"staff_members.json"
                                   responseCode:200];
                
                AMRestaurant *restaurant = [[AMRestaurant alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] findStaffMembersOfRestaurant:restaurant completion:^(NSArray *staffMembers, NSError *error) {
                    foundStaffMembers = staffMembers;
                }];
            });
            
            it(@"uses GET method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"calls restaurants/1/staff_members", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"restaurants/1/staff_members"]];
            });
            
            it(@"it creates array of staff kinds object", ^{
                [[expectFutureValue(foundStaffMembers) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"staff_members.json"]];
            });
        });
        
        context(@"on create staff member", ^{
            __block NSURLSessionDataTask *task;
            __block AMStaffMember *createdStaffMember;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"restaurants/1/staff_members"]
                                     httpMethod:@"POST"
                             nameOfResponseFile:@"staff_member.json"
                                   responseCode:200];
                
                AMRestaurant *restaurant = [[AMRestaurant alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] createStaffMemberOfResstaurant:restaurant withName:@"aname" username:@"ausername" password:@"apass" email:@"anemail" staffKind:@"1" avatar:nil scopes:AMOAuthScopeAddMenus completion:^(AMStaffMember *staffMember, NSError *error) {
                    createdStaffMember = staffMember;
                }];
            });
            
            it(@"uses POST method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"POST"];
            });
            
            it(@"calls restaurant/1/staff_members", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"restaurants/1/staff_members"]];
            });
            
            it(@"creates staff member object", ^{
                [[expectFutureValue(createdStaffMember) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"staff_member.json"]];
            });
            
            it(@"sends parameters in HTTP body", ^{
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"name" : @"aname", @"username" : @"ausername", @"password" : @"apass", @"email" : @"anemail" , @"staff_kind_id" : @"1", @"scopes" : @"add_menus" }];
            });
        });
        
        context(@"on find reviews", ^{
            __block NSURLSessionDataTask *task;
            __block NSArray *foundReviews;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"restaurants/1/reviews"]
                                     httpMethod:@"GET"
                             nameOfResponseFile:@"reviews.json"
                                   responseCode:200];
                AMRestaurant *restaurant = [[AMRestaurant alloc] initWithDictionary:@{@"identifier" : @(1)} error:nil];
                task = [[AMClient sharedClient] findReviewsOfRestaurant:restaurant completion:^(NSArray *reviews, NSError *error) {
                    foundReviews = reviews;
                }];
            });
            
            it(@"uses get method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"calls restaurant/1/reviews", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"restaurants/1/reviews"]];
            });
            
            it(@"creates array of review objects", ^{
                [[expectFutureValue(foundReviews) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"reviews.json"]];
            });
        });
        
        context(@"on create review", ^{
            __block NSURLSessionDataTask *task;
            __block AMReview *createdReview;
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"restaurants/1/reviews"]
                                     httpMethod:@"POST"
                             nameOfResponseFile:@"review.json"
                                   responseCode:200];
                AMRestaurant *restaurant = [[AMRestaurant alloc] initWithDictionary:@{@"identifier" : @(1)} error:nil];
                task = [[AMClient sharedClient] createReviewOfRestaurant:restaurant
                                                             withSubject:@"sub"
                                                                 message:@"msg"
                                                                  rating:2
                                                              completion:^(AMReview *review, NSError *error) {
                                                                  createdReview = review;
                                                              }];
            });
            
            it(@"uses POST method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"POST"];
            });
            
            it(@"calls restaurant/1/reviews", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"restaurants/1/reviews"]];
            });
            
            it(@"creates review member object", ^{
                [[expectFutureValue(createdReview) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"review.json"]];
            });
            
            it(@"sends parameters in HTTP body", ^{
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"subject" : @"sub",
                                                                                   @"message" : @"msg",
                                                                                   @"rating" : @"2"}];
            });

        });
        
        context(@"on find opening hours", ^{
            __block NSURLSessionDataTask *task;
            __block NSArray *foundHours;
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"restaurants/1/opening_hours"]
                                     httpMethod:@"GET"
                             nameOfResponseFile:@"opening_hours.json"
                                   responseCode:200];
                AMRestaurant *restaurant = [[AMRestaurant alloc] initWithDictionary:@{@"identifier" : @(1)} error:nil];
                task = [[AMClient sharedClient] findOpeningHoursOfRestaurant:restaurant completion:^(NSArray *openingHours, NSError *error) {
                    foundHours = openingHours;
                }];
            });
            
            it(@"uses get method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"calls restaurant/1/opening_hour", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"restaurants/1/opening_hours"]];
            });
            
            it(@"creates review member object", ^{
                [[expectFutureValue(foundHours) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"opening_hours.json"]];
            });
        });
        
        context(@"on create opening hour", ^{
            __block NSURLSessionDataTask *task;
            __block AMOpeningHour *createdHour;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"restaurants/1/opening_hours"]
                                     httpMethod:@"POST"
                             nameOfResponseFile:@"opening_hour.json"
                                   responseCode:200];
                AMRestaurant *restaurant = [[AMRestaurant alloc] initWithDictionary:@{@"identifier" : @(1)} error:nil];
                task = [[AMClient sharedClient] createOpeningHourOfRestaurant:restaurant
                                                                          day:@"monday"
                                                                        start:[NSDate dateWithTimeIntervalSince1970:1]
                                                                          end:[NSDate dateWithTimeIntervalSince1970:1] completion:^(AMOpeningHour *openingHour, NSError *error) {
                                                                              createdHour = openingHour;
                                                                          }];
            });
            
            it(@"uses POST method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"POST"];
            });
            
            it(@"calls restaurant/1/opening_hour", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"restaurants/1/opening_hours"]];
            });
            
            it(@"creates opening hour object", ^{
                [[expectFutureValue(createdHour) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"opening_hour.json"]];
            });
            
            it(@"sends parameters in HTTP body", ^{
                NSString *dateString = [[NSDateFormatter sharedAirMenuFormatter] stringFromDate:[NSDate dateWithTimeIntervalSince1970:1]];
                dateString = [dateString stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"day" : @"monday",
                                                                                   @"start" : dateString,
                                                                                   @"end" : dateString}];
            });
        });
    });
});
SPEC_END
    
