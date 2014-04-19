//
//  AMMenu.h
//  AirMenuKit
//
//  Created by Robert Lis on 03/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface AMMenu : MTLModel <MTLJSONSerializing>
@property (nonatomic, strong, readonly) NSNumber *identifier;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSArray *menuSections;
@end
