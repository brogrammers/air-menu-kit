//
//  AMOrder.h
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "AMRestaurant.h"
#import "AMUser.h"

/**
 *  State of the order, limits the calls that can be made on the object.
 */

typedef enum AMOrderState { AMOrderStateNone = 0,
                            AMOrderStateNew = 1,
                            AMOrderStateOpen = 2,
                            AMOrderStateApproved = 3,
                            AMOrderStateCancelled = 4,
                            AMOrderStateServed = 5,
                            AMOrderStatePaid = 6 } AMOrderState;

/**
 *  AMOrder respresents a single order within a system.
 */
@interface AMOrder : MTLModel <MTLJSONSerializing>

/**
 *  Unique identifier.
 */
@property (nonatomic, readonly, strong) NSNumber *identifier;

/**
 *  State of the order.
 */
@property (nonatomic, readonly) AMOrderState state;

/**
 *  Time at which the order has been approved - all order items were accepted by staff members.
 */
@property (nonatomic, readonly, strong) NSDate *approvedAt;

/**
 *  Time at which the order was server - a waitress brought all order items ot the table.
 */
@property (nonatomic, readonly, strong) NSDate *servedAt;

/**
 *  Time at which the order was cancelled - if so.
 */
@property (nonatomic, readonly, strong) NSDate *cancelledAt;

/**
 *  Restaurant the order was made at.
 */
@property (nonatomic, readonly, strong) AMRestaurant *restaurant;

/**
 *  User that created the order.
 */
@property (nonatomic, readonly, strong) AMUser *user;

/**
 *  All order items of this order.
 */
@property (nonatomic, readonly, strong) NSArray *orderItems;

/**
 *  Table at which the order is supposed to be served.
 */
@property (nonatomic, readonly, strong) NSString *tableNumber;

@end
