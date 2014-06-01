//
//  AMMenuSection.h
//  AirMenuKit
//
//  Created by Robert Lis on 03/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "AMStaffKind.h"


/**
 *  AMMenuSection represents a section of a menu within the system.
    Menu section objects belongs to a menu.
 */
@interface AMMenuSection : MTLModel <MTLJSONSerializing>

/**
 *  Unique identifier.
 */
@property (nonatomic, strong, readonly) NSNumber *identifier;

/**
 *  Name of the menu section.
 */
@property (nonatomic, strong, readonly) NSString *name;

/**
 *  Description of the menu section.
 */
@property (nonatomic, strong, readonly) NSString *details;

/**
 *  Menu items of the menu section.
 */
@property (nonatomic, strong, readonly) NSArray *menuItems;

/**
 *  Staff kind responsible for handling this menu section.
 */
@property (nonatomic, strong, readonly) AMStaffKind *staffKind;
@end
