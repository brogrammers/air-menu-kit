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
        
    });
});
SPEC_END