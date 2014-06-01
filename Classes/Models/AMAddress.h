//
//  AMAddress.h
//  AirMenuKit
//
//  Created by Robert Lis on 03/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

/**
 *  AMAddress object represents a a physical address of restaurant or company.
 */

@interface AMAddress : MTLModel <MTLJSONSerializing>
/**
 *  Unique identifier
 */
@property (nonatomic, strong, readonly) NSNumber *identifier;
/**
 *  First line of address
 */
@property (nonatomic, strong, readonly) NSString *addressLine1;
/**
 *  Second line of address
 */
@property (nonatomic, strong, readonly) NSString *addressLine2;
/**
 *  City
 */
@property (nonatomic, strong, readonly) NSString *city;
/**
 *  County
 */
@property (nonatomic, strong, readonly) NSString *county;
/**
 *  Country
 */
@property (nonatomic, strong, readonly) NSString *country; 
@end
