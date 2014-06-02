//
//  AMClientTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <objc/message.h>
#import <Kiwi/Kiwi.h>
#import "TestToolBox.h"
#import "AMClient.h"
#import "AMClient+Restaurant.h"

SPEC_BEGIN(AMClientTests)

describe(@"AMMenuClient", ^{
    
    it(@"implements sharedClient as singleton", ^{
        [[[AMClient sharedClient] should] beIdenticalTo:[AMClient sharedClient]];
    });
    
    context(@"on error free flow", ^{
        context(@"on authenticate", ^{
            __block NSURLSessionDataTask *task;
            __block AMOAuthToken *newToken;
            
            beforeAll(^{
                
              [TestToolBox stubRequestWithURL:@"https://edge-api.air-menu.com/api/oauth2/access_tokens"
                                   httpMethod:@"POST"
                           nameOfResponseFile:@"access_token.json"
                                 responseCode:200];
                
              task = [[AMClient sharedClient]
                      authenticateWithClientID:@"1ea6342ac153d74ac305e04f949da93bad3eab7401d9160206e65288bfabee64"
                      clientSecret:@"541b2f36d19a717077195286212aa1e1cea63faea4cfa22963475512704a2684"
                      username:@"rob"
                      password:@"password123"
                      scopes:(AMOAuthScopeOwner|AMOAuthScopeTrusted)
                      completion:^(AMOAuthToken *token, NSError *error) {
                          newToken = token;
                      }];
                
                [[NSUserDefaults standardUserDefaults] setObject:@"ABCD" forKey:@"access_token"];
                [[NSUserDefaults standardUserDefaults] setObject:@{} forKey:@"ABCD"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                      
            });
            
            afterAll(^{
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"access_token"];
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"ABCD"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            });
           
            it(@"uses POST method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"POST"];
            });
            
            
            it(@"calls oauth2/access_tokens", ^{
                [[task.originalRequest.URL.absoluteString should] equal:@"https://edge-api.air-menu.com/api/oauth2/access_tokens"];
            });
            
            it(@"creates access token object", ^{
                [[expectFutureValue(newToken.token) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:[[TestToolBox objectFromJSONFromFile:@"access_token.json"] token]];
            });
            
            it(@"sends parameters in HTTP body", ^{
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"grant_type" : @"password",
                                                                                   @"username" : @"rob",
                                                                                   @"password" : @"password123",
                                                                                   @"client_id" : @"1ea6342ac153d74ac305e04f949da93bad3eab7401d9160206e65288bfabee64",
                                                                                   @"client_secret" : @"541b2f36d19a717077195286212aa1e1cea63faea4cfa22963475512704a2684",
                                                                                   @"scope" : @"owner trusted"}];
            });
            
            it(@"sets token as Authorization HTTP header ", ^{
                NSString *token = [[TestToolBox objectFromJSONFromFile:@"access_token.json"] token];
                NSString *headerExpected = [@"Bearer " stringByAppendingString:token];
                [[expectFutureValue([AMClient sharedClient].requestSerializer.HTTPRequestHeaders[@"Authorization"]) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:headerExpected];
            });
            
            it(@"saves current token to NSUerDefaults and removes value under for old token from user defaults", ^{
                [[[[NSUserDefaults standardUserDefaults] objectForKey:@"ABCD"] should] beNil];
                [[expectFutureValue([[NSUserDefaults standardUserDefaults] stringForKey:@"access_token"]) shouldEventuallyBeforeTimingOutAfter(10.0)] equal:[[TestToolBox objectFromJSONFromFile:@"access_token.json"] token]];
            });
       });
        
        context(@"when restoring session", ^{
            
            context(@"when token present", ^{
                
                beforeAll(^{
                    [[NSUserDefaults standardUserDefaults] setObject:@"ABCD" forKey:@"access_token"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                });
                
                afterAll(^{
                    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"access_token"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                });
                
                it(@"returns YES from isLoggedIn", ^{
                    BOOL isLoggedIn = [[AMClient sharedClient] isLoggedIn];
                    [[theValue(isLoggedIn) should] equal:theValue(YES)];
                });
                
                it(@"sets access token on the client", ^{
                    NSString *headerExpected = [@"Bearer " stringByAppendingString:@"ABCD"];
                    [[expectFutureValue([AMClient sharedClient].requestSerializer.HTTPRequestHeaders[@"Authorization"]) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:headerExpected];
                });
            });
        });
        
        context(@"on refresh token", ^{
            __block NSURLSessionDataTask *task;
            __block AMOAuthToken *newToken;

            beforeAll(^{
                [TestToolBox stubRequestWithURL:@"https://edge-api.air-menu.com/api/oauth2/access_tokens"
                                     httpMethod:@"POST"
                             nameOfResponseFile:@"access_token.json"
                                   responseCode:200];
                
                
                [[NSUserDefaults standardUserDefaults] setObject:@"ABCD" forKey:@"access_token"];
                [[NSUserDefaults standardUserDefaults] setObject:@"ABCDE" forKey:@"refresh_token"];
                [[NSUserDefaults standardUserDefaults] setObject:@[@"old user"] forKey:@"ABCD"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                task = [[AMClient sharedClient] refreshWithClientID:@"id"
                                                             secret:@"secret"
                                                         completion:^(AMOAuthToken *token, NSError *error) {
                                                             newToken = token;
                                                         }];
            });
            
            afterAll(^{
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"access_token"];
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"ABCD"];
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"refresh_token"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            });
            
            it(@"ressignes user object to new access token", ^{
                [[expectFutureValue([[NSUserDefaults standardUserDefaults] objectForKey:newToken.token]) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:@[@"old user"]];
            });
            
            it(@"sends parameters in HTTP body", ^{
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"client_id" : @"id",
                                                                                   @"client_secret" : @"secret",
                                                                                   @"refresh_token" : @"ABCDE",
                                                                                   @"grant_type" : @"refresh"}];
            });
            
            it(@"uses POST method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"POST"];
            });
            
            
            it(@"calls oauth2/access_tokens", ^{
                [[task.originalRequest.URL.absoluteString should] equal:@"https://edge-api.air-menu.com/api/oauth2/access_tokens"];
            });
            it(@"creates access token object", ^{
                [[expectFutureValue(newToken.token) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:[[TestToolBox objectFromJSONFromFile:@"access_token.json"] token]];
            });
            
            it(@"sets token as Authorization HTTP header ", ^{
                NSString *token = [[TestToolBox objectFromJSONFromFile:@"access_token.json"] token];
                NSString *headerExpected = [@"Bearer " stringByAppendingString:token];
                [[expectFutureValue([AMClient sharedClient].requestSerializer.HTTPRequestHeaders[@"Authorization"]) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:headerExpected];
            });
            
            it(@"saves current token to NSUerDefaults and removes value under for old token from user defaults", ^{
                [[[[NSUserDefaults standardUserDefaults] objectForKey:@"ABCD"] should] beNil];
                [[expectFutureValue([[NSUserDefaults standardUserDefaults] stringForKey:@"access_token"]) shouldEventuallyBeforeTimingOutAfter(10.0)] equal:[[TestToolBox objectFromJSONFromFile:@"access_token.json"] token]];
            });
        });
    });
});

SPEC_END