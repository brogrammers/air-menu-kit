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

-(NSURLSessionDataTask *)findOrderItemWithIdentifier:(NSString *)identifier
                                          completion:(OrderItemCompletion)completion;

-(NSURLSessionDataTask *)updateOrderItem:(AMOrderItem *)orderItem
                          withNewComment:(NSString *)comment
                                newCount:(NSNumber *)count
                                newState:(AMOrderItemState)state
                              completion:(OrderItemCompletion)completion;

-(NSURLSessionDataTask *)deleteOrderItem:(AMOrderItem *)orderItem
                              completion:(OrderItemCompletion)completion;

@end
