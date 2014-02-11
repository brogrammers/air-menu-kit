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
                                                         @"address" : [AMAddress new],
                                                         @"loyality" : @YES}];
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
        
        it(@"has loyality attribute", ^{
            [[restaurant.loyality should] equal:@YES];
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
        
        __block AMRestaurant *restaurant;
        __block NSDictionary *parsedRestaurantJSON;
        __block NSDictionary *parsedAddressJSON;
        
        beforeAll(^{
            parsedAddressJSON = @{@"id" : @"1",
                                  @"created_at" : @"2011-04-05T11:29:14Z",
                                  @"updated_at" : @"2011-04-05T11:29:14Z",
                                  @"address_line_1" : @"line one",
                                  @"address_line_2" : @"line two",
                                  @"city" : @"Dublin",
                                  @"county": @"Dublin",
                                  @"country" : @"Ireland"};
            
            parsedRestaurantJSON = @{@"id": @"1",
                                     @"name" : @"Nandos",
                                     @"loyality" : @NO,
                                     @"remote_order": @NO,
                                     @"conversion_rate": @0.5,
                                     @"address" : parsedAddressJSON};
            restaurant = [MTLJSONAdapter modelOfClass:[AMRestaurant class] fromJSONDictionary:parsedRestaurantJSON error:nil];
        });
        
        it(@"maps parsed menu JSON to AMMenu object", ^{
            [[restaurant.identifier should] equal:@"1"];
            [[restaurant.name should] equal:@"Nandos"];
            [[restaurant.remoteOrder should] equal:@NO];
            [[restaurant.loyality should] equal:@NO];
            [[restaurant.conversionRate should] equal:@0.5];
        });
        
        it(@"maps parsed address JSON hooks it up to AMRestaurant object", ^{
            [[restaurant.address.identifier should] equal:@"1"];
            [[restaurant.address.createdAt should] equal:[[NSDateFormatter sharedAirMenuFormatter] dateFromString:@"2011-04-05T11:29:14Z"]];
            [[restaurant.address.updatedAt should] equal:[[NSDateFormatter sharedAirMenuFormatter] dateFromString:@"2011-04-05T11:29:14Z"]];
            [[restaurant.address.addressLine1 should] equal:@"line one"];
            [[restaurant.address.addressLine2 should] equal:@"line two"];
            [[restaurant.address.city should] equal:@"Dublin"];
            [[restaurant.address.county should] equal:@"Dublin"];
            [[restaurant.address.country should] equal:@"Ireland"];
        });
    });
});

SPEC_END