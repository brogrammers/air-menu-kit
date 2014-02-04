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

SPEC_BEGIN(AMMenuItemTests)
describe(@"AMMenuItem", ^{
    context(@"object", ^{
        __block AMMenuItem *menuItem;
        
        beforeAll(^{
            menuItem = [[AMMenuItem alloc] init];
            [menuItem setValuesForKeysWithDictionary:@{@"identifier" : @"1",
                                                       @"createdAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                       @"updatedAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                       @"name" : @"a name",
                                                       @"details" : @"a description",
                                                       @"price" : @(10),
                                                       @"currency" : @"EUR"}];
        });
        
        it(@"has identifier attribute", ^{
            [[menuItem.identifier should] equal:@"1"];
        });
        
        it(@"has createdAt attribute", ^{
            [[menuItem.createdAt should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"has updatedAt attribute", ^{
            [[menuItem.updatedAt should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
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
});

SPEC_END