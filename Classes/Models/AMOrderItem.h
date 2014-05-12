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

typedef enum AMOrderItemState { AMOrderItemStateNone = 0,
                                AMOrderItemStateNew = 1,
                                AMOrderItemStateApproved = 2,
                                AMOrderItemStateDeclined = 3 ,
                                AMOrderItemStateBeingPrepared = 4,
                                AMOrderItemStatePrepared = 5,
                                AMOrderItemStateServed = 6} AMOrderItemState;

@interface AMOrderItem : MTLModel <MTLJSONSerializing>
@property (nonatomic, readonly, strong) NSNumber *identifier;
@property (nonatomic, readonly, strong) NSString *comment;
@property (nonatomic, readonly, strong) NSNumber *count;
@property (nonatomic, readonly) AMOrderItemState state;
@property (nonatomic, readonly, strong) NSDate *approvedAt;
@property (nonatomic, readonly, strong) NSDate *declinedAt;
@property (nonatomic, readonly, strong) NSDate *prepareTimeStart;
@property (nonatomic, readonly, strong) NSDate *prepareTimeEnd;
@property (nonatomic, readonly, strong) NSDate *servedAt;
@property (nonatomic, readonly, strong) AMOrder *order;
@property (nonatomic, readonly, strong) AMMenuItem *menuItem;
@end
