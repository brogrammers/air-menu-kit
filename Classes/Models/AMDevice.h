//
//  AMDevice.h
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface AMDevice : MTLModel <MTLJSONSerializing>
@property (nonatomic, readonly, strong) NSNumber *identifier;
@property (nonatomic, readonly, strong) NSString *name;
@property (nonatomic, readonly, strong) NSString *uuid;
@property (nonatomic, readonly, strong) NSString *token;
@property (nonatomic, readonly, strong) NSString *platform;
@end
