//
//  AMRestaurant.h
//  AirMenuKit
//
//  Created by Robert Lis on 03/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "AMAddress.h"
#import "AMMenu.h"
#import "AMLocation.h"

/**
 *  AMRestaurant represents a single restaurant within a system.
    Every restaurant belongs to a single company.
 */
@interface AMRestaurant : MTLModel <MTLJSONSerializing>

/**
 *  Unique identifier.
 */
@property (nonatomic, strong, readonly) NSNumber *identifier;

/**
 *  Name of the restaurant.
 */
@property (nonatomic, strong, readonly) NSString *name;

/**
 *  Is loyality program on.
 */
@property (nonatomic, strong, readonly) NSNumber *loyalty;

/**
 *  Is remote order in on.
 */
@property (nonatomic, strong, readonly) NSNumber *remoteOrder;

/**
 *  Are points available.
 */
@property (nonatomic, strong, readonly) NSNumber *conversionRate;

/**
 *  Restaurant's average user raiting.
 */
@property (nonatomic, strong, readonly) NSNumber *rating;

/**
 *  Kind of restaurant e.g. mexican.
 */
@property (nonatomic, strong, readonly) NSString *category;

/**
 *  Address of the restaurant.
 */
@property (nonatomic, strong, readonly) AMAddress *address;

/**
 *  Current active menu of the restaurant.
 */
@property (nonatomic, strong, readonly) AMMenu *menu;

/**
 *  Geographical location of the restaurant.
 */
@property (nonatomic, strong, readonly) AMLocation *location;

/**
 *  URL of restaurant avatar picture.
 */
@property (nonatomic, strong, readonly) NSURL *avatar;
@end
