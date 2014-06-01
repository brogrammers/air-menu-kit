//
//  AMNotification.h
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Mantle/Mantle.h>

/**
 *  AMNotification that represents a notification sent to the user.
 */

@interface AMNotification : MTLModel <MTLJSONSerializing>

/**
 *  Unique identifier.
 */
@property (nonatomic, readonly, strong) NSNumber *identifier;

/**
 *  String content of the notification
 */
@property (nonatomic, readonly, strong) NSString *content;

/**
 *  Flag equal to @YES if notification has been read
 */
@property (nonatomic, readonly, strong) NSNumber *read;

/**
 *  Payload in JSON format.
 */
@property (nonatomic, readonly, strong) NSString *payload;

/**
 *  Time at which the notification was created.
 */
@property (nonatomic, readonly, strong) NSDate *createdAt;
@end
