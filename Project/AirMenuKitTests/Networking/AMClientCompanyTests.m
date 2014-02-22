//
//  AMClientCompanyTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 19/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <objc/message.h>
#import "AMClient+Company.h"
#import "AMCompany.h"
#import "TestToolBox.h"

SPEC_BEGIN(AMClientCompanyTests)

describe(@"AMClient+Companies", ^{
    
    context(@"with error free flow", ^{
        
        context(@"on create company", ^{
            
            __block NSURLSessionDataTask *task;
            __block AMCompany *newCompany;
            
            beforeAll(^{
                
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"companies"]
                                     httpMethod:@"POST"
                             nameOfResponseFile:@"company.json"
                                   responseCode:200];
                
                task =  [[AMClient sharedClient] createCompanyWithName:@"Some Company"
                                                               website:@"www.nandos.com"
                                                        addressLineOne:@"Apartment 131"
                                                        addresslineTwo:@"35 Mountjoy Square"
                                                                  city:@"Dublin"
                                                                county:@"Dublin"
                                                                 state:@"Ireland"
                                                               country:@"Ireland"
                                                            completion:^(AMCompany *company, NSError *error) {
                                                                newCompany = company;
                                                          }];
            });
            
            it(@"uses POST method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"POST"];
            });
            
            it(@"calls /companies URL", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"companies"]];
            });
            
            it(@"creates a company object", ^{
                AMCompany *company = [TestToolBox objectFromJSONFromFile:@"company.json"];
                [[expectFutureValue(newCompany) shouldEventually] equal:company];
            });
            
            it(@"sends parameters in the HTTP body", ^{
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"name" : @"Some Company",
                                                                                   @"website" : @"www.nandos.com",
                                                                                   @"address_1" : @"Apartment 131",
                                                                                   @"address_2" : @"35 Mountjoy Square",
                                                                                   @"city" : @"Dublin",
                                                                                   @"county" : @"Dublin",
                                                                                   @"state": @"Ireland",
                                                                                   @"country" : @"Ireland"}];
            });
        });
        
        context(@"on find company", ^{
            
            __block NSURLSessionDataTask *task;
            __block AMCompany *foundCompany;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"companies/1"]
                                     httpMethod:@"GET"
                             nameOfResponseFile:@"company.json"
                                   responseCode:200];

                task = [[AMClient sharedClient] findCompanyWithIdentifier:@"1" completion:^(AMCompany *company, NSError *error) {
                    foundCompany = company;
                }];
            });
            
            it(@"uses GET method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"calls /companies/1 URL", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"companies/1"]];
            });
            
            it(@"creates a company object", ^{
                AMCompany *company = [TestToolBox objectFromJSONFromFile:@"company.json"];
                [[expectFutureValue(foundCompany) shouldEventually] equal:company];
            });
        });
        
        context(@"on create restaurant", ^{
            __block NSURLSessionDataTask *task;
            __block AMRestaurant *newRestaurant;
            __block AMCompany *companyOfRestaurant;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"companies/1/restaurants"]
                                     httpMethod:@"POST"
                             nameOfResponseFile:@"restaurant.json"
                                   responseCode:200];
                companyOfRestaurant = [TestToolBox objectFromJSONFromFile:@"company.json"];
                task = [[AMClient sharedClient] createRestaurantOfCompany:companyOfRestaurant
                                                                 withName:@"The Church 2"
                                                                  loyalty:NO
                                                              remoteOrder:NO
                                                           conversionRate:@(0)
                                                           addressLineOne:@"blah"
                                                           addressLineTwo:@"blah"
                                                                     city:@"Dublin"
                                                                   county:@"Dublin"
                                                                    state:@"Dublin"
                                                                  country:@"Ireland"
                                                               completion:^(AMRestaurant *restaurant, NSError *error) {
                                                                   newRestaurant = restaurant;
                                                               }
                        ];
                
            });
            
            it(@"uses POST method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"POST"];
            });
            
            it(@"calls companies/1/restaurants", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"companies/1/restaurants"]];
            });
            
            it(@"creates a restaurant object", ^{
                AMRestaurant *restaurant = [TestToolBox objectFromJSONFromFile:@"restaurant.json"];
                [[expectFutureValue(newRestaurant) shouldEventually] equal:restaurant];
            });
            
            it(@"sends parameters in HTTP body", ^{
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"name" : @"The Church 2",
                                                                                   @"loyalty" : @"0",
                                                                                   @"remote_order" : @"0",
                                                                                   @"conversion_rate" : @"0",
                                                                                   @"address_1" : @"blah",
                                                                                   @"address_2" : @"blah",
                                                                                   @"city" : @"Dublin",
                                                                                   @"county" : @"Dublin",
                                                                                   @"state": @"Dublin",
                                                                                   @"country" : @"Ireland"}];
            });
        });
        
        context(@"on find restaurants", ^{
            __block NSURLSessionDataTask *task;
            __block AMCompany *company;
            __block NSArray *foundRestaurants;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"companies/1/restaurants"]
                                     httpMethod:@"GET"
                             nameOfResponseFile:@"restaurants.json"
                                   responseCode:200];
                company = [TestToolBox objectFromJSONFromFile:@"company.json"];
                task = [[AMClient sharedClient] findRestaurantsOfCompany:company completion:^(NSArray *restaurants, NSError *error) {
                    foundRestaurants = restaurants;
                }];
            });
            
            it(@"uses GET method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"calls companies/1/restaurants", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"companies/1/restaurants"]];
            });
            
            it(@"creates an array of restaurants", ^{
                NSArray *restaurants = [TestToolBox objectFromJSONFromFile:@"restaurants.json"];
                [[expectFutureValue(foundRestaurants) shouldEventually] equal:restaurants];
            });
        });
    });
});

SPEC_END
