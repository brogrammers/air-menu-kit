//
//  AMClientUserTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 10/03/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "TestToolBox.h"
#import "AMClient+User.h"
#import "AMObjectBuilder.h"

SPEC_BEGIN(AMClientUserTests)
describe(@"AMClient+User", ^{
   context(@"on error free flow", ^{
       context(@"on find user", ^{
           __block NSURLSessionDataTask *task;
           __block AMUser *foundUser;
           
           beforeAll(^{
               [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"users/1"]
                                    httpMethod:@"GET"
                            nameOfResponseFile:@"user.json"
                                  responseCode:200];
               
               task = [[AMClient sharedClient] findUserWithIdentifier:@"1" completion:^(AMUser *user, NSError *error) {
                   foundUser = user;
               }];
           });
           
           it(@"uses GET method", ^{
               [[task.originalRequest.HTTPMethod should] equal:@"GET"];
           });
           
           it(@"calls /users/1", ^{
               [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"users/1"]];
           });
           
           it(@"creates user object", ^{
               [[expectFutureValue(foundUser) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"user.json"]];
           });
       });
       
       context(@"on find current user", ^{
           __block NSURLSessionDataTask *task;
           __block AMUser *currentMe;
           __block AMUser *currentMeFromUserDefaults;
           
           beforeAll(^{
               [[NSUserDefaults standardUserDefaults] setObject:@"ABCD" forKey:@"access_token"];
               [[NSUserDefaults standardUserDefaults] synchronize];
               [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"me"]
                                    httpMethod:@"GET"
                            nameOfResponseFile:@"me.json"
                                  responseCode:200];
               
               task = [[AMClient sharedClient] findCurrentUser:^(AMUser *user, NSError *error) {
                   currentMe = user;
                   currentMeFromUserDefaults = [[AMObjectBuilder sharedInstance] objectFromJSON:[[NSUserDefaults standardUserDefaults] objectForKey:@"ABCD"]];
               }];
           });
           
           afterAll(^{
               [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"access_token"];
               [[NSUserDefaults standardUserDefaults] synchronize];
           });
           
           it(@"uses GET method", ^{
               [[task.originalRequest.HTTPMethod should] equal:@"GET"];
           });
           
           it(@"calls /me", ^{
               [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"me"]];
           });
           
           it(@"crates user object", ^{
               [[expectFutureValue(currentMe) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"me.json"]];
           });
           
           it(@"saves current user json to NSUserDefaults under current access token", ^{
               [[expectFutureValue(currentMeFromUserDefaults) shouldEventually] equal:currentMe];
           });
       });
       
       context(@"on find current user from saved data", ^{
           
           __block AMUser *savedUser;
           __block AMUser *currentFoundUser;
           
          beforeAll(^{
              NSDictionary *parsedUserJSON = @{@"id" : @(1),
                                               @"name" : @"Robert Lis",
                                               @"type" : @"Owner",
                                               @"identity" : @{@"username" : @"rob", @"email" : @"rob@gmail.com"},
                                               @"scopes" : @[@"update_groups"]};
              
              [[NSUserDefaults standardUserDefaults] setObject:@"ABCD" forKey:@"access_token"];
              [[NSUserDefaults standardUserDefaults] setObject:@{@"me" : parsedUserJSON} forKey:@"ABCD"];
              [[NSUserDefaults standardUserDefaults] synchronize];
              savedUser = [MTLJSONAdapter modelOfClass:[AMUser class] fromJSONDictionary:parsedUserJSON error:nil];
              
              [[AMClient sharedClient] findCurrentUser:^(AMUser *user, NSError *error) {
                  currentFoundUser = user;
              }];
          });
           
           afterAll(^{
               [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"access_token"];
               [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"ABCD"];
               [[NSUserDefaults standardUserDefaults] synchronize];
           });
           
          it(@"uses saved user object instead of calling the webservice", ^{
              [[expectFutureValue(currentFoundUser) shouldEventually] equal:savedUser];              
          });
       });
       
       context(@"on create user", ^{
           __block NSURLSessionDataTask *task;
           __block AMUser *createdUser;
           
           beforeAll(^{
               [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"users"]
                                    httpMethod:@"POST"
                            nameOfResponseFile:@"user.json"
                                  responseCode:200];
               
               task = [[AMClient sharedClient] createUserWithName:@"Max Hoffmann" username:@"tsov" password:@"pass123" completion:^(AMUser *user, NSError *error) {
                   createdUser = user;
               }];
           });
           
           it(@"uses POST method", ^{
               [[task.originalRequest.HTTPMethod should] equal:@"POST"];
           });
           
           it(@"calls /users", ^{
               [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"users"]];
           });
           
           it(@"creates user object", ^{
               [[expectFutureValue(createdUser) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"user.json"]];

           });
           
           it(@"sends parameters in HTTP body", ^{
               [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"name" : @"Max Hoffmann",
                                                                                  @"username" : @"tsov",
                                                                                  @"password" : @"pass123"}];
           });
       });
       
       context(@"on update current user", ^{
           __block NSURLSessionDataTask *task;
           __block AMUser *updatedMe;
           
           beforeAll(^{
               [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"me"]
                                    httpMethod:@"POST"
                            nameOfResponseFile:@"user.json"
                                  responseCode:200];
               task = [[AMClient sharedClient] updateCurrentUserWithNewName:@"aname" newPassword:@"apass" newPhoneNumber:@"12345" completion:^(AMUser *user, NSError *error) {
                   updatedMe = user;
               }];
           });
           
           it(@"uses POST method", ^{
               [[task.originalRequest.HTTPMethod should] equal:@"POST"];
           });
           
           it(@"calls /me", ^{
               [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"me"]];
           });
           
           it(@"creates user object", ^{
               [[expectFutureValue(updatedMe) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"user.json"]];
           });
           
           it(@"sends parameters in HTTP body", ^{
               [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"name" : @"aname",
                                                                                  @"password" : @"apass",
                                                                                  @"phone" : @"12345"}];
           });
       });
       
       context(@"on find davice of current user", ^{
           __block NSURLSessionDataTask *task;
           __block NSArray *foundDevices;
           beforeAll(^{
               
               [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"me/devices"]
                                    httpMethod:@"GET"
                            nameOfResponseFile:@"devices.json"
                                  responseCode:200];
               
               task = [[AMClient sharedClient] findDevicesOfCurrentUser:^(NSArray *devices, NSError *error) {
                   foundDevices = devices;
               }];
           });
           
           it(@"uses GET method", ^{
               [[task.originalRequest.HTTPMethod should] equal:@"GET"];
           });
           
           it(@"calls /me/devices", ^{
               [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"me/devices"]];
           });
           
           it(@"create array of devices", ^{
               [[expectFutureValue(foundDevices) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"devices.json"]];
           });
       });
       
       context(@"on create device of current user", ^{
           __block NSURLSessionDataTask *task;
           __block AMDevice *createdDevice;
           
           beforeAll(^{
               [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"me/devices"]
                                    httpMethod:@"POST"
                            nameOfResponseFile:@"device.json"
                                  responseCode:200];
               
               task = [[AMClient sharedClient] createDeviceOfCurrentUserWithName:@"adevice"
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
           
           it(@"calls /me/devices", ^{
               [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"me/devices"]];
           });
           
           it(@"creates device object", ^{
               [[expectFutureValue(createdDevice) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"device.json"]];
           });
           
           it(@"sends parameters in HTTP body", ^{
               [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"name" : @"adevice",
                                                                                  @"uuid" : @"auuid",
                                                                                  @"token" : @"atoken",
                                                                                  @"platform" : @"aplatform"}];
           });
       });
       
       context(@"on find notifiations of currrent user", ^{
           __block NSURLSessionDataTask *task;
           __block NSArray *foundNotifications;
           
           beforeAll(^{
               [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"me/notifications"]
                                    httpMethod:@"GET"
                            nameOfResponseFile:@"notifications.json"
                                  responseCode:200];
               
               task = [[AMClient sharedClient] findNotificationsOfCurrentUser:^(NSArray *notifications, NSError *error) {
                   foundNotifications = notifications;
               }];
           });
           
           it(@"uses GET method", ^{
               [[task.originalRequest.HTTPMethod should] equal:@"GET"];
           });
           
           it(@"calls /me/notifications", ^{
               [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"me/notifications"]];
           });
           
           it(@"creates array of notifications object", ^{
               [[expectFutureValue(foundNotifications) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"notifications.json"]];
           });
       });
   });
});
SPEC_END
