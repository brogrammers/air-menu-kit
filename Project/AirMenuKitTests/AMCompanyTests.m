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
#import "NSDateFormatter+AirMenuTimestamp.h"

SPEC_BEGIN(AMCompanyTests)

describe(@"AMCompany", ^{
    context(@"object", ^{
        
        __block AMCompany *company;
        __block AMAddress *address;
        
        beforeAll(^{
            company = [[AMCompany alloc] init];
            address = [[AMAddress alloc] init];
            [company setValuesForKeysWithDictionary:@{@"identifier" : @"1",
                                                      @"createdAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                      @"updatedAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                      @"name" : @"a name",
                                                      @"address" : address,
                                                      @"website" : [NSURL URLWithString:@"https://www.example.com"]}];
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
                                              @"createdAt" : @"created_at",
                                              @"updatedAt" : @"updated_at",
                                              @"name" : @"name",
                                              @"address" : @"address",
                                              @"website" : @"website"};
            [[mapping should] equal:expectedMapping];
        });
        
        it(@"implements addressJSONTransformer", ^{
            [[AMCompany should] respondToSelector:NSSelectorFromString(@"addressJSONTransformer")];
        });
        
        it(@"returns dictionary AMAddress transformer from addressJSONTransfomer", ^{
            NSValueTransformer *valueTransfomer = objc_msgSend([AMCompany class], NSSelectorFromString(@"addressJSONTransformer"));
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
        
        it(@"implements websiteJSONTransformer", ^{
            [[AMCompany should] respondToSelector:NSSelectorFromString(@"websiteJSONTransformer")];
        });
        
        it(@"returns NSURL value transformer from websiteJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMCompany class], NSSelectorFromString(@"websiteJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
            // TODO (Robert Lis): Write test that ensures url can be transformed with this transformer
        });
    });
    
    context(@"mappings", ^{
        
        __block AMCompany *company;
        __block NSDictionary *parsedAddressJSON;
        __block NSDictionary *parsedCompanyJSON;
        beforeAll(^{
            parsedAddressJSON = @{@"id" : @"1",
                                  @"created_at" : @"2011-04-05T11:29:14Z",
                                  @"updated_at" : @"2011-04-05T11:29:14Z",
                                  @"address_line_1" : @"line one",
                                  @"address_line_2" : @"line two",
                                  @"city" : @"Dublin",
                                  @"county": @"Dublin",
                                  @"country" : @"Ireland"};
            parsedCompanyJSON = @{@"id" : @"1",
                                  @"created_at": @"2011-04-05T11:29:14Z",
                                  @"updated_at": @"2011-04-05T11:29:14Z",
                                  @"name": @"mcdonald's",
                                  @"address" : parsedAddressJSON,
                                  @"website" : @"www.mcdonalds.com"};
            company = [MTLJSONAdapter modelOfClass:[AMCompany class] fromJSONDictionary:parsedCompanyJSON error:nil];
        });
        
        it(@"maps parsed company JSON to AMCompany object", ^{
            [[company.identifier should] equal:@"1"];
            [[company.createdAt should] equal:[[NSDateFormatter sharedAirMenuFormatter] dateFromString:@"2011-04-05T11:29:14Z"]];
            [[company.updatedAt should] equal:[[NSDateFormatter sharedAirMenuFormatter] dateFromString:@"2011-04-05T11:29:14Z"]];
            [[company.name should] equal:@"mcdonald's"];
            [[company.website should] equal:[NSURL URLWithString:@"www.mcdonalds.com"]];
        });
        
        it(@"maps parsed address JSON and hooks it up to AMCompany object", ^{
            [[company.address.identifier should] equal:@"1"];
            [[company.address.createdAt should] equal:[[NSDateFormatter sharedAirMenuFormatter] dateFromString:@"2011-04-05T11:29:14Z"]];
            [[company.address.updatedAt should] equal:[[NSDateFormatter sharedAirMenuFormatter] dateFromString:@"2011-04-05T11:29:14Z"]];
            [[company.address.addressLine1 should] equal:@"line one"];
            [[company.address.addressLine2 should] equal:@"line two"];
            [[company.address.city should] equal:@"Dublin"];
            [[company.address.county should] equal:@"Dublin"];
            [[company.address.country should] equal:@"Ireland"];
        });
    });
});

SPEC_END
