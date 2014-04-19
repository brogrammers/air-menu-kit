//
//  AMClient+Order.m
//  AirMenuKit
//
//  Created by Robert Lis on 19/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient+Order.h"
#import "AMObjectBuilder.h"

@implementation AMClient (Order)
-(NSURLSessionDataTask *)findOrderWithIdentifier:(NSString *)identifier
                                      completion:(OrderCompletion)completion
{
    NSAssert(identifier, @"identifier cannot be nil");
    NSString *urlString = [@"orders/" stringByAppendingString:identifier];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMOrder *order = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(order, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)updateOrder:(AMOrder *)order
                            newState:(AMOrderState)state
                          completion:(OrderCompletion)completion
{
   NSAssert(order.identifier, @"orders identifier cannot be nil");
   NSString *urlString = [@"orders/" stringByAppendingString:order.identifier.description];
   NSDictionary *states =  @{@(AMOrderStateNew) : @"new",
                             @(AMOrderStateOpen) : @"open",
                             @(AMOrderStateApproved) : @"approved",
                             @(AMOrderStateCancelled) : @"cancelled",
                             @(AMOrderStateServed) : @"served",
                             @(AMOrderStatePaid) : @"paid"};
    return [self  PUT:urlString
           parameters:@{@"state" : states[@(state)]}
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  AMOrder *order = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                  if(completion) completion(order, nil);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if(completion) completion(nil, error);
              }];
}

-(NSURLSessionDataTask *)deleteOrder:(AMOrder *)order
                          completion:(OrderCompletion)completion
{
    NSAssert(order.identifier, @"orders identifier cannot be nil");
    NSString *urlString = [@"orders/" stringByAppendingString:order.identifier.description];
    return [self DELETE:urlString
             parameters:nil
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    AMOrder *order = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                    if(completion) completion(order, nil);
                }
                failure:^(NSURLSessionDataTask *task, NSError *error) {
                    if(completion) completion(nil, error);
                }];
}

/*
 Order > Order Items
 */

-(NSURLSessionDataTask *)findOrderItemsOfOrder:(AMOrder *)order
                                    completion:(OrderOrderItemsCompletion)completion
{
    NSAssert(order.identifier, @"orders identifier cannot be nil");
    NSString *urlString = [NSString stringWithFormat:@"orders/%@/order_items", order.identifier.description];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSArray *orderItems = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(orderItems, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)createOrderItemOfOrder:(AMOrder *)order
                                    withComment:(NSString *)comment
                                          count:(NSNumber *)count
                                     menuItemId:(NSString *)menuItemId
                                     completion:(OrderOrderItemCompletion)completion
{
    NSAssert(order.identifier, @"orders identifier cannot be nil");
    NSString *urlString = [NSString stringWithFormat:@"orders/%@/order_items", order.identifier.description];
    NSDictionary *params = @{@"comment" : comment, @"count" : count, @"menu_item_id" : menuItemId};
    return [self POST:urlString
           parameters:params
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  AMOrderItem *orderItem = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                  if(completion) completion(orderItem, nil);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if(completion) completion(nil, error);
              }];
}

@end
