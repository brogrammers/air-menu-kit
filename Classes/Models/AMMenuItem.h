//
//  AMMenuItem.h
//  AirMenuKit
//
//  Created by Robert Lis on 03/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "AMStaffKind.h"

/**
 *  AMMenuItem represents a orderable item within a system.
 *  Menu Item object belongs to a menu section.
 */
@interface AMMenuItem : MTLModel <MTLJSONSerializing>
/**
 *  Unique identifier.
 */
@property (nonatomic, strong, readonly) NSNumber *identifier;

/**
 *  Name of the menu section.
 */
@property (nonatomic, strong, readonly) NSString *name;

/**
 *  Description of the menu item.
 */
@property (nonatomic, strong, readonly) NSString *details;

/**
 *  Price of the menu item.
 */
@property (nonatomic, strong, readonly) NSNumber *price;

/**
 *  Currency of the menu item price.
 */
@property (nonatomic, strong, readonly) NSString *currency;

/**
 * Staff Kind responsible for handling this menu item.
 */
@property (nonatomic, strong, readonly) AMStaffKind *staffKind;

/**
 *  URL of the avatar picture of the menu item.
 */
@property (nonatomic, strong, readonly) NSURL *avatar;
@end
