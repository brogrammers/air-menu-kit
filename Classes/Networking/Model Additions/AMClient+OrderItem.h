//
//  AMClient+OrderItem.h
//  AirMenuKit
//
//  Created by Robert Lis on 19/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient.h"
#import "AMOrderItem.h"

typedef void (^OrderItemCompletion)(AMOrderItem *order, NSError *error);

@interface AMClient (OrderItem)

/**
 *  GET /order_items/:id
 *
 *  @param identifier identifier of the order item - required
 *  @param completion block to execute upon completion
 *
 *  @return spawned data task
 */
-(NSURLSessionDataTask *)findOrderItemWithIdentifier:(NSString *)identifier
                                          completion:(OrderItemCompletion)completion;

/**
 *  PUT /order_items/:id
 *
 *  @param orderItem  order item to update - required
 *  @param comment    new order item comment
 *  @param count      new order item count
 *  @param state      new order item state
 *  @param completion block to execute upon completion
 *
 *  @return spawned data task
 */
-(NSURLSessionDataTask *)updateOrderItem:(AMOrderItem *)orderItem
                          withNewComment:(NSString *)comment
                                newCount:(NSNumber *)count
                                newState:(AMOrderItemState)state
                              completion:(OrderItemCompletion)completion;

/**
 *  DELETE /order_items/:id
 *
 *  @param orderItem  order item do delete - required
 *  @param completion block to execute upon completion
 *
 *  @return spawned data task.
 */
-(NSURLSessionDataTask *)deleteOrderItem:(AMOrderItem *)orderItem
                              completion:(OrderItemCompletion)completion;

@end
