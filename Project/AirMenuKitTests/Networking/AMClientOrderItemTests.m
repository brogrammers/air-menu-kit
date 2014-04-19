//
//  AMClientOrderItemTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 19/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#include <Kiwi/Kiwi.h>
#include "TestToolBox.h"
#import "AMClient+OrderItem.h"

SPEC_BEGIN(AMClientOrderItemTests)

describe(@"AMClient+OrderItem", ^{
    context(@"on error free flow", ^{
        context(@"on find order item", ^{
            __block NSURLSessionDataTask *task;
            __block AMOrderItem *foundOrder;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"order_items/1"]
                                     httpMethod:@"GET"
                             nameOfResponseFile:@"order_item.json"
                                   responseCode:200];
                
                task = [[AMClient sharedClient] findOrderItemWithIdentifier:@"1" completion:^(AMOrderItem *order, NSError *error) {
                    foundOrder = order;
                }];
            });
            
            it(@"uses GET method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"calls /order_items/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"order_items/1"]];
            });
            
            it(@"creates order item object", ^{
                [[expectFutureValue(foundOrder) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"order_item.json"]];
            });
        });
        
        context(@"on update order item", ^{
            __block NSURLSessionDataTask *task;
            __block AMOrderItem *updatedOrder;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"order_items/1"]
                                     httpMethod:@"PUT"
                             nameOfResponseFile:@"order_item.json"
                                   responseCode:200];
                
                AMOrderItem *orderItem = [[AMOrderItem alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] updateOrderItem:orderItem withNewComment:@"acomm" newCount:@1 newState:AMOrderItemStateDeclined completion:^(AMOrderItem *order, NSError *error) {
                    updatedOrder = order;
                }];
            });
            
            it(@"uses PUT method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"PUT"];
            });
            
            it(@"calls /order_items/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"order_items/1"]];
            });
            
            it(@"creates order item object", ^{
                [[expectFutureValue(updatedOrder) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"order_item.json"]];
            });
            
            it(@"sends parameters in HTTP body", ^{
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"comment" : @"acomm", @"count" : @"1", @"state" : @"declined"}];
            });
        });
        
        context(@"on delete order item", ^{
            __block NSURLSessionDataTask *task;
            __block AMOrderItem *deletedOrder;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"order_items/1"]
                                     httpMethod:@"DELETE"
                             nameOfResponseFile:@"order_item.json"
                                   responseCode:200];
                
                AMOrderItem *item = [[AMOrderItem alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] deleteOrderItem:item completion:^(AMOrderItem *orderItem, NSError *error) {
                    deletedOrder = orderItem;
                }];
            });
            
            it(@"uses DELETE method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"DELETE"];
            });
            
            it(@"calls /order_items/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"order_items/1"]];
            });
            
            it(@"creates order item object", ^{
                [[expectFutureValue(deletedOrder) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"order_item.json"]];
            });
        });
    });
});

SPEC_END




