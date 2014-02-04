//
//  AMCompanyTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 03/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <objc/message.h>
#import <Kiwi/Kiwi.h>
#import "AMCompany.h"

SPEC_BEGIN(AMCompanyTests)

describe(@"AMCompany", ^{
    context(@"object", ^{
        
        __block AMCompany *company;
        __block AMAddress *address;
        
        beforeAll(^{
            company = [[AMCompany alloc] init];
            address = [[AMAddress alloc] init];            
            [company setValuesForKeysWithDictionary:@{
                                                        @"identifier" : @"1",
                                                        @"createdAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                        @"updatedAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                        @"name" : @"a name",
                                                        @"address" : address,
                                                        @"website" : [NSURL URLWithString:@"https://www.example.com"]
                                                      }];
        });
        
        it(@"subclasses MTLModel", ^{
            [[company should] beKindOfClass:[MTLModel class]];
        });
        
        it(@"conforms to MTLJSONSerializing protocol", ^{
            [[company should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
        
        it(@"has identifier attribute", ^{
            [[company.identifier should] equal:@"1"];
        });
        
        it(@"has created at attribute", ^{
            [[company.createdAt should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });

        it(@"has updated at attribute", ^{
            [[company.updatedAt should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"has name attribute", ^{
            [[company.name should] equal:@"a name"];
        });

        it(@"has address attribute", ^{
            [[company.address should] equal:address];
        });

        it(@"has website", ^{
            [[company.website should] equal:[NSURL URLWithString:@"https://www.example.com"]];
        });
    });
    
    context(@"class", ^{
        it(@"returns correct mapping from +JSONKeyPathsByPropertyKey",^{
            NSDictionary *mapping = [AMCompany JSONKeyPathsByPropertyKey];
            NSDictionary *expectedMapping = @{@"identifier" : @"id",
                                              @"createdAt" : @"createdAt",
                                              @"updatedAt" : @"updatedAt",
                                              @"name" : @"name",
                                              @"address" : @"address",
                                              @"website" : @"website"};
            [[mapping should] equal:expectedMapping];
        });
        
        it(@"implements addressJSONTransformer", ^{
            [[AMCompany should] respondToSelector:NSSelectorFromString(@"addressJSONTransfomer")];
        });
        
        it(@"returns AMAddress transformer from addressJSONTransfomer", ^{
            NSValueTransformer *valueTransfomer = objc_msgSend([AMCompany class], NSSelectorFromString(@"addressJSONTransfomer"));
            [[valueTransfomer shouldNot] beNil];
            // TODO (Robert Lis): Write test that ensures address can be transformed with this transformer
        });
        
        it(@"implements createdAtJSONTransformer", ^{
            [[AMCompany should] respondToSelector:NSSelectorFromString(@"createdAtJSONTransformer")];
        });
        
        it(@"returns NSDate value transformer from createdAtJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMCompany class], NSSelectorFromString(@"createdAtJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
            // TODO (Robert Lis): Write test that ensures date can be transformed with this transformer
        });
        
        it(@"implements updatedAtJSONTransformer", ^{
            [[AMCompany should] respondToSelector:NSSelectorFromString(@"updatedAtJSONTransformer")];
        });
        
        it(@"returns NSDate value transformer from updatedAtJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMCompany class], NSSelectorFromString(@"updatedAtJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
            // TODO (Robert Lis): Write test that ensures date can be transformed with this transformer
        });
    });
});

SPEC_END
