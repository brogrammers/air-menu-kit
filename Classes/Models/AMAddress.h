//
//  AMAddress.h
//  AirMenuKit
//
//  Created by Robert Lis on 03/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface AMAddress : MTLModel <MTLJSONSerializing>
@property (nonatomic, strong, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) NSDate *createdAt;
@property (nonatomic, strong, readonly) NSDate *updatedAt;
@property (nonatomic, strong, readonly) NSString *addressLine1;
@property (nonatomic, strong, readonly) NSString *addressLine2;
@property (nonatomic, strong, readonly) NSString *city;
@property (nonatomic, strong, readonly) NSString *county;
@property (nonatomic, strong, readonly) NSString *country; 
@end
