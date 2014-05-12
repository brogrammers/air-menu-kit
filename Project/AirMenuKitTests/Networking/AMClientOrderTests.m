//
//  AMClientOrderTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 19/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#include <Kiwi/Kiwi.h>
#include "TestToolBox.h"
#import "AMClient+Order.h"

SPEC_BEGIN(AMClientOrderTests)

describe(@"AMClient+Order", ^{
    context(@"on error free flow", ^{
        context(@"on find order", ^{
            __block NSURLSessionDataTask *task;
            __block AMOrder *foundOrder;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"orders/1"]
                                     httpMethod:@"GET"
                             nameOfResponseFile:@"order.json"
                                   responseCode:200];
                
                task = [[AMClient sharedClient] findOrderWithIdentifier:@"1" completion:^(AMOrder *order, NSError *error) {
                    foundOrder = order;
                }];
            });
            
            it(@"uses GET method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"calls /orders/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"orders/1"]];
            });
            
            it(@"creates order object", ^{
                [[expectFutureValue(foundOrder) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"order.json"]];
            });
        });
        
        context(@"on update order", ^{
            __block NSURLSessionDataTask *task;
            __block AMOrder *updatedOrder;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"orders/1"]
                                     httpMethod:@"PUT"
                             nameOfResponseFile:@"order.json"
                                   responseCode:200];
                AMOrder *order = [[AMOrder alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] updateOrder:order newState:AMOrderStateOpen completion:^(AMOrder *order, NSError *error) {
                    updatedOrder = order;
                }];
            });
            
            it(@"uses PUT method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"PUT"];
            });
            
            it(@"calls /orders/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"orders/1"]];
            });
            
            it(@"creates order object", ^{
                [[expectFutureValue(updatedOrder) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"order.json"]];
            });
            
            it(@"sends paramters in HTTP body", ^{
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"state" : @"open"}];
            });
        });
        
        context(@"on delete order", ^{
            __block NSURLSessionDataTask *task;
            __block AMOrder *deletedOrder;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"orders/1"]
                                     httpMethod:@"DELETE"
                             nameOfResponseFile:@"order.json"
                                   responseCode:200];
                AMOrder *order = [[AMOrder alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] deleteOrder:order completion:^(AMOrder *order, NSError *error) {
                    deletedOrder = order;
                }];
            });
            
            it(@"uses DELETE method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"DELETE"];
            });
            
            it(@"calls /orders/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"orders/1"]];
            });
            
            it(@"creates order object", ^{
                [[expectFutureValue(deletedOrder) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"order.json"]];
            });
        
        });
        
        context(@"on find order items", ^{
            __block NSURLSessionDataTask *task;
            __block NSArray *foundOrderItems;

            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"orders/1/order_items"]
                                     httpMethod:@"GET"
                             nameOfResponseFile:@"order_items.json"
                                   responseCode:200];
                
                AMOrder *order = [[AMOrder alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] findOrderItemsOfOrder:order completion:^(NSArray *orderItems, NSError *error) {
                    foundOrderItems = orderItems;
                }];
            });
            
            it(@"uses GET method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
        
            it(@"calls /orders/1/order_items", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"orders/1/order_items"]];
            });
            
            it(@"creates array of order items object", ^{
                [[expectFutureValue(foundOrderItems) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"order_items.json"]];
            });
        });
        
        context(@"on create order item", ^{
            __block NSURLSessionDataTask *task;
            __block AMOrderItem *createdOrderItem;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"orders/1/order_items"]
                                     httpMethod:@"POST"
                             nameOfResponseFile:@"order_item.json"
                                   responseCode:200];
                
                AMOrder *order = [[AMOrder alloc] initWithDictionary:@{@"identifier" : @1} error:nil];
                task = [[AMClient sharedClient] createOrderItemOfOrder:order withComment:@"acomm" count:@1 menuItemId:@"1" completion:^(AMOrderItem *orderItem, NSError *error) {
                    createdOrderItem = orderItem;
                }];
            });
            
            it(@"uses POST method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"POST"];
            });
            
            it(@"calls /orders/1/order_items", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"orders/1/order_items"]];
            });
            
            it(@"creates order item object", ^{
                [[expectFutureValue(createdOrderItem) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"order_item.json"]];
            });
            
            it(@"sends paramters in HTTP body", ^{
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"comment" : @"acomm", @"count" : @"1", @"menu_item_id" : @"1"}];
            });
        });
        
        context(@"on add payment", ^{
            __block NSURLSessionDataTask *task;
            __block NSString *receivedStatus;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"orders/1/payments"]
                                     httpMethod:@"POST"
                             nameOfResponseFile:@"payment.json"
                                   responseCode:200];
                AMOrder *order = [[AMOrder alloc] initWithDictionary:@{@"identifier" : @(1)} error:nil];
                task = [[AMClient sharedClient] createPaymentForORder:order
                                                     withCreditCardId:@"1"
                                                           completion:^(NSString *status, NSError *error) {
                                                               receivedStatus = status;
                                                           }];
            });
            
            it(@"uses POST method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"POST"];
            });
            
            it(@"calls /orders/1/order_items", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"orders/1/payments"]];
            });
            
            it(@"creates status object", ^{
                [[expectFutureValue(receivedStatus) shouldEventually] equal:@"success"];
            });
            
            it(@"sends parameters in HTTP body", ^{
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"credit_card_id" : @"1"}];
            });
        });
        
    });
});

SPEC_END