//
//  AMClientOpeningHourTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/05/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#include <Kiwi/Kiwi.h>
#include "TestToolBox.h"
#include "AMClient+OpeningHour.h"
#include "NSDateFormatter+AirMenuTimestamp.h"

SPEC_BEGIN(AMClientOpeningHourTests)
describe(@"AMClient+OpeningHour", ^{
    describe(@"on error free flow", ^{
        context(@"on find opening hour", ^{
            __block NSURLSessionDataTask *task;
            __block AMOpeningHour *foundHour;
            beforeAll(^{
               [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"opening_hours/1"]
                                    httpMethod:@"GET"
                            nameOfResponseFile:@"opening_hour.json"
                                  responseCode:200];
                task = [[AMClient sharedClient] findOpeningHourWithIdentifier:@"1" completion:^(AMOpeningHour *openingHour, NSError *error) {
                    foundHour = openingHour;
                }];
            });
            
            it(@"uses GET method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"calls opening_hours/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"opening_hours/1"]];
            });
            
            it(@"creates opeing hour object", ^{
                [[expectFutureValue(foundHour) shouldEventuallyBeforeTimingOutAfter(60.0)] equal:[TestToolBox objectFromJSONFromFile:@"opening_hour.json"]];
            });
        });
        
        context(@"on update opening hour", ^{
            __block NSURLSessionDataTask *task;
            __block AMOpeningHour *updatedHour;
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"opening_hours/1"]
                                     httpMethod:@"PUT"
                             nameOfResponseFile:@"opening_hour.json"
                                   responseCode:200];
                AMOpeningHour *hour = [[AMOpeningHour alloc] initWithDictionary:@{@"identifier" : @(1)} error:nil];
                task = [[AMClient sharedClient] updateOpeningHour:hour
                                                           newDay:@"tue"
                                                         newStart:[NSDate dateWithTimeIntervalSince1970:1]
                                                           newEnd:[NSDate dateWithTimeIntervalSince1970:1]
                                                       completion:^(AMOpeningHour *openingHour, NSError *error) {
                                                           updatedHour = openingHour;
                                                       }];
            });
            
            it(@"uses PUT method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"PUT"];
            });
            
            it(@"calls opening_hours/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"opening_hours/1"]];
            });
            
            it(@"creates opeing hour object", ^{
                [[expectFutureValue(updatedHour) shouldEventuallyBeforeTimingOutAfter(60.0)] equal:[TestToolBox objectFromJSONFromFile:@"opening_hour.json"]];
            });
            
            it(@"sends parameters in HTTP body", ^{
                NSString *dateString = [[NSDateFormatter sharedAirMenuFormatter] stringFromDate:[NSDate dateWithTimeIntervalSince1970:1]];
                dateString = [dateString stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{ @"day" : @"tue",
                                                                                    @"start" : dateString,
                                                                                    @"end" :  dateString}];
            });
        });
        
        context(@"on delete opening hour", ^{
            __block NSURLSessionDataTask *task;
            __block AMOpeningHour *deletedHour;
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"opening_hours/1"]
                                     httpMethod:@"DELETE"
                             nameOfResponseFile:@"opening_hour.json"
                                   responseCode:200];
                
                AMOpeningHour *hour = [[AMOpeningHour alloc] initWithDictionary:@{@"identifier" : @(1)} error:nil];
                task = [[AMClient sharedClient] deleteOpeningHours:hour completion:^(AMOpeningHour *openingHour, NSError *error) {
                    deletedHour = openingHour;
                }];
            });
            
            it(@"uses DELETE method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"DELETE"];
            });
            
            it(@"calls opening_hours/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"opening_hours/1"]];
            });
            
            it(@"creates opeing hour object", ^{
                [[expectFutureValue(deletedHour) shouldEventuallyBeforeTimingOutAfter(60.0)] equal:[TestToolBox objectFromJSONFromFile:@"opening_hour.json"]];
            });
        });
    });
});
SPEC_END
