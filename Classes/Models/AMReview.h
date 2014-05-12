//
//  AMReview.h
//  AirMenuKit
//
//  Created by Robert Lis on 12/05/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "AMUser.h"

@interface AMReview : MTLModel <MTLJSONSerializing>
@property (nonatomic, readonly, strong) NSNumber *identifier;
@property (nonatomic, readonly, strong) NSString *subject;
@property (nonatomic, readonly, strong) NSString *message;
@property (nonatomic, readonly, strong) NSNumber *rating;
@property (nonatomic, readonly, strong) AMUser *user;
@end
