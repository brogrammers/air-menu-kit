//
//  AMMenuSectionTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 04/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <objc/message.h>
#import "AMMenuItem.h"
#import "AMMenuSection.h"
#import "NSDateFormatter+AirMenuTimestamp.h"
#import "NSNumberFormatter+AirMenuNumberFormat.h"


SPEC_BEGIN(AMMenuSectionTests)

describe(@"AMMenuSection", ^{
    context(@"object", ^{
        __block AMMenuSection *section;
        
        beforeAll(^{
            section = [[AMMenuSection alloc] init];
            [section setValuesForKeysWithDictionary:@{@"identifier" : @1,
                                                      @"name" : @"a name",
                                                      @"details" : @"a description",
                                                      @"menuItems" : @[[[AMMenuItem alloc] init],[[AMMenuItem alloc] init]],
                                                      @"staffKind" : [AMStaffKind new]}];
        });
        
        it(@"subclasses MTLModel", ^{
            [[section should] beKindOfClass:[MTLModel class]];
        });
        
        it(@"conforms to MTLJSONSerializing protocol", ^{
            [[section should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
        
        it(@"has identifier attribute", ^{
            [[section.identifier should] equal:@1];
        });
        
        it(@"has name attribute", ^{
            [[section.name should] equal:@"a name"];
        });
        
        it(@"has details attribute", ^{
            [[section.details should] equal:@"a description"];
        });
        
        it(@"has menu items attribute", ^{
            [[section.menuItems should] equal:@[[[AMMenuItem alloc] init],[[AMMenuItem alloc] init]]];
        });
        
        it(@"has staff kind attribute", ^{
            [[section.staffKind should] equal:[AMStaffKind new]];
        });
        
    });
    
    context(@"class", ^{
        it(@"returns correct mapping from JSONKeyPathsByPropertyKey", ^{
            NSDictionary *mapping = [AMMenuSection JSONKeyPathsByPropertyKey];
            NSDictionary *expectedMapping = @{@"identifier" : @"id",
                                              @"name" : @"name",
                                              @"details" : @"description",
                                              @"menuItems" : @"menu_items",
                                              @"staffKind" : @"staff_kind"};
            [[mapping should] equal:expectedMapping];
        });
        
        it(@"implemenets menuItemsJSONTransformer", ^{
            [[[AMMenuSection class] should] respondToSelector:NSSelectorFromString(@"menuItemsJSONTransformer")];
        });
        
        it(@"returns array of AMMenuItem transformer from menuItemsJSONTransformer", ^{
            NSValueTransformer *transformer = objc_msgSend([AMMenuSection class], NSSelectorFromString(@"menuItemsJSONTransformer"));
            [[transformer shouldNot] beNil];
        });
        
        it(@"responds to staffKindJSONTransformer", ^{
            [[[AMMenuSection class] should] respondToSelector:NSSelectorFromString(@"staffKindJSONTransformer")];
        });
        
        it(@"returns dictionary staff kind transformer from staffKindJSONTransformer", ^{
            NSValueTransformer *transformer = objc_msgSend([AMMenuSection class], NSSelectorFromString(@"staffKindJSONTransformer"));
            [[transformer shouldNot] beNil];
        });
    });
    
    context(@"mapping", ^{
        __block AMMenuSection *section;
        __block NSDictionary *parsedMenuSectionJSON;
        __block NSDictionary *parsedStaffKindJSON;
        __block NSArray *parsedMenuItemsJSON;
        
        beforeAll(^{
            parsedStaffKindJSON = @{@"id" : @1, @"name" : @"aname"};
            
            NSDictionary *parsedMenuItemJSON = @{@"id" : @1,
                                                 @"name" : @"Large fries",
                                                 @"description" : @"Tasty home made fries",
                                                 @"price" : @1.28,
                                                 @"currency" : @"EUR"};
            parsedMenuItemsJSON = @[[parsedMenuItemJSON copy], [parsedMenuItemJSON copy]];
            parsedMenuSectionJSON = @{@"id" : @1,
                                      @"name" : @"Main Courses",
                                      @"description" : @"Tasty & Cheap main courses",
                                      @"menu_items" : parsedMenuItemsJSON,
                                      @"staff_kind" : parsedStaffKindJSON};
            section = [MTLJSONAdapter modelOfClass:[AMMenuSection class] fromJSONDictionary:parsedMenuSectionJSON error:nil];
        });
        
        it(@"maps parsed menu section JSON to AMMenuSection object", ^{
            [[section.identifier should] equal:@1];
            [[section.name should] equal:@"Main Courses"];
            [[section.details should] equal:@"Tasty & Cheap main courses"];
        });
        
        it(@"maps parsed menu item JSON and hooks it up to AMMenuSection object", ^{
            [[section.menuItems should] haveCountOf:2];
            for(AMMenuItem *item in section.menuItems)
            {
                [[[item identifier] should] equal:@1];
                [[[item name] should] equal:@"Large fries"];
                [[[item details] should] equal:@"Tasty home made fries"];
                [[[item price] should] equal:@(1.28)];
                [[[item currency] should] equal:@"EUR"];
            }
        });
        
        it(@"maps parsed staff kind ", ^{
            [[section.staffKind.identifier should] equal:@1];
            [[section.staffKind.name should] equal:@"aname"];
        });
    });
});

SPEC_END