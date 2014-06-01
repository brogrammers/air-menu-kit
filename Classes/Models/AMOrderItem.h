//
//  OrderItem.h
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "AMOrder.h"
#import "AMMenuItem.h"

/**
 *  State of the order item, limits the calls that can be made on the object.
 */

typedef enum AMOrderItemState { AMOrderItemStateNone = 0,
                                AMOrderItemStateNew = 1,
                                AMOrderItemStateApproved = 2,
                                AMOrderItemStateDeclined = 3 ,
                                AMOrderItemStateBeingPrepared = 4,
                                AMOrderItemStatePrepared = 5,
                                AMOrderItemStateServed = 6} AMOrderItemState;

/**
 *  AMOrderItem represents a menu item that has been ordered.
 *  Every order item belongs to an order.
 */
@interface AMOrderItem : MTLModel <MTLJSONSerializing>

/**
 *  Unique identifier.
 */
@property (nonatomic, readonly, strong) NSNumber *identifier;

/**
 *  Comment made by customer when submitting the order item.
 */
@property (nonatomic, readonly, strong) NSString *comment;

/**
 *  How many menu items have been ordered.
 */
@property (nonatomic, readonly, strong) NSNumber *count;

/**
 *  State of the order item.
 */
@property (nonatomic, readonly) AMOrderItemState state;

/**
 *  Time at which the order item was approved by the staff memver.
 */
@property (nonatomic, readonly, strong) NSDate *approvedAt;

/**
 *  Time at which ( if so ) the order item was declined.
 */
@property (nonatomic, readonly, strong) NSDate *declinedAt;

/**
 *  Time at which the order item started being prepared.
 */
@property (nonatomic, readonly, strong) NSDate *prepareTimeStart;

/**
 *  Time at which the order item was done preparing.
 */
@property (nonatomic, readonly, strong) NSDate *prepareTimeEnd;

/**
 *  Time at which the order item was served.
 */
@property (nonatomic, readonly, strong) NSDate *servedAt;

/**
 *  Order the order item belongs to.
 */
@property (nonatomic, readonly, strong) AMOrder *order;

/**
 *  Menu item this order item refers to.
 */
@property (nonatomic, readonly, strong) AMMenuItem *menuItem;
@end
