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

@interface AMClient (Order)

-(NSURLSessionDataTask *)findOrderWithIdentifier:(NSString *)identifier
                                      completion:(OrderCompletion)completion;

-(NSURLSessionDataTask *)updateOrder:(AMOrder *)order
                            newState:(AMOrderState)state
                          completion:(OrderCompletion)completion;

-(NSURLSessionDataTask *)deleteOrder:(AMOrder *)order
                          completion:(OrderCompletion)completion;

/*
 Order > Order Items
 */

-(NSURLSessionDataTask *)findOrderItemsOfOrder:(AMOrder *)order
                                    completion:(OrderOrderItemsCompletion)completion;

-(NSURLSessionDataTask *)createOrderItemOfOrder:(AMOrder *)order
                                    withComment:(NSString *)comment
                                          count:(NSNumber *)count
                                     menuItemId:(NSString *)menuItemId
                                     completion:(OrderOrderItemCompletion)completion;

@end
