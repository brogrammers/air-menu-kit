//
//  AMOrderItemTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <Mantle/Mantle.h>
#import "AMOrderItem.h"
#import <objc/objc-runtime.h>
#import "NSDateFormatter+AirMenuTimestamp.h"

SPEC_BEGIN(AMOrderItemTests)
describe(@"AMOrderItem", ^{
    context(@"object", ^{
        __block AMOrderItem *item;
        beforeAll(^{
            item = [[AMOrderItem alloc] init];
            [item setValuesForKeysWithDictionary:@{@"identifier" : @1,
                                                   @"comment" : @"a comment",
                                                   @"count" : @1,
                                                   @"state" : @"new",
                                                   @"approvedAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                   @"declinedAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                   @"prepareTimeStart" : [NSDate dateWithTimeIntervalSince1970:1],
                                                   @"prepareTimeEnd" : [NSDate dateWithTimeIntervalSince1970:1],
                                                   @"servedAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                   @"order" : [AMOrder new],
                                                   @"menuItem" : [AMMenuItem new]}];
        });
        
        it(@"subclasses MTLModel", ^{
            [[item should] beKindOfClass:[MTLModel class]];
        });
        
        it(@"conforms to MTLJSONSerializing attribute", ^{
            [[item should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
        
        it(@"has identifier attribute", ^{
            [[item.identifier should] equal:@1];
        });
        
        it(@"has comment attribute", ^{
            [[item.comment should] equal:@"a comment"];
        });
        
        it(@"has count attribute", ^{
            [[item.count should] equal:@1];
        });
        
        it(@"has state attribute", ^{
            [[item.state should] equal:@"new"];
        });
        
        it(@"has approvedAt attribute", ^{
            [[item.approvedAt should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"has declinedAt attribute", ^{
            [[item.declinedAt should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"has prepareTimeStart attribute", ^{
            [[item.prepareTimeStart should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"has prepareTimeEnd attribute", ^{
            [[item.prepareTimeEnd should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"has servedAt attribute", ^{
            [[item.servedAt should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"has order attribute", ^{
            [[item.order should] equal:[AMOrder new]];
        });
        
        it(@"has menu item attribute", ^{
            [[item.menuItem should] equal:[AMMenuItem new]];
        });
    });
    
    context(@"class", ^{
        it(@"returns corret mapping from JSONKeyPathsByPropertyKey", ^{
            NSDictionary *mapping = [[AMOrderItem class] JSONKeyPathsByPropertyKey];
            NSDictionary *expectedMapping = @{@"identifier" : @"id",
                                              @"comment" : @"comment",
                                              @"count" : @"count",
                                              @"state" : @"state",
                                              @"approvedAt" : @"approved_time",
                                              @"declinedAt" : @"declined_time",
                                              @"prepareTimeStart" : @"start_prepare_time",
                                              @"prepareTimeEnd" : @"end_prepare_time",
                                              @"servedAt" : @"served_time",
                                              @"order" : @"order",
                                              @"menuItem" : @"menu_item"};
            [[mapping should] equal:expectedMapping];
        });
        
        it(@"implements approvedAtJSONTransformer", ^{
            [[[AMOrderItem class] should] respondToSelector:NSSelectorFromString(@"approvedAtJSONTransformer")];
        });
        
        it(@"returns NSDate transfomer from approvedAtJSONTransformer", ^{
            NSValueTransformer *transformer = objc_msgSend([AMOrderItem class], NSSelectorFromString(@"approvedAtJSONTransformer"));
            [[transformer shouldNot] beNil];
        });
        
        it(@"implements declinedAtJSONTransformer", ^{
            [[[AMOrderItem class] should] respondToSelector:NSSelectorFromString(@"declinedAtJSONTransformer")];
        });
        
        it(@"returns NSDate transformer from declinedAtJSONTransformer", ^{
            NSValueTransformer *transformer = objc_msgSend([AMOrderItem class], NSSelectorFromString(@"declinedAtJSONTransformer"));
            [[transformer shouldNot] beNil];
        });
        
        it(@"implements prepareTimeStartJSONTransformer", ^{
            [[[AMOrderItem class] should] respondToSelector:NSSelectorFromString(@"prepareTimeStartJSONTransformer")];
        });
        
        it(@"returns NSDate transformer from prepareTimeStartJSONTransformer", ^{
            NSValueTransformer *transformer = objc_msgSend([AMOrderItem class], NSSelectorFromString(@"prepareTimeStartJSONTransformer"));
            [[transformer shouldNot] beNil];
        });
        
        it(@"implements prepareTimeEndJSONTransformer", ^{
            [[[AMOrderItem class] should] respondToSelector:NSSelectorFromString(@"prepareTimeEndJSONTransformer")];
        });
        
        it(@"returns NSDate transformer from prepareTimeEndJSONTransformer", ^{
            NSValueTransformer *transformer = objc_msgSend([AMOrderItem class], NSSelectorFromString(@"prepareTimeEndJSONTransformer"));
            [[transformer shouldNot] beNil];
        });
        
        it(@"implements servedAtJSONTransformer", ^{
            [[[AMOrderItem class] should] respondToSelector:NSSelectorFromString(@"servedAtJSONTransformer")];
        });
        
        it(@"returns NSDate transformer from servedAtJSONTransformer", ^{
            NSValueTransformer *transformer = objc_msgSend([AMOrderItem class] , NSSelectorFromString(@"servedAtJSONTransformer"));
            [[transformer shouldNot] beNil];
        });
        
        it(@"implements orderJSONTransformer", ^{
            [[[AMOrderItem class] should] respondToSelector:NSSelectorFromString(@"orderJSONTransformer")];
        });
        
        it(@"returns dicionary AMOrder tansformer from orderJSONTransformer ", ^{
            NSValueTransformer *transformer = objc_msgSend([AMOrderItem class], NSSelectorFromString(@"orderJSONTransformer"));
            [[transformer shouldNot] beNil];
        });
        
        it(@"implements menuItemJSONTransformer", ^{
            [[[AMOrderItem class] should] respondToSelector:NSSelectorFromString(@"menuItemJSONTransformer")];
        });
        
        it(@"returns dicionary AMMenuItem transformer from menuItemJSONTransformer", ^{
            NSValueTransformer *transformer = objc_msgSend([AMOrderItem class], NSSelectorFromString(@"menuItemJSONTransformer"));
            [[transformer shouldNot] beNil];
        });
    });

    
    context(@"mapping", ^{
        __block AMOrderItem *orderItem;
        __block NSDictionary *parsedOrderItemJSON;
        __block NSDictionary *parsedOrderJSON;
        __block NSDictionary *parsedMenuItemJSON;
        beforeAll(^{
            parsedOrderJSON = @{@"id": @1,
                                @"state": @"new",
                                @"approved_time": @"2014-04-12T23:24:53Z",
                                @"served_time": @"2014-04-12T23:24:53Z",
                                @"cancelled_time": @"2014-04-12T23:24:53Z"};
            
            parsedMenuItemJSON = @{@"id": @1,
                                   @"name": @"Beef Burger",
                                   @"description": @"Beef Burger with a small side salad.",
                                   @"price": @12.9,
                                   @"currency": @"EUR"};
            
            parsedOrderItemJSON = @{@"id": @1,
                                    @"comment": @"Comment",
                                    @"count": @1,
                                    @"state": @"new",
                                    @"approved_time": @"2014-04-12T23:24:53Z",
                                    @"declined_time": @"2014-04-12T23:24:53Z",
                                    @"start_prepare_time" : @"2014-04-12T23:24:53Z",
                                    @"end_prepare_time" : @"2014-04-12T23:24:53Z",
                                    @"served_time" : @"2014-04-12T23:24:53Z",
                                    @"order" : parsedOrderJSON,
                                    @"menu_item" : parsedMenuItemJSON};
            
            orderItem = [MTLJSONAdapter modelOfClass:[AMOrderItem class] fromJSONDictionary:parsedOrderItemJSON error:nil];
        });
        
        it(@"maps parsed order item json to AMOrderItem object", ^{
            [[orderItem.identifier should] equal:@1];
            [[orderItem.comment should] equal:@"Comment"];
            [[orderItem.count should] equal:@1];
            [[orderItem.state should] equal:@"new"];
            [[orderItem.approvedAt should] equal:[[NSDateFormatter sharedAirMenuFormatter] dateFromString:@"2014-04-12T23:24:53Z"]];
            [[orderItem.declinedAt should] equal:[[NSDateFormatter sharedAirMenuFormatter] dateFromString:@"2014-04-12T23:24:53Z"]];
            [[orderItem.prepareTimeStart should] equal:[[NSDateFormatter sharedAirMenuFormatter] dateFromString:@"2014-04-12T23:24:53Z"]];
            [[orderItem.prepareTimeEnd should] equal:[[NSDateFormatter sharedAirMenuFormatter] dateFromString:@"2014-04-12T23:24:53Z"]];
            [[orderItem.servedAt should] equal:[[NSDateFormatter sharedAirMenuFormatter] dateFromString:@"2014-04-12T23:24:53Z"]];
        });
        
        it(@"maps parsed menu item JSON and hooks it up to AMOrderItem object ", ^{
            [[orderItem.menuItem.identifier should] equal:@1];
            [[orderItem.menuItem.name should] equal:@"Beef Burger"];
            [[orderItem.menuItem.details should] equal:@"Beef Burger with a small side salad."];
            [[orderItem.menuItem.price should] equal:@12.9];
            [[orderItem.menuItem.currency should] equal:@"EUR"];
        });
        
        it(@"maps parsed order JSON and hooks it up to AMOrderItem object", ^{
            [[orderItem.order.identifier should] equal:@1];
            [[orderItem.order.state should] equal:@"new"];
            [[orderItem.order.approvedAt should] equal:[[NSDateFormatter sharedAirMenuFormatter] dateFromString:@"2014-04-12T23:24:53Z"]];
            [[orderItem.order.servedAt should] equal:[[NSDateFormatter sharedAirMenuFormatter] dateFromString:@"2014-04-12T23:24:53Z"]];
            [[orderItem.order.cancelledAt should] equal:[[NSDateFormatter sharedAirMenuFormatter] dateFromString:@"2014-04-12T23:24:53Z"]];
        });
    });
});
SPEC_END





