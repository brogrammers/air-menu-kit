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

@interface AMMenuItem : MTLModel <MTLJSONSerializing>
@property (nonatomic, strong, readonly) NSNumber *identifier;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *details;
@property (nonatomic, strong, readonly) NSNumber *price;
@property (nonatomic, strong, readonly) NSString *currency;
@property (nonatomic, strong, readonly) AMStaffKind *staffKind;
@property (nonatomic, strong, readonly) NSURL *avatar;
@end
