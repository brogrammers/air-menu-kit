//
//  AMUser.h
//  AirMenuKit
//
//  Created by Robert Lis on 09/03/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "AMCompany.h"

/**
 *  Type of the user, user - restaurant client, owner - company owner, staff member - part of restaurant staff.
 */

typedef enum {AMUserTypeUser, AMUserTypeOwner, AMUserTypeStaffMember} AMUserType;

/**
 *  AMUser respresents currently logged in user.
 */
@interface AMUser : MTLModel <MTLJSONSerializing>
/**
 *  Unique identifier.
 */
@property (nonatomic, readonly, strong) NSNumber *identifier;

/**
 *  Name of the user.
 */
@property (nonatomic, readonly, strong) NSString *name;

/**
 * Username of the user.
 */
@property (nonatomic, readonly, strong) NSString *username;

/**
 *  Count of unread notifications.
 */
@property (nonatomic, readonly, strong) NSNumber *unreadCount;

/**
 *  URL of the avatar picture of the user.
 */
@property (nonatomic, readonly, strong) NSURL *avatar;

/**
 *  Type of the user.
 */
@property (nonatomic, readonly) AMUserType type;

/**
 *  Telephone number of the user.
 */
@property (nonatomic, readonly, strong) NSString *phoneNumber;

/**
 *  Email address of the current user.
 */
@property (nonatomic, readonly, strong) NSString *email;

/**
 *  OAuthScopes associated with the current user.
 */
@property (nonatomic, readonly, strong) NSArray *scopes;

/**
 *  Company (if any) of the current user.
 */
@property (nonatomic, readonly, strong) AMCompany *company;

/**
 *  Orders associated with the current user.
 */
@property (nonatomic, readonly, strong) NSArray *currentOrders;
@end
