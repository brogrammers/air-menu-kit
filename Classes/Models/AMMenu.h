//
//  AMMenu.h
//  AirMenuKit
//
//  Created by Robert Lis on 03/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>


/**
 *  AMMenu represents a menu within a system. 
    Menu object belogs to a restaurant.
 */
@interface AMMenu : MTLModel <MTLJSONSerializing>

/**
 *  Unique identifier.
 */
@property (nonatomic, strong, readonly) NSNumber *identifier;

/**
 *  Menu name.
 */
@property (nonatomic, strong, readonly) NSString *name;

/**
 *  Sections of the menu.
 */
@property (nonatomic, strong, readonly) NSArray *menuSections;

/**
 *  Flag which which is set to @YES if this menu is currently active one.
 */
@property (nonatomic, strong, readonly) NSNumber *isActive;
@end
