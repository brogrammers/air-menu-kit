//
//  AMOpeningHour.h
//  AirMenuKit
//
//  Created by Robert Lis on 12/05/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Mantle/Mantle.h>

/**
 *  AMOpeningHour represents daily time range at which restaurant is opened.
 */
@interface AMOpeningHour : MTLModel <MTLJSONSerializing>
/**
 *  Unique identifier.
 */
@property (nonatomic, readonly, strong) NSNumber *identifier;

/**
 *  Which day this hour refers to.
 */
@property (nonatomic, readonly, strong) NSString *day;

/**
 *  Opening time.
 */
@property (nonatomic, readonly, strong) NSDate *startTime;

/**
 *  Closing time.
 */
@property (nonatomic, readonly, strong) NSDate *endTime;
@end
