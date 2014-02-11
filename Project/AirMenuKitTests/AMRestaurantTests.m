//
//  AMMenuSectionTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 04/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <objc/message.h>
#import "AMRestaurant.h"
#import "AMAddress.h"
#import "AMMenu.h"
#import "NSDateFormatter+AirMenuTimestamp.h"


SPEC_BEGIN(AMRestaurantTests)

describe(@"AMRestaurant", ^{
    context(@"object", ^{
        __block AMRestaurant *restaurant;
        beforeAll(^{
            restaurant = [[AMRestaurant alloc] init];
            [restaurant setValuesForKeysWithDictionary:@{@"identifier" : @"1",
                                                         @"name" : @"a name",
                                                         @"remoteOrder" : @YES,
                                                         @"conversionRate" : @0.1,
                                                         @"address" : [AMAddress new]}];
        });
        
        it(@"subclasses MTLModel", ^{
            [[restaurant should] beKindOfClass:[MTLModel class]];
        });
        
        it(@"conforms to MTLJSONSerializing protocol", ^{
            [[restaurant should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
        
        it(@"has identeifier attribute", ^{
            [[restaurant.identifier should] equal:@"1"];
        });
        
        it(@"has name attribute", ^{
            [[restaurant.name should] equal:@"a name"];
        });
        
        it(@"has remote_order attribute", ^{
            [[restaurant.remoteOrder should] equal:@YES];
        });
        
        it(@"has conversion_rate attribute", ^{
            [[restaurant.conversionRate should] equal:@0.1];
        });
        
        it(@"has address attribute", ^{
            [[restaurant.address should] equal:[AMAddress new]];
        });
    });
    
    context(@"class", ^{
        it(@"returns correct mapping from JSONKeyPathsByPropertyKey", ^{
            NSDictionary *mapping = [AMRestaurant JSONKeyPathsByPropertyKey];
            NSDictionary *expectedMapping = @{@"identifier" : @"id",
                                              @"name" : @"name",
                                              @"remoteOrder" : @"remote_order",
                                              @"conversionRate" : @"conversion_rate",
                                              @"address" : @"address"};
            [[mapping should] equal:expectedMapping];
        });
        
        it(@"implements addressJSONTransformer", ^{
            [[[AMRestaurant class] should] respondToSelector:NSSelectorFromString(@"addressJSONTransformer")];
        });
        
        it(@"returns dictionary AMAdress transformer from addressJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMRestaurant class], NSSelectorFromString(@"addressJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
        });
    });
    
    context(@"mapping", ^{
        
    });
});

SPEC_END