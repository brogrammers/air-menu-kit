//
//  AMAddressTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 04/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "AMAddress.h"

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
        
    });
});


SPEC_END