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

@interface AMStaffMember : MTLModel <MTLJSONSerializing>
@property (nonatomic, readonly, strong) NSNumber *identifier;
@property (nonatomic, readonly, strong) NSString *name;
@property (nonatomic, readonly, strong) NSString *username;
@property (nonatomic, readonly, strong) NSString *email;
@property (nonatomic, readonly, strong) NSArray *scopes;
@property (nonatomic, readonly, strong) AMRestaurant *restaurant;
@property (nonatomic, readonly, strong) AMDevice *device;
@property (nonatomic, readonly, strong) AMGroup *group;
@property (nonatomic, readonly, strong) AMStaffKind *kind;
@property (nonatomic, readonly, strong) NSURL *avatar;
@end
