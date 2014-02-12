//
//  AMUser.h
//  AirMenuKit
//
//  Created by Robert Lis on 12/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AMUser <NSObject>
@property (nonatomic, readonly, strong) NSString *username;
@property (nonatomic, readonly, strong) NSString *password;
@end
