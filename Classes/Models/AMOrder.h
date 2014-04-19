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

typedef enum AMOrderState { AMOrderStateNew,
                            AMOrderStateOpen,
                            AMOrderStateApproved,
                            AMOrderStateCancelled,
                            AMOrderStateServed,
                            AMOrderStatePaid  } AMOrderState;

@interface AMOrder : MTLModel <MTLJSONSerializing>
@property (nonatomic, readonly, strong) NSNumber *identifier;
@property (nonatomic, readonly) AMOrderState state;
@property (nonatomic, readonly, strong) NSDate *approvedAt;
@property (nonatomic, readonly, strong) NSDate *servedAt;
@property (nonatomic, readonly, strong) NSDate *cancelledAt;
@property (nonatomic, readonly, strong) AMRestaurant *restaurant;
@property (nonatomic, readonly, strong) AMUser *user;
@property (nonatomic, readonly, strong) NSArray *orderItems;
@end
