//
//  AMClientDeviceTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/05/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#include <Kiwi/Kiwi.h>
#include "TestToolBox.h"
#include "AMClient+Device.h"

SPEC_BEGIN(ClientDeviceTests)
describe(@"AMClient+Device", ^{
   context(@"on error free flow", ^{
       context(@"on find device", ^{
           __block AMDevice *foundDevice;
           __block NSURLSessionDataTask *task;
           
           beforeAll(^{
               [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"devices/1"]
                                    httpMethod:@"GET"
                            nameOfResponseFile:@"device.json"
                                  responseCode:200];
               task = [[AMClient sharedClient] findDeviceWithIdentifier:@"1" completion:^(AMDevice *device, NSError *error) {
                   foundDevice = device;
               }];
           });
           
           it(@"uses GET method", ^{
               [[task.originalRequest.HTTPMethod should] equal:@"GET"];
           });
           
           it(@"calls /devices/1", ^{
               [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"devices/1"]];
           });
           
           it(@"creates device object", ^{
               [[expectFutureValue(foundDevice) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:[TestToolBox objectFromJSONFromFile:@"device.json"]];
           });
       });
       
       context(@"on update device", ^{
           __block AMDevice *updatedDevice;
           __block NSURLSessionDataTask *task;
           
           beforeAll(^{
               [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"devices/1"]
                                    httpMethod:@"PUT"
                            nameOfResponseFile:@"device.json"
                                  responseCode:200];
               
               AMDevice *device = [[AMDevice alloc] initWithDictionary:@{@"identifier" : @(1)} error:nil];
               task = [[AMClient sharedClient] updateDevice:device
                                                withNewName:@"aname"
                                                    newUUID:@"auuid"
                                                   newToken:@"atoken"
                                                newPlatform:@"aplatform"
                                                 completion:^(AMDevice *device, NSError *error) {
                                                     updatedDevice = device;
                                                 }];
           });
           
           
           it(@"uses PUT metod", ^{
               [[task.originalRequest.HTTPMethod should] equal:@"PUT"];
           });
           
           it(@"calls /devices/1", ^{
               [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"devices/1"]];
           });
           
           it(@"creates device object", ^{
                [[expectFutureValue(updatedDevice) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:[TestToolBox objectFromJSONFromFile:@"device.json"]];
           });
           
           it(@"sends parameters in HTTP body", ^{
               [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"name" : @"aname",
                                                                                  @"uuid" : @"auuid",
                                                                                  @"token" : @"atoken",
                                                                                  @"platform" : @"aplatform"}];
           });
       });
       
       context(@"on delete device", ^{
           __block AMDevice *deletedDevice;
           __block NSURLSessionDataTask *task;
           
           beforeAll(^{
               [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"devices/1"]
                                    httpMethod:@"DELETE"
                            nameOfResponseFile:@"device.json"
                                  responseCode:200];
               
               AMDevice *device = [[AMDevice alloc] initWithDictionary:@{@"identifier" : @(1)} error:nil];
               task = [[AMClient sharedClient] deleteDevice:device completion:^(AMDevice *device, NSError *error) {
                   deletedDevice = device;
               }];
           });
           
           it(@"uses DELETE metod", ^{
               [[task.originalRequest.HTTPMethod should] equal:@"DELETE"];
           });
           
           it(@"calls /devics/1", ^{
               [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"devices/1"]];
           });
           
           it(@"creates device object", ^{
                [[expectFutureValue(deletedDevice) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:[TestToolBox objectFromJSONFromFile:@"device.json"]];
           });
       });
   });
});
SPEC_END