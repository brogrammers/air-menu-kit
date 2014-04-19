//
//  StaffKind.h
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "AMRestaurant.h"

@interface AMStaffKind : MTLModel <MTLJSONSerializing>
@property (nonatomic, readonly, strong) NSNumber *identifier;
@property (nonatomic, readonly, strong) NSString *name;
@property (nonatomic, readonly, strong) AMRestaurant *restaurant;
@property (nonatomic, readonly, strong) NSArray *scopes;
@property (nonatomic, readonly) NSNumber *acceptsOrders;
@property (nonatomic, readonly) NSNumber *acceptsOrderItems;
@end
