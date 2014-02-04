//
//  AMAddressTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 04/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <objc/message.h>
#import "AMAddress.h"
#import "NSDateFormatter+AirMenuTimestamp.h"

SPEC_BEGIN(AMAddressTests)

describe(@"AMAddress", ^{
    
    context(@"object", ^{
        
        __block AMAddress *address;
        
        beforeAll(^{
            address = [[AMAddress alloc] init];
            [address setValuesForKeysWithDictionary:@{
                                                      @"identifier" : @"1",
                                                      @"createdAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                      @"updatedAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                      @"addressLine1" : @"line one",
                                                      @"addressLine2" : @"line two",
                                                      @"city" : @"a city",
                                                      @"county"  : @"a county",
                                                      @"country" : @"a country"
                                                    }];
        });
        
        it(@"sublclasses MTLModel", ^{
            [[address should] beKindOfClass:[MTLModel class]];
        });
        
        it(@"conforms to MTLJSONSerializing protocol", ^{
            [[address should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
        
        it(@"has identifier attribute", ^{
            [[address.identifier should] equal:@"1"];
        });
        
        it(@"has created at attribute", ^{
            [[address.createdAt should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"has updated at attribute", ^{
            [[address.updatedAt should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"has address line 1 attribute", ^{
            [[address.addressLine1 should] equal:@"line one"];
        });
        
        it(@"has address line 2 attribute", ^{
            [[address.addressLine2 should] equal:@"line two"];
        });
        
        it(@"has city attribute", ^{
            [[address.city should] equal:@"a city"];
        });
        
        it(@"has county attribute", ^{
            [[address.county should] equal:@"a county"];
        });
        
        it(@"has country attribute", ^{
            [[address.country should] equal:@"a country"];
        });
    
    });
    
    context(@"class", ^{
        it(@"returns correct mapping from +JSONKeyPathsByPropertyKey",^{
            NSDictionary *mapping = [AMAddress JSONKeyPathsByPropertyKey];
            NSDictionary *expectedMapping = @{
                                                @"identifier" : @"id",
                                                @"createdAt" : @"created_at",
                                                @"updatedAt" : @"updated_at",
                                                @"addressLine1" : @"address_line_1",
                                                @"addressLine2" : @"address_line_2",
                                                @"city" : @"city",
                                                @"county" : @"county",
                                                @"country": @"country"
                                              };
            [[mapping should] equal:expectedMapping];
        });
        
        it(@"implements createdAtJSONTransformer", ^{
            [[[AMAddress class] should] respondToSelector:NSSelectorFromString(@"createdAtJSONTransformer")];
        });
        
        it(@"returns NSDate transformer from createdAtJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMAddress class], NSSelectorFromString(@"createdAtJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
            // TODO (Robert Lis): Write test that ensures date can be transformed with this transformer
        });
        
        it(@"implements updatedAtJSONTransformer", ^{
            [[[AMAddress class] should] respondToSelector:NSSelectorFromString(@"updatedAtJSONTransformer")];
        });
        
        it(@"returns NSDate transformer from updatedAtJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMAddress class], NSSelectorFromString(@"updatedAtJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
            // TODO (Robert Lis): Write test that ensures date can be transformed with this transformer
        });
    });
    
    context(@"mappings", ^{
       it(@"map parsed address JSON to AMAddress object", ^{
           NSDictionary *parsedAddressJSON = @{@"id" : @"1",
                                               @"created_at" : @"2011-04-05T11:29:14Z",
                                               @"updated_at" : @"2011-04-05T11:29:14Z",
                                               @"address_line_1" : @"line one",
                                               @"address_line_2" : @"line two",
                                               @"city" : @"Dublin",
                                               @"county": @"Dublin",
                                               @"country" : @"Ireland"};
           AMAddress *address = [MTLJSONAdapter modelOfClass:[AMAddress class] fromJSONDictionary:parsedAddressJSON error:nil];
           [[address.identifier should] equal:@"1"];
           [[address.createdAt should] equal:[[NSDateFormatter sharedAirMenuFormatter] dateFromString:@"2011-04-05T11:29:14Z"]];
           [[address.updatedAt should] equal:[[NSDateFormatter sharedAirMenuFormatter] dateFromString:@"2011-04-05T11:29:14Z"]];
           [[address.addressLine1 should] equal:@"line one"];
           [[address.addressLine2 should] equal:@"line two"];
           [[address.city should] equal:@"Dublin"];
           [[address.county should] equal:@"Dublin"];
           [[address.country should] equal:@"Ireland"];
       });
    });
});

SPEC_END





