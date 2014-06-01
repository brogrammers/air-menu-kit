//
//  StaffMember.h
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "AMRestaurant.h"
#import "AMDevice.h"
#import "AMGroup.h"
#import "AMStaffKind.h"

/**
 *  AMStaffMember represnts a restaurant staff.
 */
@interface AMStaffMember : MTLModel <MTLJSONSerializing>

/**
 *  Unique identifier.
 */
@property (nonatomic, readonly, strong) NSNumber *identifier;

/**
 *  Name of the staff member.
 */
@property (nonatomic, readonly, strong) NSString *name;

/**
 *  Username of the staff member.
 */
@property (nonatomic, readonly, strong) NSString *username;

/**
 *  Email address of the staff member.
 */
@property (nonatomic, readonly, strong) NSString *email;

/**
 *  Scopes of the staff member - rights within the system.
 */
@property (nonatomic, readonly, strong) NSArray *scopes;

/**
 *  Restauant the staff mamber belongs to.
 */
@property (nonatomic, readonly, strong) AMRestaurant *restaurant;

/**
 *  Device of the staff member.
 */
@property (nonatomic, readonly, strong) AMDevice *device;

/**
 *  Group the staff member belongs to - if any.
 */
@property (nonatomic, readonly, strong) AMGroup *group;

/**
 *  Staff Kind of the staff member.
 */
@property (nonatomic, readonly, strong) AMStaffKind *kind;

/**
 *  URL of the avatar of the staff member.
 */
@property (nonatomic, readonly, strong) NSURL *avatar;
@end
