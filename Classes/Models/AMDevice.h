//
//  AMDevice.h
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Mantle/Mantle.h>

/**
 * AMDevice represents a device registered.
 */
@interface AMDevice : MTLModel <MTLJSONSerializing>

/**
 *  Unique identifier
 */
@property (nonatomic, readonly, strong) NSNumber *identifier;

/**
 *  Name of the device.
 */
@property (nonatomic, readonly, strong) NSString *name;

/**
 *  UUID string of the device
 */
@property (nonatomic, readonly, strong) NSString *uuid;

/**
 *  Access token string of the device
 */
@property (nonatomic, readonly, strong) NSString *token;

/**
 *  Plafrom this device runs on (iOS, Android)
 */
@property (nonatomic, readonly, strong) NSString *platform;
@end
