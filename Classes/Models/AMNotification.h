//
//  AMNotification.h
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface AMNotification : MTLModel <MTLJSONSerializing>
@property (nonatomic, readonly, strong) NSNumber *identifier;
@property (nonatomic, readonly, strong) NSString *content;
@property (nonatomic, readonly, strong) NSNumber *read;
@property (nonatomic, readonly, strong) NSString *payload;
@property (nonatomic, readonly, strong) NSDate *createdAt;
@end
