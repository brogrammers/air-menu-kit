//
//  AMAddressTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 04/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <objc/message.h>
#import "AMMenuItem.h"
#import "NSDateFormatter+AirMenuTimestamp.h"
#import "NSNumberFormatter+AirMenuNumberFormat.h"

SPEC_BEGIN(AMMenuItemTests)
describe(@"AMMenuItem", ^{
    context(@"object", ^{
        __block AMMenuItem *menuItem;
        
        beforeAll(^{
            menuItem = [[AMMenuItem alloc] init];
            [menuItem setValuesForKeysWithDictionary:@{@"identifier" : @1,
                                                       @"name" : @"a name",
                                                       @"details" : @"a description",
                                                       @"price" : @(10),
                                                       @"currency" : @"EUR"}];
        });
        
        
        it(@"subclasses MTLModel", ^{
            [[menuItem should] beKindOfClass:[MTLModel class]];
        });
        
        it(@"conforms to MTLJSONSerializing protocol", ^{
            [[menuItem should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
        
        it(@"has identifier attribute", ^{
            [[menuItem.identifier should] equal:@1];
        });
        
        it(@"has name attribute", ^{
            [[menuItem.name should] equal:@"a name"];
        });
        
        it(@"has details property", ^{
            [[menuItem.details should] equal:@"a description"];
        });
        
        it(@"has price property", ^{
            [[menuItem.price should] equal:@(10)];
        });
        
        it(@"has currency property", ^{
            [[menuItem.currency should] equal:@"EUR"];
        });
    });
    
    context(@"class", ^{
        it(@"returns correct mapping from JSONKeyPathsByPropertyKey", ^{
            NSDictionary *mapping = [AMMenuItem JSONKeyPathsByPropertyKey];
            NSDictionary *expectedMapping = @{@"identifier" : @"id",
                                              @"name" : @"name",
                                              @"details" : @"description",
                                              @"price" : @"price",
                                              @"currency" : @"currency"};
            [[mapping should] equal:expectedMapping];
        });
    });
    
    context(@"mapping", ^{
        it(@"maps parsed menu item JSON to AMMenuItem object", ^{
            NSDictionary *parsedMenuItemJson = @{@"id" : @1,
                                                 @"name" : @"Large fries",
                                                 @"description" : @"Tasty home made fries",
                                                 @"price" : @1.28,
                                                 @"currency" : @"EUR"};
            AMMenuItem *menuItem = [MTLJSONAdapter modelOfClass:[AMMenuItem class] fromJSONDictionary:parsedMenuItemJson error:nil];
            [[menuItem.identifier should] equal:@1];
            [[menuItem.name should] equal:@"Large fries"];
            [[menuItem.details should] equal:@"Tasty home made fries"];
            [[menuItem.price should] equal:@(1.28)];
            [[menuItem.currency should] equal:@"EUR"];
        });
    });
});

SPEC_END