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
            [restaurant setValuesForKeysWithDictionary:@{@"identifier" : @1,
                                                         @"name" : @"a name",
                                                         @"remoteOrder" : @YES,
                                                         @"conversionRate" : @0.1,
                                                         @"address" : [AMAddress new],
                                                         @"loyalty" : @YES,
                                                         @"menu" : [AMMenu new],
                                                         @"location" : [CLRegion new]}];
        });
        
        it(@"subclasses MTLModel", ^{
            [[restaurant should] beKindOfClass:[MTLModel class]];
        });
        
        it(@"conforms to MTLJSONSerializing protocol", ^{
            [[restaurant should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
        
        it(@"has identifier attribute", ^{
            [[restaurant.identifier should] equal:@1];
        });
        
        it(@"has name attribute", ^{
            [[restaurant.name should] equal:@"a name"];
        });
        
        it(@"has loyality attribute", ^{
            [[restaurant.loyalty should] equal:@YES];
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
        
        it(@"has menu attribute", ^{
            [[restaurant.menu should] equal:[AMMenu new]];
        });
        
        it(@"has location attribute", ^{
            [[restaurant.location should] equal:[CLRegion new]];
        });
        
    });
    
    context(@"class", ^{
        it(@"returns correct mapping from JSONKeyPathsByPropertyKey", ^{
            NSDictionary *mapping = [AMRestaurant JSONKeyPathsByPropertyKey];
            NSDictionary *expectedMapping = @{@"identifier" : @"id",
                                              @"name" : @"name",
                                              @"loyalty" : @"loyalty",
                                              @"remoteOrder" : @"remote_order",
                                              @"conversionRate" : @"conversion_rate",
                                              @"address" : @"address",
                                              @"menu" : @"menu",
                                              @"location" : @"location"};
            [[mapping should] equal:expectedMapping];
        });
        
        it(@"implements addressJSONTransformer", ^{
            [[[AMRestaurant class] should] respondToSelector:NSSelectorFromString(@"addressJSONTransformer")];
        });
        
        it(@"returns dictionary AMAdress transformer from addressJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMRestaurant class], NSSelectorFromString(@"addressJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
        });
        
        it(@"implements menuJSONTransformer", ^{
            [[[AMRestaurant class] should] respondToSelector:NSSelectorFromString(@"menuJSONTransformer")];
        });
        
        it(@"returns dicionary AMMenu transformer from menuJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMRestaurant class], NSSelectorFromString(@"menuJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
        });
        
        it(@"implmenets locationJSONTransformer", ^{
            [[[AMRestaurant class] should] respondToSelector:NSSelectorFromString(@"locationJSONTransformer")];
        });
        
        it(@"returns dicionary CLRegion transformer from locationJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMRestaurant class], NSSelectorFromString(@"locationJSONTransformer"));
            NSDictionary *location = @{@"latitude" : @999.999,
                                       @"longitude" : @999.999};
            [[[valueTransformer reverseTransformedValue:[valueTransformer transformedValue:location]] should] equal:location];
        });
    });
    
    context(@"mapping", ^{
        
        __block AMRestaurant *restaurant;
        __block NSDictionary *parsedRestaurantJSON;
        __block NSDictionary *parsedAddressJSON;
        __block NSDictionary *parsedMenuJSON;
        
        beforeAll(^{
            parsedAddressJSON = @{@"id" : @1,
                                  @"address_1" : @"line one",
                                  @"address_2" : @"line two",
                                  @"city" : @"Dublin",
                                  @"county": @"Dublin",
                                  @"country" : @"Ireland"};
            
            parsedMenuJSON = @{@"id" : @1,
                               @"name" : @"Main Menu"};
            
            parsedRestaurantJSON = @{@"id": @1,
                                     @"name" : @"Nandos",
                                     @"loyalty" : @NO,
                                     @"remote_order": @NO,
                                     @"conversion_rate": @0.5,
                                     @"address" : parsedAddressJSON,
                                     @"menu" : parsedMenuJSON};
            
            restaurant = [MTLJSONAdapter modelOfClass:[AMRestaurant class] fromJSONDictionary:parsedRestaurantJSON error:nil];
        });
        
        it(@"maps parsed menu JSON to AMMenu object", ^{
            [[restaurant.identifier should] equal:@1];
            [[restaurant.name should] equal:@"Nandos"];
            [[restaurant.remoteOrder should] equal:@NO];
            [[restaurant.loyalty should] equal:@NO];
            [[restaurant.conversionRate should] equal:@0.5];
        });
        
        it(@"maps parsed address JSON and hooks it up to AMRestaurant object", ^{
            [[restaurant.address.identifier should] equal:@1];
            [[restaurant.address.addressLine1 should] equal:@"line one"];
            [[restaurant.address.addressLine2 should] equal:@"line two"];
            [[restaurant.address.city should] equal:@"Dublin"];
            [[restaurant.address.county should] equal:@"Dublin"];
            [[restaurant.address.country should] equal:@"Ireland"];
        });
        
        it(@"maps parsed menu JSON and hooks it up to the AMMenu object", ^{
            [[restaurant.menu.identifier should] equal:@1];
            [[restaurant.menu.name should] equal:@"Main Menu"];
        });
    });
});

SPEC_END