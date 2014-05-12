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

typedef enum {AMUserTypeUser, AMUserTypeOwner, AMUserTypeStaffMember} AMUserType;

@interface AMUser : MTLModel <MTLJSONSerializing>
@property (nonatomic, readonly, strong) NSNumber *identifier;
@property (nonatomic, readonly, strong) NSString *name;
@property (nonatomic, readonly, strong) NSString *username;
@property (nonatomic, readonly, strong) NSNumber *unreadCount;
@property (nonatomic, readonly, strong) NSURL *avatar;
@property (nonatomic, readonly) AMUserType type;
@property (nonatomic, readonly, strong) NSString *phoneNumber;
@property (nonatomic, readonly, strong) NSString *email;
@property (nonatomic, readonly, strong) NSArray *scopes;
@property (nonatomic, readonly, strong) AMCompany *company;
@property (nonatomic, readonly, strong) NSArray *currentOrders;
@end
