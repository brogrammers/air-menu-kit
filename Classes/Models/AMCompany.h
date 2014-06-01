//
//  Company.h
//  AirMenuKit
//
//  Created by Robert Lis on 03/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "AMAddress.h"

/**
 * AMCompany represents a single company within the system
 */

@interface AMCompany : MTLModel <MTLJSONSerializing>

/**
 *  Unique identifier
 */
@property (nonatomic, strong, readonly) NSNumber *identifier;

/**
 *  Name of the company.
 */
@property (nonatomic, strong, readonly) NSString *name;

/**
 *  Address of the company.
 */
@property (nonatomic, strong, readonly) AMAddress *address;

/**
 *  Website URL of the company.
 */
@property (nonatomic, strong, readonly) NSURL *website;

@end
