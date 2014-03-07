#import <Kiwi/Kiwi.h>
#import <objc/message.h>
#import "AMOAuthToken.h"

SPEC_BEGIN(AMOAuthTokenTests)

describe(@"AMOAuthToken", ^{
    context(@"object", ^{
        
        __block AMOAuthToken *accessToken;
        
        beforeAll(^{
            accessToken = [AMOAuthToken new];
            [accessToken setValuesForKeysWithDictionary:@{@"token" : @"12345",
                                                          @"refreshToken" : @"678910",
                                                          @"type" : @"bearer",
                                                          @"expiresAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                          @"scopes" : @[@"user", @"admin", @"basic", @"create_company"]}];
        });
        
        it(@"subclasses MTLModel", ^{
            [[accessToken should] beKindOfClass:[MTLModel class]];
        });
        
        it(@"conforms to MTLJSONSerializing protocol", ^{
            [[accessToken should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
        
        it(@"has token attribute", ^{
            [[accessToken.token should] equal:@"12345"];
        });
        
        it(@"has refreshToken attribute", ^{
            [[accessToken.refreshToken should] equal:@"678910"];
        });
        
        it(@"has type attribute", ^{
            [[accessToken.type should] equal:@"bearer"];
        });
        
        it(@"has expiresAt attribute", ^{
            [[accessToken.expiresAt should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"has scopes attribute", ^{
            [[accessToken.scopes should] equal:@[@"user", @"admin", @"basic", @"create_company"]];
        });
    });
    
    context(@"class", ^{
        it(@"returns correct mapping from JSONKeyPathsByPropertyKey", ^{
            NSDictionary *mapping = [AMOAuthToken JSONKeyPathsByPropertyKey];
            NSDictionary *expectedMapping = @{@"token" : @"token",
                                              @"refreshToken" : @"refresh_token",
                                              @"type" : @"token_type",
                                              @"expiresAt" : @"expires_in_seconds",
                                              @"scopes": @"scopes"};
            [[mapping should] equal:expectedMapping];
        });
        
        it(@"implements expiresAtJSONTransformer", ^{
            [[[AMOAuthToken class] should] respondToSelector:NSSelectorFromString(@"expiresAtJSONTransformer")];
        });
        
        it(@"returns NSDate value transformer from expiresAtJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMOAuthToken class], NSSelectorFromString(@"expiresAtJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
        });
    });
    
    context(@"mapping", ^{
        __block NSDictionary *parsedTokenJSON;
        __block AMOAuthToken *accessToken;
        
        beforeAll(^{
            parsedTokenJSON = @{@"token" : @"6f5066bdf7cc53d088cf0cc967b6cf4b69205887437590aa8448bc0a1d8aff17",
                                @"refresh_token" : @"0eeff0f2615d026cacd5637158cbd6c31edf63bc4abbec284982a28800f639ab",
                                @"token_type" : @"bearer",
                                @"expires_in_seconds" : @(172800),
                                @"scopes" : @[@"basic", @"user", @"admin", @"create_company"]};
            accessToken = [MTLJSONAdapter modelOfClass:[AMOAuthToken class] fromJSONDictionary:parsedTokenJSON error:nil];
        });
        
        it(@"maps parsed address JSON to AMAddress object", ^{
            [[accessToken.token should] equal:@"6f5066bdf7cc53d088cf0cc967b6cf4b69205887437590aa8448bc0a1d8aff17"];
            [[accessToken.refreshToken should] equal:@"0eeff0f2615d026cacd5637158cbd6c31edf63bc4abbec284982a28800f639ab"];
            [[accessToken.type should] equal:@"bearer"];
            [[accessToken.scopes should] equal:@[@"basic", @"user", @"admin", @"create_company"]];
        });
    });
});

SPEC_END