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
                
                [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                    return [request.URL.absoluteString isEqualToString:@"https://stage-api.air-menu.com/api/v1/companies"] &&
                           [request.HTTPMethod isEqualToString:@"POST"];
                }
                                    withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                                        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"company.json", nil)
                                                                                statusCode:200
                                                                                   headers:@{@"Content-Type": @"text/json"}];
                                    }
                ];
                
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
                [[task.originalRequest.URL.absoluteString should] equal:@"https://stage-api.air-menu.com/api/v1/companies"];
            });
            
            it(@"creates a company object", ^{
                NSData *companyJSON = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"company.json", nil)];
                NSDictionary *parsedCompanyJSON = [NSJSONSerialization JSONObjectWithData:companyJSON
                                                                                  options:0
                                                                                    error:nil];
                AMCompany *company = [MTLJSONAdapter modelOfClass:[AMCompany class] fromJSONDictionary:parsedCompanyJSON[@"company"] error:nil];
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
                [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                                return [request.URL.absoluteString isEqualToString:@"https://stage-api.air-menu.com/api/v1/companies/1"] &&
                                [request.HTTPMethod isEqualToString:@"GET"];
                             }
                                    withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                                        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"companies-post-successful.json", nil)
                                                                                statusCode:200
                                                                                   headers:@{@"Content-Type": @"text/json"}];
                                    }
                ];
                
                task = [[AMClient sharedClient] findCompanyWithIdentifier:@"1" completion:^(AMCompany *company, NSError *error) {
                    foundCompany = company;
                }];
            });
            
            it(@"uses GET method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"calls /companies/1 URL", ^{
                [[task.originalRequest.URL.absoluteString should] equal:@"https://stage-api.air-menu.com/api/v1/companies/1"];
            });
            
            it(@"creates a company object", ^{
                NSData *companyJSON = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"company.json", nil)];
                NSDictionary *parsedCompanyJSON = [NSJSONSerialization JSONObjectWithData:companyJSON
                                                                                  options:0
                                                                                    error:nil];
                AMCompany *company = [MTLJSONAdapter modelOfClass:[AMCompany class] fromJSONDictionary:parsedCompanyJSON[@"company"] error:nil];
                [[expectFutureValue(foundCompany) shouldEventually] equal:company];
            });
            
        });
        
        context(@"on create restaurant", ^{
            __block NSURLSessionDataTask *task;
            __block AMRestaurant *newRestaurant;
            __block AMCompany *companyOfRestaurant;
            
            beforeAll(^{
                [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                    return [request.URL.absoluteString isEqualToString:@"https://stage-api.air-menu.com/api/v1/companies/1/restaurants"] &&
                    [request.HTTPMethod isEqualToString:@"POST"];
                } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                    return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"restaurant.json", nil)
                                                           statusCode:200                                                              headers:@{@"Content-Type": @"text/json"}];
                }];
                
                NSData *companyJSON = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"company.json", nil)];
                NSDictionary *parsedCompanyJSON = [NSJSONSerialization JSONObjectWithData:companyJSON
                                                                                  options:0
                                                                                    error:nil];
                companyOfRestaurant = [MTLJSONAdapter modelOfClass:[AMCompany class] fromJSONDictionary:parsedCompanyJSON[@"company"] error:nil];

                
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
                [[task.originalRequest.URL.absoluteString should] equal:@"https://stage-api.air-menu.com/api/v1/companies/1/restaurants"];
            });
            
            it(@"creates a restaurant object", ^{
                NSData *restaurantJSON = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"restaurant.json", nil)];
                NSDictionary *parsedRestaurantJSON = [NSJSONSerialization JSONObjectWithData:restaurantJSON
                                                                                  options:0
                                                                                    error:nil];
                AMRestaurant *restaurant = [MTLJSONAdapter modelOfClass:[AMRestaurant class] fromJSONDictionary:parsedRestaurantJSON[@"restaurant"] error:nil];
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
                [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                    return [request.URL.absoluteString isEqualToString:@"https://stage-api.air-menu.com/api/v1/companies/1/restaurants"] &&
                    [request.HTTPMethod isEqualToString:@"GET"];
                } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                    return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"restaurants.json", nil)
                                                            statusCode:200
                                                               headers:@{@"Content-Type": @"text/json"}];
                }];
                
                NSData *companyJSON = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"company.json", nil)];
                NSDictionary *parsedCompanyJSON = [NSJSONSerialization JSONObjectWithData:companyJSON
                                                                                  options:0
                                                                                    error:nil];
                company = [MTLJSONAdapter modelOfClass:[AMCompany class] fromJSONDictionary:parsedCompanyJSON[@"company"] error:nil];
                task = [[AMClient sharedClient] findRestaurantsOfCompany:company completion:^(NSArray *restaurants, NSError *error) {
                    foundRestaurants = restaurants;
                }];
            });
            
            it(@"uses GET method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"calls companies/1/restaurants", ^{
                [[task.originalRequest.URL.absoluteString should] equal:@"https://stage-api.air-menu.com/api/v1/companies/1/restaurants"];
            });
            
            it(@"creates an array of restaurants", ^{
                NSData *restaurantsJSON = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"restaurants.json", nil)];
                NSDictionary *parsedRestaurantsJSON = [NSJSONSerialization JSONObjectWithData:restaurantsJSON options:0 error:nil];
                NSValueTransformer *transformer = [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[AMRestaurant class]];
                NSArray *restaurants = [transformer transformedValue:parsedRestaurantsJSON[@"restaurants"]];
                [[expectFutureValue(foundRestaurants) shouldEventually] equal:restaurants];
            });
        });
    });
    
});

SPEC_END
