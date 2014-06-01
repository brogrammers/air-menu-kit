//
//  AMReview.h
//  AirMenuKit
//
//  Created by Robert Lis on 12/05/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "AMUser.h"


/**
 *  AMReview represents a review submitted by a user.
 */
@interface AMReview : MTLModel <MTLJSONSerializing>

/**
 *  Unique identifier.
 */
@property (nonatomic, readonly, strong) NSNumber *identifier;

/**
 *  Title of the review.
 */
@property (nonatomic, readonly, strong) NSString *subject;

/**
 *  Contents of the review.
 */
@property (nonatomic, readonly, strong) NSString *message;

/**
 *  Rating as indicated by reviewer.
 */
@property (nonatomic, readonly, strong) NSNumber *rating;

/**
 *  User that submitted this review.
 */
@property (nonatomic, readonly, strong) AMUser *user;
@end
