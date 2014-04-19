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
                                                       @"currency" : @"EUR",
                                                       @"staffKind" : [AMStaffKind new]}];
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
        
        it(@"has staff kind property", ^{
            [[menuItem.staffKind should] equal:[AMStaffKind new]];
        });
    });
    
    context(@"class", ^{
        it(@"returns correct mapping from JSONKeyPathsByPropertyKey", ^{
            NSDictionary *mapping = [AMMenuItem JSONKeyPathsByPropertyKey];
            NSDictionary *expectedMapping = @{@"identifier" : @"id",
                                              @"name" : @"name",
                                              @"details" : @"description",
                                              @"price" : @"price",
                                              @"currency" : @"currency",
                                              @"staffKind" : @"staff_kind"};
            [[mapping should] equal:expectedMapping];
        });
        
        it(@"implement staffKindJSONtransformer", ^{
            [[[AMMenuItem class] should] respondToSelector:NSSelectorFromString(@"staffKindJSONTransformer")];
        });
        
        it(@"returns dictionary staff kind transformer from staffKindJSONTransformer", ^{
            NSValueTransformer *transformer = objc_msgSend([AMMenuItem class], NSSelectorFromString(@"staffKindJSONTransformer"));
            [[transformer shouldNot] beNil];
        });
    });
    
    context(@"mapping", ^{
        __block NSDictionary *parsedMenuItemJson;
        __block NSDictionary *parsedStaffKindJSON;
        __block AMMenuItem *item;
        beforeAll(^{
            parsedStaffKindJSON = @{@"id" : @1, @"name" : @"aname"};
            parsedMenuItemJson = @{@"id" : @1,
                                    @"name" : @"Large fries",
                                    @"description" : @"Tasty home made fries",
                                    @"price" : @1.28,
                                    @"currency" : @"EUR",
                                    @"staff_kind" : parsedStaffKindJSON};
            item = [MTLJSONAdapter modelOfClass:[AMMenuItem class] fromJSONDictionary:parsedMenuItemJson error:nil];
        });
        it(@"maps parsed menu item JSON to AMMenuItem object", ^{
            [[item.identifier should] equal:@1];
            [[item.name should] equal:@"Large fries"];
            [[item.details should] equal:@"Tasty home made fries"];
            [[item.price should] equal:@(1.28)];
            [[item.currency should] equal:@"EUR"];
        });
        
        it(@"maps parsed staff kind ", ^{
            [[item.staffKind.identifier should] equal:@1];
            [[item.staffKind.name should] equal:@"aname"];
        });
    });
});

SPEC_END