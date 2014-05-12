//
//  AMClient+OrderItem.m
//  AirMenuKit
//
//  Created by Robert Lis on 19/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient+OrderItem.h"
#import "AMObjectBuilder.h"

@implementation AMClient (OrderItem)
-(NSURLSessionDataTask *)findOrderItemWithIdentifier:(NSString *)identifier
                                          completion:(OrderItemCompletion)completion
{
    NSAssert(identifier, @"identifier cannot be nil");
    NSString *urlString = [@"order_items/" stringByAppendingString:identifier];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMOrderItem *orderItem = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(orderItem, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)updateOrderItem:(AMOrderItem *)orderItem
                          withNewComment:(NSString *)comment
                                newCount:(NSNumber *)count
                                newState:(AMOrderItemState)state
                              completion:(OrderItemCompletion)completion
{
    NSAssert(orderItem.identifier, @"identifier cannot be nil");
    NSString *urlString = [@"order_items/" stringByAppendingString:orderItem.identifier.description];
    NSDictionary *states = @{@(AMOrderItemStateNew) : @"new",
                             @(AMOrderItemStateApproved) : @"approved",
                             @(AMOrderItemStateDeclined) : @"declined",
                             @(AMOrderItemStateBeingPrepared) : @"start_prepare",
                             @(AMOrderItemStatePrepared) : @"end_prepare",
                             @(AMOrderItemStateServed) : @"served"};
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(comment) [params setObject:comment forKey:@"comment"];
    if(count) [params setObject:count forKey:@"count"];
    if(state != AMOrderItemStateNone) [params setObject:states[@(state)] forKey:@"state"];
    
    return [self PUT:urlString
          parameters:params
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMOrderItem *orderItem = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(orderItem, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)deleteOrderItem:(AMOrderItem *)orderItem
                              completion:(OrderItemCompletion)completion
{
    NSAssert(orderItem.identifier, @"identifier cannot be nil");
    NSString *urlString = [@"order_items/" stringByAppendingString:orderItem.identifier.description];
    return [self DELETE:urlString
             parameters:nil
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    AMOrderItem *orderItem = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                    if(completion) completion(orderItem, nil);
                }
                failure:^(NSURLSessionDataTask *task, NSError *error) {
                    if(completion) completion(nil, error);
                }];
}
@end
