//
//  AMClient+Order.h
//  AirMenuKit
//
//  Created by Robert Lis on 19/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient.h"
#import "AMOrder.h"
#import "AMOrderItem.h"

typedef void (^OrderCompletion)(AMOrder *order, NSError *error);
typedef void (^OrderOrderItemsCompletion) (NSArray *orderItems, NSError *error);
typedef void (^OrderOrderItemCompletion) (AMOrderItem *orderItem, NSError *error);
typedef void (^OrderPaymentStatus)(NSString *status, NSError *error);

@interface AMClient (Order)

/**
 *  GET /orders/:id
 *
 *  @param identifier order identifier - required
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)findOrderWithIdentifier:(NSString *)identifier
                                      completion:(OrderCompletion)completion;

/**
 *  PUT /orders/:id
 *
 *  @param order      order to update - required
 *  @param state      new order state
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */

-(NSURLSessionDataTask *)updateOrder:(AMOrder *)order
                            newState:(AMOrderState)state
                          completion:(OrderCompletion)completion;

/**
 *  DELETE /orders/:id
 *
 *  @param order      order to delete - required
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)deleteOrder:(AMOrder *)order
                          completion:(OrderCompletion)completion;

/**
 *  GET /orders/:id/order_items
 *
 *  @param order      order of items - required
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)findOrderItemsOfOrder:(AMOrder *)order
                                    completion:(OrderOrderItemsCompletion)completion;

/**
 *  POST /orders/:id/order_items
 *
 *  @param order      order to create order item for - required
 *  @param comment    users comment
 *  @param count      count of menu item
 *  @param menuItemId menu item id of order item
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)createOrderItemOfOrder:(AMOrder *)order
                                    withComment:(NSString *)comment
                                          count:(NSNumber *)count
                                     menuItemId:(NSString *)menuItemId
                                     completion:(OrderOrderItemCompletion)completion;

/**
 *  POST /orders/id/paymentes
 *
 *  @param order        order to pay for - required
 *  @param creditCardId identifier of credit card to use
 *  @param completion   block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)createPaymentForORder:(AMOrder *)order
                              withCreditCardId:(NSString *)creditCardId
                                    completion:(OrderPaymentStatus)completion;

@end
