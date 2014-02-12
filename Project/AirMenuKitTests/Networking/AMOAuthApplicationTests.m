//
//  AMOAuthApplicationTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 11/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <objc/message.h>
#import "AMOAuthApplication.h"

SPEC_BEGIN(AMOAuthApplicationTests)

describe(@"AMOAuthApplication", ^{
    context(@"object", ^{
        
        __block AMOAuthApplication *application;
        
        beforeAll(^{
            application = [AMOAuthApplication new];
            [application setValuesForKeysWithDictionary:@{@"identifier" : @"1",
                                                          @"name" : @"an app",
                                                          @"redirectUri" : [NSURL URLWithString:@"https://localhost"],
                                                          @"clientId" : @"12345",
                                                          @"clientSecret" : @"678910"}];
        });
        
        it(@"subclasses MTLModel", ^{
            [[application should] beKindOfClass:[MTLModel class]];
        });
        
        it(@"conforms to MTLJSONSerializing protocol", ^{
            [[application should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
        
        it(@"has identifier attribute", ^{
            [[application.identifier should] equal:@"1"];
        });
        
        it(@"has name attribute", ^{
            [[application.name should] equal:@"an app"];
        });
        
        it(@"has redirectUri attribute", ^{
            [[application.redirectUri should] equal:[NSURL URLWithString:@"https://localhost"]];
        });
        
        it(@"has clientId attribute", ^{
            [[application.clientId should] equal:@"12345"];
        });
        
        it(@"has clientSecret attribute", ^{
            [[application.clientSecret should] equal:@"678910"];
        });
    });
    
    context(@"class", ^{
        it(@"returns correct mapping from JSONKeyPathsByPropertyKey", ^{
            NSDictionary *mapping = [AMOAuthApplication JSONKeyPathsByPropertyKey];
            NSDictionary *expectedMapping = @{@"identifier" : @"id",
                                              @"name" : @"name",
                                              @"redirectUri": @"redirect_uri",
                                              @"clientId" : @"client_id",
                                              @"clientSecret" : @"client_secret"};
            [[mapping should] equal:expectedMapping];
        });
        
        it(@"responds to redirectUriJSONTransformer", ^{
            [[[AMOAuthApplication class] should] respondToSelector:NSSelectorFromString(@"redirectUriJSONTransformer")];
        });
        
        it(@"returs NSURL value transformer from redirectUriJSONTransformer", ^{
            NSValueTransformer *transformer = objc_msgSend([AMOAuthApplication class], NSSelectorFromString(@"redirectUriJSONTransformer"));
            [[transformer shouldNot] beNil];
        });
        
    });
    
    context(@"mapping", ^{
        __block NSDictionary *parsedApplicationJSON;
        __block AMOAuthApplication *application;
        
        beforeAll(^{
            parsedApplicationJSON = @{@"id" : @1,
                                      @"name" : @"iOS Restaurant",
                                      @"redirect_uri" : @"http://localhost/",
                                      @"client_id" : @"0b919b759ed990fd87b29add9325fa61e7d0582c01014330e888a10bea6777a2",
                                      @"client_secret" : @"edd9b6a6e591f3b7da4bb8c236b844af6391c7b7f75208d19790e3eda6658b8c"};
            application = [MTLJSONAdapter modelOfClass:[AMOAuthApplication class] fromJSONDictionary:parsedApplicationJSON error:nil];
        });
        
        it(@"maps parsed application JSON to AMOAuthApplication object", ^{
            [[application.identifier should] equal:@"1"];
            [[application.name should] equal:@"iOS Restaurant"];
            [[application.redirectUri should] equal:[NSURL URLWithString:@"http://localhost/"]];
            [[application.clientId should] equal:@"0b919b759ed990fd87b29add9325fa61e7d0582c01014330e888a10bea6777a2"];
            [[application.clientSecret should] equal:@"edd9b6a6e591f3b7da4bb8c236b844af6391c7b7f75208d19790e3eda6658b8c"];
        });
    });
});

SPEC_END