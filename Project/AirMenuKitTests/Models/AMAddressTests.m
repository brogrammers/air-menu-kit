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
                                                      @"identifier" : @1,
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
            [[address.identifier should] equal:@1];
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
                                                @"addressLine1" : @"address_1",
                                                @"addressLine2" : @"address_2",
                                                @"city" : @"city",
                                                @"county" : @"county",
                                                @"country": @"country"
                                              };
            [[mapping should] equal:expectedMapping];
        });
    });
    
    context(@"mappings", ^{
       it(@"map parsed address JSON to AMAddress object", ^{
           NSDictionary *parsedAddressJSON = @{@"id" : @1,
                                               @"address_1" : @"line one",
                                               @"address_2" : @"line two",
                                               @"city" : @"Dublin",
                                               @"county": @"Dublin",
                                               @"country" : @"Ireland"};
           AMAddress *address = [MTLJSONAdapter modelOfClass:[AMAddress class] fromJSONDictionary:parsedAddressJSON error:nil];
           [[address.identifier should] equal:@1];
           [[address.addressLine1 should] equal:@"line one"];
           [[address.addressLine2 should] equal:@"line two"];
           [[address.city should] equal:@"Dublin"];
           [[address.county should] equal:@"Dublin"];
           [[address.country should] equal:@"Ireland"];
       });
    });
});

SPEC_END





