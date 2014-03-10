//
//  AMUser.h
//  AirMenuKit
//
//  Created by Robert Lis on 09/03/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface AMUser : MTLModel <MTLJSONSerializing>
@property (nonatomic, readonly, strong) NSNumber *identifier;
@property (nonatomic, readonly, strong) NSString *name;
@property (nonatomic, readonly, strong) NSString *username;
@property (nonatomic, readonly, strong) NSString *type;
@property (nonatomic, readonly, strong) NSString *email;
@property (nonatomic, readonly, strong) NSArray *scopes;
@end
