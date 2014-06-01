//
//  StaffKind.h
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "AMRestaurant.h"

/**
 *  AMStaffKind represents a type of staff member.
 */
@interface AMStaffKind : MTLModel <MTLJSONSerializing>

/**
 *  Unique identifier.
 */
@property (nonatomic, readonly, strong) NSNumber *identifier;

/**
 *  Name of the staff kind.
 */
@property (nonatomic, readonly, strong) NSString *name;

/**
 *  Restaurant the staff kind belongs to.
 */
@property (nonatomic, readonly, strong) AMRestaurant *restaurant;

/**
 *  Scopes - rights this staff kind posseses.
 */
@property (nonatomic, readonly, strong) NSArray *scopes;

/**
 *  Members associated with this staff kind.
 */
@property (nonatomic, readonly, strong) NSArray *members;

/**
 *  Flag which shows if this staff kind can handle orders.
 */
@property (nonatomic, readonly, strong) NSNumber *acceptsOrders;

/**
 *  Flag which shows if the staff kind can handle preparation of order items.
 */
@property (nonatomic, readonly, strong) NSNumber *acceptsOrderItems;
@end
