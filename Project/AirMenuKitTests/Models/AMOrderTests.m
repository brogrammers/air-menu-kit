//
//  AMOrderTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <objc/message.h>
#import "AMOrder.h"
#import "AMOrderItem.h"

SPEC_BEGIN(AMOrderTests)

describe(@"AMOrder", ^{
    context(@"object", ^{
        __block AMOrder *order;
        beforeAll(^{
            order = [[AMOrder alloc] init];
            [order setValuesForKeysWithDictionary:@{@"identifier" : @1,
                                                    @"state" : @"new",
                                                    @"approvedAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                    @"servedAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                    @"cancelledAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                    @"restaurant" : [AMRestaurant new],
                                                    @"user" : [AMUser new],
                                                    @"orderItems" : @[[AMOrderItem new]]}];
        });
        
        it(@"sublcasses MTLModel", ^{
            [[order should] beKindOfClass:[MTLModel class]];
        });
        
        it(@"conforms to MTLJSONSerializing protocol", ^{
            [[order should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
        
        it(@"has identifier attribute", ^{
            [[order.identifier should] equal:@1];
        });
        
        it(@"has state attribute", ^{
            [[order.state should] equal:@"new"];
        });
        
        it(@"has approved at attribute", ^{
            [[order.approvedAt should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"has servedAt attribute", ^{
            [[order.servedAt should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"ha cancelledAt attribute", ^{
            [[order.cancelledAt should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"has restaurant attribute", ^{
            [[order.restaurant should] equal:[AMRestaurant new]];
        });
        
        it(@"has user attribute", ^{
            [[order.user should] equal:[AMUser new]];
        });
        
        it(@"has order items attribute", ^{
            [[order.orderItems should] equal:@[[AMOrderItem new]]];
        });
    });
    
    context(@"class", ^{
        it(@"returns correct mapping from JSONKeyPathsByPropertyKey", ^{
            NSDictionary *mapping = [AMOrder JSONKeyPathsByPropertyKey];
            NSDictionary *expectedMapping = @{@"identifier" : @"id",
                                              @"state" : @"state",
                                              @"approvedAt" : @"approved_time",
                                              @"servedAt" : @"served_time",
                                              @"cancelledAt" : @"cancelled_time",
                                              @"user" : @"user",
                                              @"restaurant" : @"restaurant",
                                              @"orderItems" : @"order_items"};
            [[mapping should] equal:expectedMapping];
        });
        
        it(@"implements restaurantJSONTransformer", ^{
            [[[AMOrder class] should] respondToSelector:NSSelectorFromString(@"restaurantJSONTransformer")];
        });
        
        it(@"returns dictionary AMRestaurant transformer from restaurantJSONTransformer", ^{
            NSValueTransformer *transformer = objc_msgSend([AMOrder class], NSSelectorFromString(@"restaurantJSONTransformer"));
            [[transformer shouldNot] beNil];
        });
        
        it(@"implements userJSONTransformer", ^{
            [[[AMOrder class] should] respondToSelector:NSSelectorFromString(@"userJSONTransformer")];
        });
        
        it(@"returns dictionary AMUser transformer from userJSONTransformer", ^{
            NSValueTransformer *transformer = objc_msgSend([AMOrder class], NSSelectorFromString(@"userJSONTransformer"));
            [[transformer shouldNot] beNil];
        });
        
        it(@"implements orderItemsJSONTransformer", ^{
            [[[AMOrder class] should] respondToSelector:NSSelectorFromString(@"orderItemsJSONTransformer")];
        });
        
        it(@"returns array AMOrderitem transformer from orderItemsJSONTransformer", ^{
            NSValueTransformer *transformer = objc_msgSend([AMOrder class], NSSelectorFromString(@"orderItemsJSONTransformer"));
            [[transformer shouldNot] beNil];
        });
        
        it(@"implements approvedAtJSONTransformer", ^{
            [[[AMOrder class] should] respondToSelector:NSSelectorFromString(@"approvedAtJSONTransformer")];
        });
        
        it(@"returns NSDate tranfromer from approvedAtJSONTransformer", ^{
            NSValueTransformer *transformer = objc_msgSend([AMOrder class], NSSelectorFromString(@"approvedAtJSONTransformer"));
            [[transformer shouldNot] beNil];
        });
        
        it(@"implements cancelledAtJSONTransformer", ^{
            [[[AMOrder class] should] respondToSelector:NSSelectorFromString(@"cancelledAtJSONTransformer")];
        });
        
        it(@"returns NSDate transformer from cancelledAtJSONTransformer", ^{
            NSValueTransformer *transformer = objc_msgSend([AMOrder class], NSSelectorFromString(@"cancelledAtJSONTransformer"));
            [[transformer shouldNot] beNil];
        });
        
        it(@"implements servedAtJSONTransformer", ^{
            [[[AMOrder class] should] respondToSelector:NSSelectorFromString(@"servedAtJSONTransformer")];
        });
        
        it(@"returns NSDate transformer from servedAtJSONTransformer", ^{
            NSValueTransformer *transformer = objc_msgSend([AMOrder class], NSSelectorFromString(@"servedAtJSONTransformer"));
            [[transformer shouldNot] beNil];
        });
    });
    
    context(@"mapping", ^{
        
    });
});

SPEC_END