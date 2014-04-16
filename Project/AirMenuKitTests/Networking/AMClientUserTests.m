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
       
       context(@"on find davice of current user", ^{
           
           
       });
       
       context(@"on create device of current user", ^{
           
       });
       
       context(@"on find notifiations of currrent user", ^{
           
       });
   });
});
SPEC_END
