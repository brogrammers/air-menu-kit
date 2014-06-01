//
//  AMGroup.h
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "AMDevice.h"

/**
 *  AMGroup object represents a set of StaffMembers grouped together.
 */
@interface AMGroup : MTLModel <MTLJSONSerializing>

/**
 *  Unique identifier.
 */
@property (nonatomic, readonly, strong) NSNumber *identifier;

/**
 *  Name of the group.
 */
@property (nonatomic, readonly, strong) NSString *name;

/**
 *  Staff members of the group.
 */
@property (nonatomic, readonly, strong) NSArray *staffMembers;

/**
 *  Device associated with the group.
 */
@property (nonatomic, readonly, strong) AMDevice *device;
@end
