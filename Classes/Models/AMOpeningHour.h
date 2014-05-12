//
//  AMOpeningHour.h
//  AirMenuKit
//
//  Created by Robert Lis on 12/05/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface AMOpeningHour : MTLModel <MTLJSONSerializing>
@property (nonatomic, readonly, strong) NSNumber *identifier;
@property (nonatomic, readonly, strong) NSString *day;
@property (nonatomic, readonly, strong) NSDate *startTime;
@property (nonatomic, readonly, strong) NSDate *endTime;
@end
