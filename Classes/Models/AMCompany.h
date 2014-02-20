//
//  Company.h
//  AirMenuKit
//
//  Created by Robert Lis on 03/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "AMAddress.h"

@interface AMCompany : MTLModel <MTLJSONSerializing>
@property (nonatomic, strong, readonly) NSNumber *identifier;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) AMAddress *address;
@property (nonatomic, strong, readonly) NSURL *website;
@end
